Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5307C282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 17:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE5D2175B
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 17:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbfBMRgR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:36:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45344 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393115AbfBMRgR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 12:36:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so1441472pgc.12
        for <linux-block@vger.kernel.org>; Wed, 13 Feb 2019 09:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XbnEk6h1YeFHZ7ZmXRrdqBN0eikTdwGKrkoNO+p9H8=;
        b=P+Ts1zaLyfzfO1/PwByYr1ERZlPVm5rBdvr+utZAXR+OY/GZz+eWDF+43ot3VNtaBd
         hKuCp2QANOLeBv93M+Pwf7zqDuS270EpH+VQnA+HESoD+agayviIVoV+9i1c4rN3zHjD
         +NvW+UMUkJqJU4S0r7dx4L6Ry03o3Mu6aoxHIuNlHD8Q9NzXydaTGLcDCEeXdplVKvAn
         Tfapfk+Usfb0OoyvD91DwycBY5LzAfEPgf0MKnie/rPMWrA0hgs3pgKkGvuDpa8ArAEf
         wiN26sSHHJR2LgEBj1MhZfla83yUzegm57rHXn2ab+NHYKTxkhnNyIqvZSwtVwYza4DC
         AnuQ==
X-Gm-Message-State: AHQUAuYjH/Ias9VVgXxBQWSnJKNgQ/vZJ6KlT5ZLWPwnBZm2FadHX7bR
        Ny6iM3E76SxUavMDTldGGOE=
X-Google-Smtp-Source: AHgI3IbynnPVnbIehmDLvl5dujKDxI39mi5NM6MzJnfrmj3GVt4ir7aQI9FPyAvUauKY4xr+4IGnqA==
X-Received: by 2002:a63:b70b:: with SMTP id t11mr1432825pgf.404.1550079375477;
        Wed, 13 Feb 2019 09:36:15 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s12sm15971729pfm.120.2019.02.13.09.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 09:36:14 -0800 (PST)
Message-ID: <1550079373.19311.55.camel@acm.org>
Subject: Re: blktests nvme/012 triggering LOCKDEP warning
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <tom.leiming@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-block <linux-block@vger.kernel.org>
Date:   Wed, 13 Feb 2019 09:36:13 -0800
In-Reply-To: <CACVXFVNWK7QC+463cbMKE4T36O72Qvkx6AjbW2RZtJX3H4RM9g@mail.gmail.com>
References: <20190212163137.GA7701@mit.edu>
         <CACVXFVNWK7QC+463cbMKE4T36O72Qvkx6AjbW2RZtJX3H4RM9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-02-13 at 12:27 +-0800, Ming Lei wrote:
