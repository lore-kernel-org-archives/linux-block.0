Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4292874F8
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288622; cv=none; b=d5Ul+fRcU1I+gDyK688WAxP1ItY4HGk1p3V10aXK7OW7BE9RKQfW8gHiy56xsDcceSZ6Qs/kKKks+KDw2GaIGv9LqfIpWtH+jM20U6sahKXSwJjW/pOzdzuqHhwJnN6LIUDlzNCMxVEyY72y4opAq6IT6yYIa47MG1y9YrHMQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288622; c=relaxed/simple;
	bh=+fWU8Ju/7D3HAZkVEatYhVTdKKEqsF4wSvyghQZY1rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI9/MO9l09xbZApTybL6SSF5iMe5CUmhZAzWIRu4wx0jVF2V0ab9h6MdxEBBLtdxsFqRDeaUCLJDDUWsOIZA9Ucnm4Ab04mWMcVltOqVAjP+R5evxeDOuxhH66wA/BtHvRjpIkoK4apjwmwI+cYGpFHTdXEj5CyQkF2v63GXhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IL3xkRrz; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IL3xkRrz"
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-69a1c7ce59dso58183a12.3
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 18:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785288606; x=1785893406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVKYpKL6SfhZFwUxWB7c6IWXwJ77iAagQ0VGL03c4/8=;
        b=IL3xkRrzgEeP0m1DQeFiMcXE56Bq0lOSytlAKXvOQpQ6D7DT3sgT35NnnO4iYYxAPV
         t68LHz0ac840tw80red/Yz6QypYLc9GhXWsi5Ezh5xzTrzMBnq5+UyLBrl+5QBZeOYmY
         payKaEa/hE+hbfykholuBx1MyOaPnthU4Jhk1fI2usYqG9gKSi1ygVg+t4rGDrTT/2pw
         k28lUyPQmGJE78SGDgtoXKqVVkrpvYxlpZoIUr/WCbXepjYIqgUFao2ABKkLj5j5xxWm
         eQsjhyByrO2LAfBuPmSTBIFV9zwkeb76f7rflat6vcub80y16Q9uUdcV7uZ3qW5Q1Pve
         0akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785288606; x=1785893406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVKYpKL6SfhZFwUxWB7c6IWXwJ77iAagQ0VGL03c4/8=;
        b=Ghf0/j8LQH35ow9Ui7bfDZBCguwGz5CVmLnbapmmzvqkWY+M2aKqVKDzDUiC4tUuIH
         dZYyzvm7W1WGCHWmfQp0QEXVBVoPjI2wxKnyVY6Avw+e1z4EFoojlTVVFaqz4HJJvlnH
         /wI17MFaBhy4E0gBsgk8e4fAw6CWAcpspdcUqp0/xUyajXqFv4sk3RXIMjP4SsjAggwD
         LbCZKyOM4Zt6VPeCzc/FxhNuypIIBW4W+I/YFk5nr3ggX3thlCkkCqqAUHySIrjl4V1h
         8pSUMqXPDDVWwtlVEdAsQstGwTf9RE2Q4kr+1KVud63tczUpJ6MKHSWAL6bI77vnK3sW
         XJMQ==
X-Gm-Message-State: AOJu0Yx/J7gfDvOTOe5375l19a5EPW9n+MXi2xh7uSv9KDnGCHITvpR1
	+vWyQ0ppLHUCi8xUtsR6MW7uF+HPlHrx5cgIRXPRzcKkOco60DoJkeqokwgpPq0Ch0hzBEKjFAI
	o1BGDM6yWZencwffY9eHlE3+Ta20DhOqzpybo
X-Gm-Gg: AR+sD121UtvmXj9ncbkjRDmYQxdLa/xbOZ5LrQLxS+GI1wJB8UQeqy6510OkjwV/qRy
	xdLOeNHU/CH071EnQ22fYabVt0WLPhe1ISfdmY8b7WO5SuA1kIRN1QvIqwiWDOLumGs1N5yA2VC
	KTAD1wmMlyhYN09MGftdYEXKwCkzNyLvGzTp3iZ43oZ6x1U3s6dm/yul1z/7AMMgYAdZLDvWOu5
	YUDBq3Y8OGa6ZbI4Ffu8R+Vk3U2VbRtvC57SI+ToIMHuaLCxxDBzJ7Zqu9yNdcy6v2zyEz0GO2a
	fOzBo3wNO0Xx0Ky2mz0Jy10M5/0Q22FvreWDqxvOoX9OsempjklRdg5+fjKOtUjDEvovaXzaNaU
	mt/QFZcJv1o4myjI+ru92RyfqCAnn64mx
X-Received: by 2002:a17:906:6a1c:b0:c12:81be:b077 with SMTP id a640c23a62f3a-c1f72226243mr131405866b.8.1785288605795;
        Tue, 28 Jul 2026 18:30:05 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-c1f83c711c2sm9351366b.16.2026.07.28.18.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:30:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 6084C4043D;
	Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5D9FCE40442; Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/6] ublk: split request validation from io_desc init
