Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C583AC0C2
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726340; cv=none; b=CFLYvRJdCcG6z2W8a0Gzztixa3vsMsLFRHZv6fyE0L0cqSN1PRNVGXvGiVFP0ALhbF2LMNVZ0c6Rz9QSXM9c1CWYM4CGsxEMQZYG1YyTJlz4bLejlXOy3EqlZSl6dRFGZNq1QuO/KG/F22Oc2HWZrOiXnsoviBmvZMFi+wDMw6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726340; c=relaxed/simple;
	bh=4D5G+w8MMPOtEt420KC4dqmADXlI37lVnGAuhOqoTaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGbMpTfklB44YbatzJe7luc2vCVjpIEJlLwi2+/1tQORPJ1TdraqUMlIDFhbpKVvgn9LJlsr0D+zDVWgynkb71z5maOQVbu8uSSLKUj2oA1C82ahk91ra/YZMEG0kU/p6iKfioL2AXgWE4tr4zge5jToFHvB8+oMtmpOOz+FPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3Cvu/RF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3Cvu/RF"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b701756684so113470106d6.1
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779726338; x=1780331138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FqffXA0L0N/AyxqI/cfp5RguZ8e9R9MHqbWebTgHgv0=;
        b=n3Cvu/RFmqp5Ssg7vIcBfkK5xAiYWZ5wSKozs+0rP6BCNQew9tKwyuqEjXPKplJ7Vj
         eFIzDqQOn0lSd/ZoYh7tVv/4+FWBN5c4DuLbPIrOpOo9HWMoJ1myfTeLPsY9HMCRnP33
         YPmVoSjQc6YPl83JF++JJYvpXt1J3FLAUbuEMN8I4/GIS985HsEiey4v3r3+uPcrdbMI
         cOku8n8hV2zodQU+GIUl4P3CYikCzLSNeptpkmzCX69VLUGYXyRKYzHtOWrjAYa7Knp+
         q28ldpcu2x5EBHOE+J+yOdJCLZjW1qKTYQnsRR93qpEThnSD2lgGg970X14eZjojsag6
         vP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726338; x=1780331138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqffXA0L0N/AyxqI/cfp5RguZ8e9R9MHqbWebTgHgv0=;
        b=i4tZjGaLFNOBx1JM7iPMogjPChScGcV35IcltKarJaLtTavMXzQazbk1RlSJhbM4ll
         6rH8TD1d5N8ng437xU1AVOG2TRNZkKvZpuH7FozSz2DMpZdTT2sW7+ytOSlKhNEXCZ9A
         14B7/6w/wRPlj/AMWy1rWkvv1M0nZ7kcP1pV/gyv0NUwLPyJHv7/ylPb/97yueZh7g0a
         PB5GC8sFWW3vIeO2j/d048f95XV5EQ0CiLi2m7bKQw2tVy5WCMcqvCrrjcT/6dX6MGNw
         Hw4/l/9/igEzdkzi4lu/LfMfdKLWvrJkDmjho1o+/lMfSSmigjQ/H/hZeaZwTwS8hVc1
         Hg+w==
X-Forwarded-Encrypted: i=1; AFNElJ9e58xLZBOqFBTRj00ZBwFrYxGUWXvbVnzoXa3HwCKXe2TOjWDUSj78SkrJl2c9iSIKkMrFzchNDBIcNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/44NToBJHLSLe8TlqQ8oPhAtGshDL+O8leJSxBIFdWHhGLN5
	GumeXwt8LTLbRDeHtWGa3AtV+gEJaNVWSspt27y/9VpZNRXUpnJxqAUy
X-Gm-Gg: Acq92OEXB7s4f4OaHY7WO6ywJsyrIUm4/qoerku9IqKnbYbzU2OSCk16WL96KVFHn5f
	lE09G7aJDO5Y0HiTeFiwOsVzfu0u3QkgVdRHfeIJ1w51fW7G1EQrvxqKoIsOF7vHWcSVQas1B7f
	t2PSh0Nil6jj+hpskC/MelWOiw7n92Oz4Vb5yvJrbdDSgpYtdWwycBKcOb6Fx6yTUmuCBvN9R6V
	rfpWsjzjwV4IO4VCI6RkjSzTw0Xu59IWXDK7MAKLY6iHiCzoEOzFKFqVpajOcn7JNAAry8bXnkU
	nVibr4thafNdJPi9amIHszez+ml1fCm5TwL33WIuc0PlmzRwA98afrlEez1CqAxyWKjHPELkwDC
	InpaX77XorSEiyf+W0uffN97PRFS+qlHsXlODsp7r7mhi2BMHV6P3ipMcN7ca/4C9kqOwC8NXIt
	2V+QslEO2hzQl1EO69w0KDJBC/nX4pe6dQv0bC1/40
