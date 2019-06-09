Return-Path: <SRS0=xEhu=UI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDA5C28EBD
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 18:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1858320652
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 18:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfFISOc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jun 2019 14:14:32 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48255 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729396AbfFISOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jun 2019 14:14:32 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x59IENgH031027
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 9 Jun 2019 14:14:24 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A0FBC420481; Sun,  9 Jun 2019 14:14:23 -0400 (EDT)
Date:   Sun, 9 Jun 2019 14:14:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Omar Sandoval <osandov@fb.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-block@vger.kernel.org
Subject: [REGRESSION] commit c2b3c170db610 causes blktests block/002 failure
Message-ID: <20190609181423.GA24173@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I recently noticed that block/002 from blktests started failing:

root@kvm-xfstests:~# cd blktests/
root@kvm-xfstests:~/blktests# ./check block/002
block/002 (remove a device while running blktrace)          
    runtime  ...
[   12.598314] run blktests block/002 at 2019-06-09 13:09:00
[   12.621298] scsi host0: scsi_debug: version 0188 [20190125]
[   12.621298]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
[   12.625578] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0188 PQ: 0 ANSI: 7
[   12.627109] sd 0:0:0:0: Power-on or device reset occurred
[   12.630322] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   12.634693] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
[   12.638881] sd 0:0:0:0: [sda] Write Protect is off
[   12.639464] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
[   12.646951] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   12.658210] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
[   12.722771] sd 0:0:0:0: [sda] Attached SCSI disk
block/002 (remove a device while running blktrace)           [failed]left
    runtime  ...  0.945s0: [sda] Synchronizing SCSI cache
    --- tests/block/002.out	2019-05-27 13:52:17.000000000 -0400
    +++ /root/blktests/results/nodev/block/002.out.bad	2019-06-09 13:09:01.034094065 -0400
    @@ -1,2 +1,3 @@
     Running block/002
    +debugfs directory leaked
     Test complete
root@kvm-xfstests:~/blktests# 

The git bisect log (see attached) pointed at this commit:

commit c2b3c170db610896e4e633cba2135045333811c2 (HEAD, refs/bisect/bad)
Author: Andi Kleen <ak@linux.intel.com>
Date:   Tue Mar 26 15:18:20 2019 -0700

    perf stat: Revert checks for duration_time
    
    This reverts e864c5ca145e ("perf stat: Hide internal duration_time
    counter") but doing it manually since the code has now moved to a
    different file.
    
    The next patch will properly implement duration_time as a full event, so
    no need to hide it anymore.
    
    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Acked-by: Jiri Olsa <jolsa@kernel.org>
    Link: http://lkml.kernel.org/r/20190326221823.11518-2-andi@firstfloor.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Is this a known issue?

Thanks,

						- Ted

git bisect start
# good: [e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd] Linux 5.1
git bisect good e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
# bad: [cd6c84d8f0cdc911df435bb075ba22ce3c605b07] Linux 5.2-rc2
git bisect bad cd6c84d8f0cdc911df435bb075ba22ce3c605b07
# bad: [f4d9a23d3dad0252f375901bf4ff6523a2c97241] sparc64: simplify reduce_memory() function
git bisect bad f4d9a23d3dad0252f375901bf4ff6523a2c97241
# bad: [67a242223958d628f0ba33283668e3ddd192d057] Merge tag 'for-5.2/block-20190507' of git://git.kernel.dk/linux-block
git bisect bad 67a242223958d628f0ba33283668e3ddd192d057
# bad: [8ff468c29e9a9c3afe9152c10c7b141343270bf3] Merge branch 'x86-fpu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 8ff468c29e9a9c3afe9152c10c7b141343270bf3
# bad: [8f5e823f9131a430b12f73e9436d7486e20c16f5] Merge tag 'pm-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 8f5e823f9131a430b12f73e9436d7486e20c16f5
# bad: [0bc40e549aeea2de20fc571749de9bbfc099fb34] Merge branch 'x86-mm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 0bc40e549aeea2de20fc571749de9bbfc099fb34
# good: [007dc78fea62610bf06829e38f1d8c69b6ea5af6] Merge branch 'locking-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 007dc78fea62610bf06829e38f1d8c69b6ea5af6
# bad: [a0e928ed7c603a47dca8643e58db224a799ff2c5] Merge branch 'timers-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad a0e928ed7c603a47dca8643e58db224a799ff2c5
# bad: [f447e4eb3ad1e60d173ca997fcb2ef2a66f12574] perf/x86/intel: Force resched when TFA sysctl is modified
git bisect bad f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
# bad: [8313fe2d685da168b732421f85714cfd702d2141] perf vendor events intel: Update Broadwell events to v23
git bisect bad 8313fe2d685da168b732421f85714cfd702d2141
# bad: [70df6a7311186a7ab0b19f481dee4ca540a73837] tools lib traceevent: Add more debugging to see various internal ring buffer entries
git bisect bad 70df6a7311186a7ab0b19f481dee4ca540a73837
# bad: [c2b3c170db610896e4e633cba2135045333811c2] perf stat: Revert checks for duration_time
git bisect bad c2b3c170db610896e4e633cba2135045333811c2
# good: [59f3bd7802d3ff7e6ddcce600f361bed288a97dd] perf augmented_raw_syscalls: Use a PERCPU_ARRAY map to copy more string bytes
git bisect good 59f3bd7802d3ff7e6ddcce600f361bed288a97dd
# good: [514c54039da970f953164c1960d0284f87db969d] perf tools: Add header defining used namespace struct to event.h
git bisect good 514c54039da970f953164c1960d0284f87db969d
# good: [7fcfa9a2d9a7c1b428d61992c2deaa9e37a437b0] perf list: Fix s390 counter long description for L1D_RO_EXCL_WRITES
git bisect good 7fcfa9a2d9a7c1b428d61992c2deaa9e37a437b0
# first bad commit: [c2b3c170db610896e4e633cba2135045333811c2] perf stat: Revert checks for duration_time