+AD4 On Wed, Feb 13, 2019 at 12:33 AM Theodore Y. Ts'o +ADw-tytso+AEA-mit.edu+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 Is this a known issue?  nvme/012 is triggering the following lockdep warning:
+AD4 +AD4 
+AD4 +AD4 Thanks,
+AD4 +AD4 
+AD4 +AD4                                         - Ted
+AD4 +AD4 
+AD4 +AD4 +AFs 1964.751910+AF0 run blktests nvme/012 at 2019-02-11 20:58:31
+AD4 +AD4 +AFs 1964.977624+AF0 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
+AD4 +AD4 +AFs 1965.006395+AF0 nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:8a58b187-6d09-4c5d-bc03-593896d2d80d.
+AD4 +AD4 +AFs 1965.011811+AF0 nvme nvme0: ANA group 1: optimized.
+AD4 +AD4 +AFs 1965.011899+AF0 nvme nvme0: creating 2 I/O queues.
+AD4 +AD4 +AFs 1965.013966+AF0 nvme nvme0: new ctrl: +ACI-blktests-subsystem-1+ACI
+AD4 +AD4 
+AD4 +AD4 +AFs 1965.282478+AF0 +AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQ
+AD4 +AD4 +AFs 1965.287922+AF0 WARNING: possible recursive locking detected
+AD4 +AD4 +AFs 1965.293364+AF0 5.0.0-rc3-xfstests-00015-g1236f7d60242 +ACM-841 Not tainted
+AD4 +AD4 +AFs 1965.299762+AF0 --------------------------------------------
+AD4 +AD4 +AFs 1965.305207+AF0 ksoftirqd/1/16 is trying to acquire lock:
+AD4 +AD4 +AFs 1965.310389+AF0 000000000282032e (+ACY(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)-+AD4-rlock)+AHs..-.+AH0, at: flush+AF8-end+AF8-io+-0x4e/0x1d0
+AD4 +AD4 +AFs 1965.319146+AF0
+AD4 +AD4                but task is already holding lock:
+AD4 +AD4 +AFs 1965.325106+AF0 00000000cbadcbc2 (+ACY(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)-+AD4-rlock)+AHs..-.+AH0, at: flush+AF8-end+AF8-io+-0x4e/0x1d0
+AD4 +AD4 +AFs 1965.333957+AF0
+AD4 +AD4                other info that might help us debug this:
+AD4 +AD4 +AFs 1965.340615+AF0  Possible unsafe locking scenario:
+AD4 +AD4 
+AD4 +AD4 +AFs 1965.346664+AF0        CPU0
+AD4 +AD4 +AFs 1965.349248+AF0        ----
+AD4 +AD4 +AFs 1965.351820+AF0   lock(+ACY(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)-+AD4-rlock)+ADs
+AD4 +AD4 +AFs 1965.356654+AF0   lock(+ACY(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)-+AD4-rlock)+ADs
+AD4 +AD4 +AFs 1965.361490+AF0
+AD4 +AD4                 +ACoAKgAq DEADLOCK +ACoAKgAq
+AD4 +AD4 
+AD4 +AD4 +AFs 1965.367541+AF0  May be due to missing lock nesting notation
+AD4 +AD4 
+AD4 +AD4 +AFs 1965.374636+AF0 1 lock held by ksoftirqd/1/16:
+AD4 +AD4 +AFs 1965.378890+AF0  +ACM-0: 00000000cbadcbc2 (+ACY(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)-+AD4-rlock)+AHs..-.+AH0, at: flush+AF8-end+AF8-io+-0x4e/0x1d0
+AD4 +AD4 +AFs 1965.388080+AF0
+AD4 +AD4                stack backtrace:
+AD4 +AD4 +AFs 1965.392570+AF0 CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3-xfstests-00015-g1236f7d60242 +ACM-841
+AD4 +AD4 +AFs 1965.402002+AF0 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
+AD4 +AD4 +AFs 1965.411411+AF0 Call Trace:
+AD4 +AD4 +AFs 1965.413996+AF0  dump+AF8-stack+-0x67/0x90
+AD4 +AD4 +AFs 1965.417433+AF0  +AF8AXw-lock+AF8-acquire.cold.45+-0x2b4/0x313
+AD4 +AD4 +AFs 1965.422194+AF0  lock+AF8-acquire+-0x98/0x160
+AD4 +AD4 +AFs 1965.425894+AF0  ? flush+AF8-end+AF8-io+-0x4e/0x1d0
+AD4 +AD4 +AFs 1965.429817+AF0  +AF8-raw+AF8-spin+AF8-lock+AF8-irqsave+-0x3b/0x80
+AD4 +AD4 +AFs 1965.434299+AF0  ? flush+AF8-end+AF8-io+-0x4e/0x1d0
+AD4 +AD4 +AFs 1965.438162+AF0  flush+AF8-end+AF8-io+-0x4e/0x1d0
+AD4 +AD4 +AFs 1965.441909+AF0  blk+AF8-mq+AF8-complete+AF8-request+-0x76/0x110
+AD4 +AD4 +AFs 1965.446580+AF0  nvmet+AF8-req+AF8-complete+-0x15/0x110 +AFs-nvmet+AF0
+AD4 +AD4 +AFs 1965.452098+AF0  nvmet+AF8-bio+AF8-done+-0x27/0x50 +AFs-nvmet+AF0
+AD4 +AD4 +AFs 1965.456634+AF0  blk+AF8-update+AF8-request+-0xd7/0x2d0
+AD4 +AD4 +AFs 1965.460869+AF0  blk+AF8-mq+AF8-end+AF8-request+-0x1a/0x100
+AD4 +AD4 +AFs 1965.465091+AF0  blk+AF8-flush+AF8-complete+AF8-seq+-0xe5/0x350
+AD4 +AD4 +AFs 1965.469660+AF0  flush+AF8-end+AF8-io+-0x12f/0x1d0
+AD4 +AD4 +AFs 1965.473436+AF0  blk+AF8-done+AF8-softirq+-0x9f/0xd0
+AD4 +AD4 +AFs 1965.477398+AF0  +AF8AXw-do+AF8-softirq+-0xca/0x440
+AD4 +AD4 +AFs 1965.481092+AF0  ? smpboot+AF8-thread+AF8-fn+-0x2f/0x1e0
+AD4 +AD4 +AFs 1965.485512+AF0  ? smpboot+AF8-thread+AF8-fn+-0x74/0x1e0
+AD4 +AD4 +AFs 1965.489813+AF0  ? smpboot+AF8-thread+AF8-fn+-0x118/0x1e0
+AD4 +AD4 +AFs 1965.494379+AF0  run+AF8-ksoftirqd+-0x24/0x50
+AD4 +AD4 +AFs 1965.498081+AF0  smpboot+AF8-thread+AF8-fn+-0x113/0x1e0
+AD4 +AD4 +AFs 1965.502399+AF0  ? sort+AF8-range+-0x20/0x20
+AD4 +AD4 +AFs 1965.506008+AF0  kthread+-0x121/0x140
+AD4 +AD4 +AFs 1965.509395+AF0  ? kthread+AF8-park+-0x80/0x80
+AD4 +AD4 +AFs 1965.513290+AF0  ret+AF8-from+AF8-fork+-0x3a/0x50
+AD4 +AD4 +AFs 1965.527032+AF0 XFS (nvme0n1): Mounting V5 Filesystem
+AD4 +AD4 +AFs 1965.541778+AF0 XFS (nvme0n1): Ending clean mount
+AD4 +AD4 +AFs 2064.142830+AF0 XFS (nvme0n1): Unmounting Filesystem
+AD4 +AD4 +AFs 2064.171432+AF0 nvme nvme0: Removing ctrl: NQN +ACI-blktests-subsystem-1+ACI
+AD4 
+AD4 That is a false positive.
+AD4 
+AD4 It is caused by calling host request's completion handler from target
+AD4 IO's completion
+AD4 handler directly, and this way should be nvme-loop only.
+AD4 
+AD4 We may need to annotate the locks in .end+AF8-io of blk-flush for avoiding
+AD4 this warning.
+AD4 
+AD4 BTW, this way of nvme-loop handling IO completion may trigger soft lockup too.

