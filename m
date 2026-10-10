Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B4495AC4
	for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791638863; cv=none; b=R87jecnI0445LGkjH39VBWe5w8R9lFpbLVCanCjtjMwGTeq+dWBtMdTx5PyhJ9qANVktztQx2Yh/r7M9yDEhCWBc+0y0ayfkwoUamtfrsgmq+meuvL0yVtf+xr9pNUk9JhwcmMbyoUSwiTM+l7ndia9yHU0EX1WlmhTuR+BQsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791638863; c=relaxed/simple;
	bh=mtxITmcWvc3yGWXuvwVSycVUTwppjDUjTMGMhK5QZoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMd4kvZg6NxoGoqHDEV/y312uXT3/amigc8MZAeqc5zBVnH6k/nnIKhTWlxLHBTelj8oJ2OOd5B/KglVpMMo2LNsdMu20gVB/bUuR2MWfL4gT5xchu4XnfmGaDD5oQrWPnoxdgGUxJFjQKEyC/qsinv+vKnC+XW9YCR/u/3LZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so5595385e9.1
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 06:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791638860; x=1792243660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BP0D00lIkZpItx8yyC8l4SZFagNyd56ZgQAemQMRUvc=;
        b=Zbnj8hGKgjZ+yn+LoyRG/0XWrG3YofOmLyMqlAxfHkp6ZPHJkBirJ7Rh03ovxgjsIc
         I9LErCSGzQP8XGSHbqfrQYvLCKJzk0Lv4F2WSj+QTZ3o1qrfMro8GqSThgmABe7BtaBY
         7dr7+l7Zjt7AEKsEOdiz1syc/BzEXqIlf9QAF8sDHE4BLMiJK9qgVHZ6mzv8UWPoXSzR
         zpdoYW9ilim+q9wCx7o209OV96KUxQr/Lk/tg9+IYmvQF7pM0+7QsxPZtF27CXXN7/+a
         WjNL+sVr09vFQzk0PM06SCGDKvM2z3/xdbwCojKQNEByuCzRICAI+lSO2qDBw+1FL6P0
         OWNA==
X-Gm-Message-State: AFq9FYLPWKl5t86lSymxnDW6GY/syoWQWfSNhrsE8mL/gDTSOvWRTDT+
	EhzFLCK9GjzEj+VHCt+QfIGRPFOpAFHqPcE+BsRxNkGdhobPB8uShHqTMBPRokpbSio=
X-Gm-Gg: AYBFou0m71E82vsdn63OJVPX+svFwGWTrb9x74M7Qp6ZI6inLNX+Ly9qqmGbcHPT18I
	YrkqmaD529SPJcsBR/ZbgHe1XdEqC4hEH8PxYNtirGMSW+a5n6JUUzCBPEImXvwbqtfHSmGccdX
	F++mdlKXMjj+oSn7S2nnjRHlyfS0v5Y60r/NtbVZOAflTInDw+Lgm9sI+cIVqAf145MNHyEvvKe
	QCLmD/NF/jkTQ0ButXqQLCwCXmceWTy79fVzXfe9OHRxHvZXBwFTouxrxeS9fE8ZYyappYtjIJN
	oA+7i8y0Pb7euP28R2BehyQ0/mU456a1GxYLlcz8fz6/KMoRNMWZdFVVEIjDzAPZx2RXCob5fTi
	/VqF5zashdhQdllbrwE1Y4dunaPlPAzn9YTAEJsPk78fF7+bUilQsR3ePmlc884vc50w6tIwLdx
	nSKpFJnv8veTBtag35zy+nw1lUgkpLdBxbuETI74pkmXPbiQVtvBjGDAnxpID9t618jg5n2vbo+
	rQZTRN0ULz7Z0IMD/HjgwFFRYo=
X-Received: by 2002:a05:600d:6413:10b0:4a1:88d7:4e6a with SMTP id 5b1f17b1804b1-4a19470eccamr21770965e9.27.1791638859558;
        Sat, 10 Oct 2026 06:27:39 -0700 (PDT)
Received: from white (bba-217-165-185-173.alshamil.net.ae. [217.165.185.173])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db94e33c7sm9648731f8f.10.2026.10.10.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 06:27:39 -0700 (PDT)
From: "Denis Efremov (Oracle)" <efremov@linux.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Denis Efremov (Oracle)" <efremov@linux.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] floppy: register the block major after the disks are added
Date: Sat, 10 Oct 2026 17:27:05 +0400
Message-ID: <20261010132705.1693690-1-efremov@linux.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_floppy_init() registers the block major, and with it floppy_probe(),
before it has detected the controllers and added disks[drive][0]. Once
a controller is found, opening a device node for another media format
makes floppy_probe() add disks[drive][type]. If init then fails, the
error path removes only disks[drive][0] and frees the tag sets, leaving
the probed disks registered on top of freed memory.

add_disk() does not need the major, so register it last. floppy_probe()
can then only run once init has succeeded.

Fixes: 302cfee15029 ("floppy: use a separate gendisk for each media format")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260708105703.747262-1-lgs201920130244%40gmail.com
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---
 drivers/block/floppy.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..23a7a0fa76f6 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4602,13 +4602,9 @@ static int __init do_floppy_init(void)
 		timer_setup(&motor_off_timer[drive], motor_off_callback, 0);
 	}
 
-	err = __register_blkdev(FLOPPY_MAJOR, "fd", floppy_probe);
-	if (err)
-		goto out_put_disk;
-
 	err = platform_driver_register(&floppy_driver);
 	if (err)
-		goto out_unreg_blkdev;
+		goto out_put_disk;
 
 	for (i = 0; i < 256; i++)
 		if (ITYPE(i))
@@ -4733,6 +4729,14 @@ static int __init do_floppy_init(void)
 			goto out_remove_drives;
 	}
 
+	/*
+	 * Register last: floppy_probe() adds disks for the other formats,
+	 * which the error path below does not remove.
+	 */
+	err = __register_blkdev(FLOPPY_MAJOR, "fd", floppy_probe);
+	if (err)
+		goto out_remove_drives;
+
 	return 0;
 
 out_remove_drives:
@@ -4748,8 +4752,6 @@ static int __init do_floppy_init(void)
 		floppy_release_irq_and_dma();
 out_unreg_driver:
 	platform_driver_unregister(&floppy_driver);
-out_unreg_blkdev:
-	unregister_blkdev(FLOPPY_MAJOR, "fd");
 out_put_disk:
 	destroy_workqueue(floppy_wq);
 	for (drive = 0; drive < N_DRIVE; drive++) {

base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
-- 
2.56.0

