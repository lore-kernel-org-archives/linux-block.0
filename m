Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452D4432F5
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791499276; cv=none; b=G5sJ87u1yd9SLgWs3olDnoc27ANyBeW4io6GLhmF1uTCuOyO/tsJCpeW6Qo4AIK4Ap3sPd9Tj2h0yuQdZU/fOpQgZBlpMVxT3QaaCGP/O+KWhPBT1gsPSow/qoGJxSwR6IbFf3GhXaO473T5s3ilEi34cm82S2z1SSqZfgPMtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791499276; c=relaxed/simple;
	bh=iagalCOt4SPH6sjffSH4/8LpeUolMcpalzpFaQ3ZZTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbovM9c57PftUqAe5YyxhpdM0uY8tESoYTwRbVTauBepHlOW3mv/hdcoSPdjTA5GeXsKrKLHaQe2l/PNWDMv0Bzzx1/mRuvPdUsX14TcyyKqoqvaCPm8oZLXB4kMG6uw7dlju7OnX8KGST/0AitQGhNAcD5Jq+2hrwGSYio/8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a020e65269so26657305e9.2
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 15:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791499273; x=1792104073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vcyu1IFRGhKQixf4T9pww9oH3TOTqCtgW78hSpt3A8A=;
        b=uREsPtDliGNGMFBU/vVFm1O2hyneVjT8e2jG0j99Pk8g7ZBPeJgy83FMR2Tjj88bUu
         vVwsbCPPjADtTlSONroeoZOKhDIbSvjKdg7+54/CYGDetoQ9E9i5AjQYdq82BLOr5A/n
         5Hp2TLQ0yA2fj1leBP9UlGkcvFTWTJbrVGWJl6iw0/tF8ZJ9izkTjkJv3dhj7TWgiTOC
         AS4mekUn73bQ8Fz0npv3sMLdMqcZfkl7ULqVo4Gv1cPhRCSTYUYSsxMxTVnKkrBRhccz
         f9YhadjQSWRuY3Ly/ipoEYvc8eUwvJ1YasbJXmGsTu6PFr9/tEE8RHNCsPnt3y5ML5SP
         OdHA==
X-Gm-Message-State: AFuF++mRhXDuG//MtFWxXRGU0eE7K35T0AiVw88afO6Hg+sGuZdDyK22
	cnPrdXfifJngJrocRO1IcpfIl6GmOQaeDnW8/VjWWV8AJjmEungAd+NqAOk6mWsNt5g=
X-Gm-Gg: AYBFou2n7Tw4To6e5ML5BXcvzdWS/v7sTYa9h9mvWExFaqhXISVHnnA8bLiLkkpFchf
	MwxGaGTMwJ7VfUwhvxUjbdO2P8ArIygtAMj6F/LKDADbaw9xpsmgqpIL7PfiaiORx+BuEsQvG+s
	1yB2zM1aO8UhIAw3XPNDtf+jjw/sLlooyuJ6Q8hgXp07Xmb2ZRsVw2t0QUaEBzxdPs3ZSgkiwzC
	vbfq9mfRPcTmdFL0k5PfFut4n72oaJuaIJhKozlI0txN97Uv7WdoDPEvRz7wuhWz6BQi1RU9zun
	ewHAHoR9IaaRSYNP2fDyTl/2TbC4gfVXnbeU6jwSFY/LCIXTPhEpLDpdVAl7TGpyZhC/p9rGfpP
	rJJQxW3FVm1dvm+iky8f0ta/4nv4p00cPp0c1SHDSTFSk3LEp1x6RJxLX0Cwx2+SMx/cWsF1uUa
	/5he8Vk/MVESZfUn7FG6F44/P9wrUqDbxR3Bf0p0lCm8ror+znPQerlszI6C2z1VVko2nJnbQ3U
	dLFSyoa3tEpeQvzGU/RgJ+/ql8=
X-Received: by 2002:a05:600c:5252:b0:4a0:1aa0:7cfa with SMTP id 5b1f17b1804b1-4a18041c4b2mr132254105e9.12.1791499272911;
        Thu, 08 Oct 2026 15:41:12 -0700 (PDT)
Received: from white (bba-217-165-185-173.alshamil.net.ae. [217.165.185.173])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a18bc6a48fsm15055275e9.1.2026.10.08.15.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:41:12 -0700 (PDT)
From: "Denis Efremov (Oracle)" <efremov@linux.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Denis Efremov (Oracle)" <efremov@linux.com>
Subject: [PATCH] floppy: remove usage_count
Date: Fri,  9 Oct 2026 02:40:33 +0400
Message-ID: <20261008224033.3134735-1-efremov@linux.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usage_count used to count openers and FDC users. Since commit
3e541a4ae534 ("[PATCH] lockdep: floppy.c irq release fix") the only
caller of floppy_grab_irq_and_dma() is do_floppy_init(), which runs it
once for all controllers and drives before any disk is added.
floppy_release_irq_and_dma() runs only after that grab has succeeded:
on init failure after del_gendisk(), or on module exit. The count is 1
for as long as a floppy disk exists, so it carries no information.