Hi Ming,

Can you clarify that last statement?

You may want to know that the patch below suppresses this lockdep complaint. I will
include it in my +ACI-dynamic lockdep key+ACI patch series.


+AFs-PATCH+AF0 block: Suppress a false positive lockdep complaint

Avoid that running test nvme/012 from the blktests suite triggers the
following lockdep complaint:

+AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQ
WARNING: possible recursive locking detected
5.0.0-rc3-xfstests-00015-g1236f7d60242 +ACM-841 Not tainted
--------------------------------------------
ksoftirqd/1/16 is trying to acquire lock:
000000000282032e (+ACY(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)-+AD4-rlock)+AHs..-.+AH0, at: flush+AF8-end+AF8-io+-0x4e/0x1d0

but task is already holding lock:
00000000cbadcbc2 (+ACY(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)-+AD4-rlock)+AHs..-.+AH0, at: flush+AF8-end+AF8-io+-0x4e/0x1d0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(+ACY(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)-+AD4-rlock)+ADs
  lock(+ACY(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)-+AD4-rlock)+ADs

 +ACoAKgAq DEADLOCK +ACoAKgAq

 May be due to missing lock nesting notation

1 lock held by ksoftirqd/1/16:
 +ACM-0: 00000000cbadcbc2 (+ACY(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)-+AD4-rlock)+AHs..-.+AH0, at: flush+AF8-end+AF8-io+-0x4e/0x1d0

