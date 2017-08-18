Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750971AbdHRMNc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 08:13:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7IC9TpY041236
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2017 08:13:32 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2cdu3xqcqg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2017 08:13:31 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <dougmill@linux.vnet.ibm.com>;
        Fri, 18 Aug 2017 08:13:30 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v7ICDSWH25886846
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2017 12:13:28 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54434112034
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2017 08:13:17 -0400 (EDT)
Received: from oc5780617838.ibm.com (unknown [9.80.103.170])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP id 2D071112040
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2017 08:13:17 -0400 (EDT)
Subject: Re: Long delays for I/Os using CFQ scheduler
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
To: linux-block@vger.kernel.org
References: <ceff1cc8-0e41-7b49-e3a9-f2cc626561e4@linux.vnet.ibm.com>
Date: Fri, 18 Aug 2017 07:13:27 -0500
MIME-Version: 1.0
In-Reply-To: <ceff1cc8-0e41-7b49-e3a9-f2cc626561e4@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <29933b2e-1abf-9bda-d1d7-47efc3d04973@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/15/2017 10:20 AM, Douglas Miller wrote:
> I present a lot of information here, hopefully it is not too much. 
> Perhaps this should be put in a bugzilla. I'm not familiar with CFQ, 
> or other I/O schedulers, so have been doing more generic debugging.
>
> PROBLEM:
>
> I am observing some undesirable behavior in the CFQ I/O scheduler. I 
> am seeing that a subset of the I/Os are experiencing much longer 
> delays than the rest. The behavior is not observed when using the 
> "deadline" scheduler.
>
> BACKGROUND:
>
> I am running on Ubuntu Zesty using kernel 4.10.0-30, with the commit 
> mentioned next. Ubuntu sets the default I/O scheduler to "cfq".
>
> I am running the POWER architecture test suite "HTX" 
> (https://github.com/open-power/HTX), and only certain phases of that 
> test seem to perturb CFQ. During these phases, I see that a small 
> percentage of the total I/Os are getting delayed. Without commit 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5be6b75610cefd1e21b98a218211922c2feb6e08 
> I, of course, see very long delays (sometimes over an hour). With that 
> commit, the delays seem to max-out around 110 seconds - which to me 
> still seems too long. HTX monitors each I/O's progress, and will start 
> complaining if an I/O takes longer than 10 minutes to complete. With 
> this commit, no I/Os seem to reach that 10 minute threshold and so HTX 
> no longer complains.
>
> In HTX, I am running the I/O-only variation (mdt.io) and in addition I 
> disable all devices except for a few disks (otherwise unused). Early 
> debugging showed that, in the case of the delayed I/Os, the delay is 
> due to the I/O not getting submitted to the SCSI layer 
> (scsi_dispatch_cmd). When the I/O eventually does get submitted to 
> SCSI, it completes promptly.
>
> The test phase was shown to be using only __blkdev_direct_IO_simple, 
> so I put the debugging in that path. I replaced the call to 
> io_schedule() with a debug routine that calls "io_schedule_timeout(HZ 
> * 60)". If the timeout trips, then some debugging info is printed and 
> io_schedule() is called to wait for eventual completion. Upon 
> completion of a timed-out I/O, more debug is printed - including the 
> total time elapsed. If no timeout occurs, no debugging is done.
>
> OBSERVATIONS:
>
> The period where I observe delayed I/Os seems to span about 2 hours. 
> During that time, between 400-500 I/Os trip the 60-second timeout (4 
> disks under test). It is estimated that about 2 million I/Os (per 
> disk) occur during this interval. Earlier testing showed that a 
> timeout of 30 seconds traps many more I/Os, so it is likely that the 
> delays experienced by I/Os varies over the full range.
>
> Both reads and writes can experience these delays, although most of 
> the I/Os going on are reads.
>
> What I am observing is that when HTX first starts (when it ramps-up 
> enough) I/Os will start tripping the timeout. In this first phase, the 
> I/Os seem to all complete in less than 70 seconds. The next phase is 
> not reached for another 10 hours, but at that time the maximum I/O 
> delay is over 90 seconds. Each successive phase shows maximum delay 
> values that, in general, increase. The 6th cycle I observed over 110 
> second delays, after which that maximum value declined. The 10th cycle 
> (last one collected), showed a maximum of just under 100 seconds.
>
> Test runs with the scheduler set to "deadline" never tripped the timeout.
>
> QUESTIONS:
>
> Is this behavior expected/correct? Are there other commits that might 
> address this? Is there more information I can provide to help diagnose?
>
> My concern is that certain processes/threads are getting unfairly 
> delayed due to this behavior.
>
>
> Thanks,
>
> Doug
>
Some additional information. Without any patches, I see delays exceeding 
the 10-minute HTX threshold. With only this patch:

5be6b75610cefd1e21b98a218211922c2feb6e08 "cfq-iosched: fix the delay of 
cfq_group's vdisktime under iops mode"

I see some improvement of the I/Os delays (all are below 2 minutes), 
although I think the delays are still too long. But by adding these two 
patches:

4d608baac5f4e72b033a122b2d6d9499532c3afc "block: Initialize 
cfqq->ioprio_class in cfq_get_queue()"
142bbdfccc8b3e9f7342f2ce8422e76a3b45beae "cfq: Disable writeback 
throttling by default"

I regress back to the  long delays exceeding 10 minutes. I am guessing 
it is the writeback throttling patch which is causing the regression, 
but I don't understand enough of this code to see why.

Does anyone have information on CFQ scheduler and how to address these 
delays?