The usage_count == 0 checks in lock_fdc(), floppy_queue_rq() and
floppy_revalidate() never fire. The one in floppy_queue_rq() would oops
if it did, since it dereferences current_req, which is NULL when nothing
is in flight. The nested-grab early return in floppy_grab_irq_and_dma(),
the atomic_dec_and_test() in floppy_release_irq_and_dma() and the
usage_count tests before the release calls always go the same way.

Remove the counter and the checks.

Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---
 drivers/block/floppy.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..a08ed982f013 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -566,8 +566,6 @@ static int floppy_revalidate(struct gendisk *disk);
 #define NEED_1_RECAL	-2
 #define NEED_2_RECAL	-3
 
-static atomic_t usage_count = ATOMIC_INIT(0);
-
 /* buffer related variables */
 static int buffer_track = -1;
 static int buffer_drive = -1;
@@ -883,10 +881,6 @@ static void set_fdc(int drive)
  */
 static int lock_fdc(int drive)
 {
-	if (WARN(atomic_read(&usage_count) == 0,
-		 "Trying to lock fdc while usage count=0\n"))
-		return -1;
-
 	if (wait_event_interruptible(fdc_wait, !test_and_set_bit(0, &fdc_busy)))
 		return -EINTR;
 
@@ -2854,12 +2848,6 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
 		 "VFS: %s called on non-open device\n", __func__))
 		return BLK_STS_IOERR;
 
-	if (WARN(atomic_read(&usage_count) == 0,
-		 "warning: usage count=0, current_req=%p sect=%ld flags=%llx\n",
-		 current_req, (long)blk_rq_pos(current_req),
-		 (__force unsigned long long) current_req->cmd_flags))
-		return BLK_STS_IOERR;
-
 	if (test_and_set_bit(0, &fdc_busy)) {
 		/* fdc busy, this new request will be treated when the
 		   current one is done */
@@ -4178,10 +4166,6 @@ static int floppy_revalidate(struct gendisk *disk)
 	    test_bit(FD_VERIFY_BIT, &drive_state[drive].flags) ||
 	    test_bit(drive, &fake_change) ||
 	    drive_no_geom(drive)) {
-		if (WARN(atomic_read(&usage_count) == 0,
-			 "VFS: revalidate called on non-open device.\n"))
-			return -EFAULT;
-
 		res = lock_fdc(drive);
 		if (res)
 			return res;
@@ -4744,8 +4728,7 @@ static int __init do_floppy_init(void)
 		}
 	}
 out_release_dma:
-	if (atomic_read(&usage_count))
-		floppy_release_irq_and_dma();
+	floppy_release_irq_and_dma();
 out_unreg_driver:
 	platform_driver_unregister(&floppy_driver);
 out_unreg_blkdev:
@@ -4825,9 +4808,6 @@ static int floppy_grab_irq_and_dma(void)
 {
 	int fdc;
 
-	if (atomic_inc_return(&usage_count) > 1)
-		return 0;
-
 	/*
 	 * We might have scheduled a free_irq(), wait it to
 	 * drain first:
@@ -4837,7 +4817,6 @@ static int floppy_grab_irq_and_dma(void)
 	if (fd_request_irq()) {
 		DPRINT("Unable to grab IRQ%d for the floppy driver\n",
 		       FLOPPY_IRQ);
-		atomic_dec(&usage_count);
 		return -1;
 	}
 	if (fd_request_dma()) {
@@ -4847,7 +4826,6 @@ static int floppy_grab_irq_and_dma(void)
 			use_virtual_dma = can_use_virtual_dma = 1;
 		if (!(can_use_virtual_dma & 1)) {
 			fd_free_irq();
-			atomic_dec(&usage_count);
 			return -1;
 		}
 	}
@@ -4883,7 +4861,6 @@ static int floppy_grab_irq_and_dma(void)
 	while (--fdc >= 0)
 		floppy_release_regions(fdc);
 	current_fdc = 0;
-	atomic_dec(&usage_count);
 	return -1;
 }
 
@@ -4896,9 +4873,6 @@ static void floppy_release_irq_and_dma(void)
 	long tmpsize;
 	unsigned long tmpaddr;
 
-	if (!atomic_dec_and_test(&usage_count))
-		return;
-
 	if (irqdma_allocated) {
 		fd_disable_dma();
 		fd_free_dma();
@@ -4994,8 +4968,7 @@ static void __exit floppy_module_exit(void)
 	cancel_delayed_work_sync(&fd_timeout);
 	cancel_delayed_work_sync(&fd_timer);
 
-	if (atomic_read(&usage_count))
-		floppy_release_irq_and_dma();
+	floppy_release_irq_and_dma();
 
 	/* eject disk, if any */
 	fd_eject(0);

base-commit: 6c377d19d4a5116d9bec5203aa3c6c11523e7898
-- 
2.56.0

