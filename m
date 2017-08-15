Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45183 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752552AbdHOPUX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2017 11:20:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7FFJiYY011153
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2017 11:20:23 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2cbwxtfs7p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2017 11:20:23 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <dougmill@linux.vnet.ibm.com>;
        Tue, 15 Aug 2017 09:20:22 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v7FFKJZH27852876
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2017 08:20:19 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2664BE03B
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2017 09:20:19 -0600 (MDT)
Received: from oc5780617838.ibm.com (unknown [9.10.86.144])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP id 8C9D0BE04A
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2017 09:20:19 -0600 (MDT)
To: linux-block@vger.kernel.org
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Subject: Long delays for I/Os using CFQ scheduler
Date: Tue, 15 Aug 2017 10:20:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ceff1cc8-0e41-7b49-e3a9-f2cc626561e4@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I present a lot of information here, hopefully it is not too much. 
Perhaps this should be put in a bugzilla. I'm not familiar with CFQ, or 
other I/O schedulers, so have been doing more generic debugging.

PROBLEM:

I am observing some undesirable behavior in the CFQ I/O scheduler. I am 
seeing that a subset of the I/Os are experiencing much longer delays 
than the rest. The behavior is not observed when using the "deadline" 
scheduler.

BACKGROUND:

I am running on Ubuntu Zesty using kernel 4.10.0-30, with the commit 
mentioned next. Ubuntu sets the default I/O scheduler to "cfq".

I am running the POWER architecture test suite "HTX" 
(https://github.com/open-power/HTX), and only certain phases of that 
test seem to perturb CFQ. During these phases, I see that a small 
percentage of the total I/Os are getting delayed. Without commit 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5be6b75610cefd1e21b98a218211922c2feb6e08 
I, of course, see very long delays (sometimes over an hour). With that 
commit, the delays seem to max-out around 110 seconds - which to me 
still seems too long. HTX monitors each I/O's progress, and will start 
complaining if an I/O takes longer than 10 minutes to complete. With 
this commit, no I/Os seem to reach that 10 minute threshold and so HTX 
no longer complains.

In HTX, I am running the I/O-only variation (mdt.io) and in addition I 
disable all devices except for a few disks (otherwise unused). Early 
debugging showed that, in the case of the delayed I/Os, the delay is due 
to the I/O not getting submitted to the SCSI layer (scsi_dispatch_cmd). 
When the I/O eventually does get submitted to SCSI, it completes promptly.

The test phase was shown to be using only __blkdev_direct_IO_simple, so 
I put the debugging in that path. I replaced the call to io_schedule() 
with a debug routine that calls "io_schedule_timeout(HZ * 60)". If the 
timeout trips, then some debugging info is printed and io_schedule() is 
called to wait for eventual completion. Upon completion of a timed-out 
I/O, more debug is printed - including the total time elapsed. If no 
timeout occurs, no debugging is done.

OBSERVATIONS:

The period where I observe delayed I/Os seems to span about 2 hours. 
During that time, between 400-500 I/Os trip the 60-second timeout (4 
disks under test). It is estimated that about 2 million I/Os (per disk) 
occur during this interval. Earlier testing showed that a timeout of 30 
seconds traps many more I/Os, so it is likely that the delays 
experienced by I/Os varies over the full range.

Both reads and writes can experience these delays, although most of the 
I/Os going on are reads.

What I am observing is that when HTX first starts (when it ramps-up 
enough) I/Os will start tripping the timeout. In this first phase, the 
I/Os seem to all complete in less than 70 seconds. The next phase is not 
reached for another 10 hours, but at that time the maximum I/O delay is 
over 90 seconds. Each successive phase shows maximum delay values that, 
in general, increase. The 6th cycle I observed over 110 second delays, 
after which that maximum value declined. The 10th cycle (last one 
collected), showed a maximum of just under 100 seconds.

Test runs with the scheduler set to "deadline" never tripped the timeout.

QUESTIONS:

Is this behavior expected/correct? Are there other commits that might 
address this? Is there more information I can provide to help diagnose?

My concern is that certain processes/threads are getting unfairly 
delayed due to this behavior.


Thanks,

Doug
