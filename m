Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB8EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 10:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347406AbiCPLBD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 07:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343563AbiCPLBB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 07:01:01 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764AF60077
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 03:59:47 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22GAxJS5052619;
        Wed, 16 Mar 2022 19:59:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Wed, 16 Mar 2022 19:59:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22GAxJbl052613
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Mar 2022 19:59:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <18f892e5-09f9-ee87-b82b-5458d2f6d5cf@I-love.SAKURA.ne.jp>
Date:   Wed, 16 Mar 2022 19:59:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: yet another approach to fix the loop lock order inversions v3
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20220316084519.2850118-1-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220316084519.2850118-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I tested this series using next-20220315.
I can't test locking dependency because lockdep is turned off upon boot.

[   30.251160] ======================================================
[   30.251162] WARNING: possible circular locking dependency detected
[   30.251164] 5.17.0-rc8-next-20220315+ #22 Not tainted
[   30.251166] ------------------------------------------------------
[   30.251168] mount/407 is trying to acquire lock:
[   30.251170] ffff8881003c8898 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x4f/0x4d0
[   30.251185] 
[   30.251185] but task is already holding lock:
[   30.251186] ffffffff830f7798 ((console_sem).lock){-.-.}-{2:2}, at: up+0xd/0x50
[   30.251195] 
[   30.251195] which lock already depends on the new lock.
(...snipped...)
[   30.251433] Chain exists of:
[   30.251433]   &p->pi_lock --> &rq->__lock --> (console_sem).lock
[   30.251433] 
[   30.251440]  Possible unsafe locking scenario:
[   30.251440] 
[   30.251441]        CPU0                    CPU1
[   30.251443]        ----                    ----
[   30.251444]   lock((console_sem).lock);
[   30.251446]                                lock(&rq->__lock);
[   30.251458]                                lock((console_sem).lock);
[   30.251461]   lock(&p->pi_lock);
[   30.251464] 
[   30.251464]  *** DEADLOCK ***
[   30.251464] 
[   30.251465] 2 locks held by mount/407:
[   30.251467]  #0: ffffffff830c7878 (low_water_lock){+.+.}-{2:2}, at: do_exit+0x7ff/0xeb0
[   30.251486]  #1: ffffffff830f7798 ((console_sem).lock){-.-.}-{2:2}, at: up+0xd/0x50

But I can see that due to no longer waiting for lo->lo_mutex from lo_open(),
there are occasional I/O errors. What is your plan to avoid this?

----------------------------------------
[  148.444639] loop56: detected capacity change from 0 to 2048
[  148.448298] I/O error, dev loop56, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  148.456250] loop57: detected capacity change from 0 to 2048
--
[  149.264210] loop70: detected capacity change from 0 to 2048
[  149.267449] I/O error, dev loop70, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  149.314558] loop71: detected capacity change from 0 to 2048
--
[  154.708948] loop172: detected capacity change from 0 to 2048
[  154.712403] I/O error, dev loop172, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  154.760841] loop173: detected capacity change from 0 to 2048
[  154.763728] I/O error, dev loop173, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  154.789921] loop174: detected capacity change from 0 to 2048
--
[  155.469135] loop185: detected capacity change from 0 to 2048
[  155.470800] I/O error, dev loop185, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  155.483457] loop186: detected capacity change from 0 to 2048
--
[  155.568911] loop190: detected capacity change from 0 to 2048
[  155.570783] I/O error, dev loop190, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  155.576789] loop191: detected capacity change from 0 to 2048
--
[  159.671039] loop259: detected capacity change from 0 to 2048
[  159.674879] I/O error, dev loop259, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  159.706059] loop260: detected capacity change from 0 to 2048
--
[  162.845545] loop309: detected capacity change from 0 to 2048
[  162.848151] I/O error, dev loop309, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  162.873731] loop310: detected capacity change from 0 to 2048
--
[  162.940326] loop313: detected capacity change from 0 to 2048
[  162.943770] I/O error, dev loop313, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  163.012664] loop314: detected capacity change from 0 to 2048
--
[  164.725370] loop338: detected capacity change from 0 to 2048
[  164.728747] I/O error, dev loop338, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  164.734669] loop339: detected capacity change from 0 to 2048
--
[  166.463447] loop370: detected capacity change from 0 to 2048
[  166.468262] I/O error, dev loop370, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  166.476621] loop371: detected capacity change from 0 to 2048
--
[  169.133011] loop417: detected capacity change from 0 to 2048
[  169.136747] I/O error, dev loop417, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  169.140203] I/O error, dev loop417, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  169.152730] Buffer I/O error on dev loop417, logical block 0, async page read
[  169.299206] loop418: detected capacity change from 0 to 2048
----------------------------------------



By the way, if CONFIG_BLOCK_LEGACY_AUTOLOAD=n,

# mount -o loop,ro isofs.iso isofs/

unconditionally fails with

mount: isofs/: failed to setup loop device for isofs.iso.

message. Commit 451f0b6f4c44d7b6 ("block: default BLOCK_LEGACY_AUTOLOAD to y")
says "if the device node already exists because old scripts created it manually".
But it is not always manual creation of loop devices; I think it is
ioctl(LOOP_CTL_GET_FREE) in my case.

