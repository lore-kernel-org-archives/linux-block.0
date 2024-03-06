Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A0E132C04
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733859; cv=none; b=hcxsjtv5LiHET7m5mNqlKnue1yW1D0KWaz6EZZUeStW+VKJgFez2ua3R0oX7iVygiu5uno3egvWCXpqEK7tOCAA639cKAreoUXwZPRP+jcAE/Rtqx+pBuh+mvVGTE7ATxAQvPrnp52RlPvlWQAx0Pkv8bQF2K8VHICM3RT3v7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733859; c=relaxed/simple;
	bh=iJvm7LkeSEaUWXwvtJs55GNIRr5Glx/PUP+xmxSap2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fytxTGLNG3diTAEyUUh2SCdGklWTzWDP3td1lkz28ltAXPG3VnCyTrBuHEj+/6yA4QMlP8+Vxn2vhPLurzSwgkyHS75SHv9fVqPT2t29/qQrzB20tG4ltvoMARUJlFuseB4+SwTC9susrPdkguZZ05br1u0XAphA3VjnhBLIL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=LSJMIqP1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="LSJMIqP1"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so8724353a12.3
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 06:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709733855; x=1710338655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOlF+PxPHHeUuZ4uXPwhCLw1zVKgjCoV/5sm7c1pL88=;
        b=LSJMIqP1Wi7zLBPhXO3ZTsuHWlnZKmjeQDuu1SfGjgWIhAME09eGErexoAy1OAOhRG
         M8JTnKMjodgpJ31gDb0iTsVn2jPGBnEzrFASCGDIjcILanLvf/Vx1dThA0Mv4GRJDqAV
         TLYzLIXXjPyISigmmv+GWZJPd9EVmHLeVPZcXA8aFxwY3Bv1993rKa/2Giey3uK5/9ft
         mK8bT7ipz20lkhSpB/embyWc07TRGWSdVGPXZt/4VbFERgYAvgMsSvHFHOIKjdikjxWS
         1N0QWx/XB2wPuYj4PIBD2d8JhQdRCi7T+F3xWH7KMePliXKpqEDWBQTqcru9I0x5QYV4
         jTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733855; x=1710338655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOlF+PxPHHeUuZ4uXPwhCLw1zVKgjCoV/5sm7c1pL88=;
        b=tDyx0QZK4hymb15VRlhzJj+aDJ/VH5wbmk8uRxnpBBbR/Yzhh5bez3tLrdmfr0zvdI
         hx6qPJSSNJH3bQfMef1JyJPH70BPL/LvUq4kSsDwt6NVkbUn97WgP2h1Jx79ivndb5ZL
         6DW4wq0fc4M06JGKDzD9SdhUehpxp9Bil0OXVYLpnaY8W+B+Jvzb2e+TqzML7odGzX6J
         7/GUlFnsoasBYzFE2MM4+8rZ62A3b3IuYGDy3b08wer4Wr2enESZC76b6J+0cLjYYFPP
         0hGrOrGNEJ0RKfGmUqcoWCq+LYjn5bR/tTAO7AtEAhyOUGogst5UF1nSvzmdBClkyIud
         2X4g==
X-Forwarded-Encrypted: i=1; AJvYcCWEdkYtk0pszbwQwwHM/xbu521qLSFnRmWO6DwAZUXGA0Rn8M3d4Dwyy0KY7VnJVg/lms3yF42cnBpg8CHFKUA1zwn5i9sfUiiq0M0=
X-Gm-Message-State: AOJu0YxEbNREf7t3VD2VDtXCwfOfRuPRJcUpU5fr+zFNdTk5IBQ8xxZS
	1uo9kl5J+/8+/5OEciM6uV6CaduO/uuyVSNW9hQW9ieETPb4Xy3r3t7dRZHdn84=
X-Google-Smtp-Source: AGHT+IEsmtCchwjV2c/OlW3sJOJ9K+6DxSfSVc4ahLA3PMgA9tHiKHAq8BeBnXBtz9HOsKB+MrnemQ==
X-Received: by 2002:a50:c90d:0:b0:565:471b:c047 with SMTP id o13-20020a50c90d000000b00565471bc047mr11643760edh.0.1709733855499;
        Wed, 06 Mar 2024 06:04:15 -0800 (PST)
Received: from ryzen9.home (62-47-18-60.adsl.highway.telekom.at. [62.47.18.60])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm6924991edq.74.2024.03.06.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:04:15 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/7] drbd: pass the max_hw_sectors limit to blk_alloc_disk
Date: Wed,  6 Mar 2024 15:03:26 +0100
Message-Id: <20240306140332.623759-2-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Pass a queue_limits structure with the max_hw_sectors limit to
blk_alloc_disk instead of updating the limit on the allocated gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index cea1e537fd56..113b441d4d36 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2690,6 +2690,14 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	int id;
 	int vnr = adm_ctx->volume;
 	enum drbd_ret_code err = ERR_NOMEM;
+	struct queue_limits lim = {
+		/*
+		 * Setting the max_hw_sectors to an odd value of 8kibyte here.
+		 * This triggers a max_bio_size message upon first attach or
+		 * connect.
+		 */
+		.max_hw_sectors		= DRBD_MAX_BIO_SIZE_SAFE >> 8,
+	};
 
 	device = minor_to_device(minor);
 	if (device)
@@ -2708,7 +2716,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	drbd_init_set_defaults(device);
 
-	disk = blk_alloc_disk(NULL, NUMA_NO_NODE);
+	disk = blk_alloc_disk(&lim, NUMA_NO_NODE);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
 		goto out_no_disk;
@@ -2729,9 +2737,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	blk_queue_write_cache(disk->queue, true, true);
-	/* Setting the max_hw_sectors to an odd value of 8kibyte here
-	   This triggers a max_bio_size message upon first attach or connect */
-	blk_queue_max_hw_sectors(disk->queue, DRBD_MAX_BIO_SIZE_SAFE >> 8);
 
 	device->md_io.page = alloc_page(GFP_KERNEL);
 	if (!device->md_io.page)
-- 
2.40.1

