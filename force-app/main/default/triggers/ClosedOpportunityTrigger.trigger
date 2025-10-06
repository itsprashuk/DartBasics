trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> followUpTasks = new List<Task>();

    for (Opportunity opp : Trigger.new) {
        Boolean isClosedWonNow = opp.StageName == 'Closed Won';
        Boolean wasClosedWonBefore = false;

        if (Trigger.isUpdate) {
            Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
            wasClosedWonBefore = oldOpp != null && oldOpp.StageName == 'Closed Won';
        }

        if (isClosedWonNow && (!Trigger.isUpdate || !wasClosedWonBefore)) {
            followUpTasks.add(new Task(
                Subject = 'Follow Up Test Task',
                WhatId = opp.Id
            ));
        }
    }

    if (!followUpTasks.isEmpty()) {
        insert followUpTasks;
    }
}