Date: Tue, 28 Jul 2026 19:29:48 -0600
Message-ID: <20260729012951.3744582-4-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729012951.3744582-1-csander@purestorage.com>
References: <20260729012951.3744582-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for moving the struct ublksrv_io_desc initialization from
the thread submitting ublk requests to the daemon thread receiving them,
split the fallible part of ublk_setup_iod{,_zoned}() into new helper
ublk_validate_req{,_zoned}(). Only ublk_setup_iod{,_zoned}() accesses
the io_desc and cannot error out.

Return a bool value from ublk_validate_req{,_zoned}() as the existing
error code ublk_setup_iod{,_zoned}() returns is only checked against
BLK_STS_OK.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 70 +++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index fada30d8d350..efbb0d6af128 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -698,12 +698,28 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 out:
 	kvfree(buffer);
 	return ret;
 }
 
-static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
-					 struct request *req)
+static bool ublk_validate_req_zoned(const struct request *req)
+{
+	switch (req_op(req)) {
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
+	case REQ_OP_ZONE_FINISH:
+	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_APPEND:
+	case REQ_OP_ZONE_RESET_ALL:
+		return true;
+	case REQ_OP_DRV_IN:
+		return !!ublk_zoned_get_report_desc(req);
+	default:
+		return false;
+	}
+}
+
+static void ublk_setup_iod_zoned(struct ublk_queue *ubq, struct request *req)
 {
 	struct ublk_zoned_report_desc *desc;
 	u32 ublk_op;
 
 	switch (req_op(req)) {
@@ -725,24 +741,19 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 	case REQ_OP_ZONE_RESET_ALL:
 		ublk_op = UBLK_IO_OP_ZONE_RESET_ALL;
 		break;
 	case REQ_OP_DRV_IN:
 		desc = ublk_zoned_get_report_desc(req);
-		if (!desc)
-			return BLK_STS_IOERR;
 		ublk_init_iod(ubq, req, UBLK_IO_OP_REPORT_ZONES, desc->nr_zones,
 			      desc->sector);
-		return BLK_STS_OK;
-	case REQ_OP_DRV_OUT:
-		/* We do not support drv_out */
-		return BLK_STS_NOTSUPP;
+		return;
 	default:
-		return BLK_STS_IOERR;
+		WARN_ON_ONCE(1);
+		return;
 	}
 
 	ublk_init_iod(ubq, req, ublk_op, blk_rq_sectors(req), blk_rq_pos(req));
-	return BLK_STS_OK;
 }
 
 #else
 
 #define ublk_report_zones (NULL)
@@ -759,14 +770,18 @@ static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
 static int ublk_revalidate_disk_zones(struct ublk_device *ub)
 {
 	return 0;
 }
 
-static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
-					 struct request *req)
+static bool ublk_validate_req_zoned(const struct request *req)
 {
-	return BLK_STS_NOTSUPP;
+	return false;
+}
+
+static void ublk_setup_iod_zoned(struct ublk_queue *ubq, struct request *req)
+{
+	WARN_ON_ONCE(1);
 }
 
 #endif
 
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
@@ -1489,11 +1504,26 @@ static unsigned int ublk_unmap_io(bool need_map,
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
 
-static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
+static bool ublk_validate_req(const struct ublk_queue *ubq,
+			      const struct request *req)
+{
+	switch (req_op(req)) {
+	case REQ_OP_READ:
+	case REQ_OP_WRITE:
+	case REQ_OP_FLUSH:
+	case REQ_OP_DISCARD:
+	case REQ_OP_WRITE_ZEROES:
+		return true;
+	default:
+		return ublk_queue_is_zoned(ubq) && ublk_validate_req_zoned(req);
+	}
+}
+
+static void ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
 	u32 ublk_op;
 
 	switch (req_op(req)) {
 	case REQ_OP_READ:
@@ -1510,17 +1540,15 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 		break;
 	case REQ_OP_WRITE_ZEROES:
 		ublk_op = UBLK_IO_OP_WRITE_ZEROES;
 		break;
 	default:
-		if (ublk_queue_is_zoned(ubq))
-			return ublk_setup_iod_zoned(ubq, req);
-		return BLK_STS_IOERR;
+		ublk_setup_iod_zoned(ubq, req);
+		return;
 	}
 
 	ublk_init_iod(ubq, req, ublk_op, blk_rq_sectors(req), blk_rq_pos(req));
-	return BLK_STS_OK;
 }
 
 static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 		struct io_uring_cmd *ioucmd)
 {
@@ -2124,12 +2152,10 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 }
 
 static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
 				  bool check_cancel)
 {
-	blk_status_t res;
-
 	if (unlikely(READ_ONCE(ubq->fail_io)))
 		return BLK_STS_TARGET;
 
 	/* With recovery feature enabled, force_abort is set in
 	 * ublk_stop_dev() before calling del_gendisk(). We have to
@@ -2146,14 +2172,14 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
 
 	if (check_cancel && unlikely(ubq->canceling))
 		return BLK_STS_IOERR;
 
 	/* fill iod to slot in io cmd buffer */
-	res = ublk_setup_iod(ubq, rq);
-	if (unlikely(res != BLK_STS_OK))
+	if (unlikely(!ublk_validate_req(ubq, rq)))
 		return BLK_STS_IOERR;
 
+	ublk_setup_iod(ubq, rq);
 	blk_mq_start_request(rq);
 	return BLK_STS_OK;
 }
 
 /*
-- 
2.54.0