X-Received: by 2002:a05:620a:2549:b0:912:5d2a:4bd1 with SMTP id af79cd13be357-914a240cbe0mr2372699085a.40.1779726337824;
        Mon, 25 May 2026 09:25:37 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bba0deadsm1111067685a.42.2026.05.25.09.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:25:37 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] mtip32xx: fix use-after-free on service thread failure
Date: Mon, 25 May 2026 12:25:31 -0400
Message-ID: <20260525162531.1406677-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If service thread creation fails after device_add_disk() succeeds,
mtip_block_initialize() calls del_gendisk() and then falls through to
put_disk(). Since mtip32xx uses .free_disk to free struct driver_data,
put_disk() can release dd on the added-disk path.

The same unwind then continues to use dd for blk_mq_free_tag_set() and
mtip_hw_exit(), and mtip_pci_probe() can later free dd again. This can
cause a use-after-free and double free.

Track whether the disk was added in the current initialization call.
For the post-add service-thread failure path, remove the disk, release
the local hardware resources, and return without dropping the final disk
reference. The probe error path can then finish its cleanup and call
put_disk() after it is done using dd. Keep the pre-add path using
put_disk() before blk_mq_free_tag_set(), and clear dd->disk so the outer
probe cleanup frees dd directly.

Fixes: e8b58ef09e84 ("mtip32xx: fix device removal")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 567192e371a8..ccf5c164cf46 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3405,6 +3405,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 		.max_segment_size	= 0x400000,
 	};
 	int rv = 0, wait_for_rebuild = 0;
+	bool disk_added = false;
 	sector_t capacity;
 	unsigned int index = 0;
 
@@ -3438,6 +3439,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 		dev_err(&dd->pdev->dev,
 			"Unable to allocate request queue\n");
 		rv = -ENOMEM;
+		dd->disk = NULL;
 		goto block_queue_alloc_init_error;
 	}
 	dd->queue		= dd->disk->queue;
@@ -3496,6 +3498,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 	rv = device_add_disk(&dd->pdev->dev, dd->disk, mtip_disk_attr_groups);
 	if (rv)
 		goto read_capacity_error;
+	disk_added = true;
 
 	if (dd->mtip_svc_handler) {
 		set_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag);
@@ -3511,7 +3514,9 @@ static int mtip_block_initialize(struct driver_data *dd)
 		dev_err(&dd->pdev->dev, "service thread failed to start\n");
 		dd->mtip_svc_handler = NULL;
 		rv = -EFAULT;
-		goto kthread_run_error;
+		if (disk_added)
+			goto kthread_run_error;
+		goto read_capacity_error;
 	}
 	wake_up_process(dd->mtip_svc_handler);
 	if (wait_for_rebuild == MTIP_FTL_REBUILD_MAGIC)
@@ -3522,6 +3527,10 @@ static int mtip_block_initialize(struct driver_data *dd)
 kthread_run_error:
 	/* Delete our gendisk. This also removes the device from /dev */
 	del_gendisk(dd->disk);
+	mtip_hw_debugfs_exit(dd);
+	blk_mq_free_tag_set(&dd->tags);
+	mtip_hw_exit(dd);
+	return rv;
 read_capacity_error:
 init_hw_cmds_error:
 	mtip_hw_debugfs_exit(dd);
@@ -3529,6 +3538,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 	ida_free(&rssd_index_ida, index);
 ida_get_error:
 	put_disk(dd->disk);
+	dd->disk = NULL;
 block_queue_alloc_init_error:
 	blk_mq_free_tag_set(&dd->tags);
 block_queue_alloc_tag_error:
@@ -3839,7 +3849,10 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	}
 
 iomap_err:
-	kfree(dd);
+	if (dd->disk)
+		put_disk(dd->disk);
+	else
+		kfree(dd);
 	pci_set_drvdata(pdev, NULL);
 	return rv;
 done:
-- 
2.43.0