stack backtrace:
CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3-xfstests-00015-g1236f7d60242 +ACM-841
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 dump+AF8-stack+-0x67/0x90
 +AF8AXw-lock+AF8-acquire.cold.45+-0x2b4/0x313
 lock+AF8-acquire+-0x98/0x160
 +AF8-raw+AF8-spin+AF8-lock+AF8-irqsave+-0x3b/0x80
 flush+AF8-end+AF8-io+-0x4e/0x1d0
 blk+AF8-mq+AF8-complete+AF8-request+-0x76/0x110
 nvmet+AF8-req+AF8-complete+-0x15/0x110 +AFs-nvmet+AF0
 nvmet+AF8-bio+AF8-done+-0x27/0x50 +AFs-nvmet+AF0
 blk+AF8-update+AF8-request+-0xd7/0x2d0
 blk+AF8-mq+AF8-end+AF8-request+-0x1a/0x100
 blk+AF8-flush+AF8-complete+AF8-seq+-0xe5/0x350
 flush+AF8-end+AF8-io+-0x12f/0x1d0
 blk+AF8-done+AF8-softirq+-0x9f/0xd0
 +AF8AXw-do+AF8-softirq+-0xca/0x440
 run+AF8-ksoftirqd+-0x24/0x50
 smpboot+AF8-thread+AF8-fn+-0x113/0x1e0
 kthread+-0x121/0x140
 ret+AF8-from+AF8-fork+-0x3a/0x50

Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
---
 block/blk-flush.c +AHw 4 +-+-+--
 block/blk.h       +AHw 1 +-
 2 files changed, 4 insertions(+-), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 6e0f2d97fc6d..c4fa6dd73664 100644
--- a/block/blk-flush.c
+-+-+- b/block/blk-flush.c
+AEAAQA -472,7 +-472,8 +AEAAQA struct blk+AF8-flush+AF8-queue +ACo-blk+AF8-alloc+AF8-flush+AF8-queue(struct request+AF8-queue +ACo-q,
 	if (+ACE-fq)
 		goto fail+ADs
 
-	spin+AF8-lock+AF8-init(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)+ADs
+-	lockdep+AF8-register+AF8-key(+ACY-fq-+AD4-key)+ADs
+-	spin+AF8-lock+AF8-init+AF8-key(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock, +ACY-fq-+AD4-key)+ADs
 
 	rq+AF8-sz +AD0 round+AF8-up(rq+AF8-sz +- cmd+AF8-size, cache+AF8-line+AF8-size())+ADs
 	fq-+AD4-flush+AF8-rq +AD0 kzalloc+AF8-node(rq+AF8-sz, flags, node)+ADs
+AEAAQA -497,6 +-498,7 +AEAAQA void blk+AF8-free+AF8-flush+AF8-queue(struct blk+AF8-flush+AF8-queue +ACo-fq)
 	if (+ACE-fq)
 		return+ADs
 
+-	lockdep+AF8-unregister+AF8-key(+ACY-fq-+AD4-key)+ADs
 	kfree(fq-+AD4-flush+AF8-rq)+ADs
 	kfree(fq)+ADs
 +AH0
diff --git a/block/blk.h b/block/blk.h
index 848278c52030..10f5e19aa4a1 100644
--- a/block/blk.h
+-+-+- b/block/blk.h
+AEAAQA -28,6 +-28,7 +AEAAQA struct blk+AF8-flush+AF8-queue +AHs
 	 +ACo at the same time
 	 +ACo-/
 	struct request		+ACo-orig+AF8-rq+ADs
+-	struct lock+AF8-class+AF8-key	key+ADs
 	spinlock+AF8-t		mq+AF8-flush+AF8-lock+ADs
 +AH0AOw
 
-- 
2.20.1.791.gb4d0f1c61a-goog

