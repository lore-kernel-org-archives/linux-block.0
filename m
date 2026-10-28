Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205900;
	b=2zCU6fkM4XzYbTtwrlcHbNmOoBWMAXKcLY1ZYT2tPJfKUZSRtpvfUL+0optJ4757kh/M
	 AOCc4rGaqmAjCyoKvidcXKvMZz9FjzJ7EjxdCC5fZJm7cBGk27w6bTOdVh6jzwl7iLMsI
	 98KdlAsnQBOAzHPbYDE+1yRncKZKwxv0XZb0gIG50vI9CQdXE4SSQTPeS/XApTb8okfpv
	 4aIovAwGwSdu8SNHq1JsWzSnfXYKvYR3tm7y2kd4cmv1Duuq3jNton37Llh9da0l/2Njp
	 Rtp+scd9zceKV++8OXdkC82WueTwNZTAgzFrk6ZrZGt8MW1S2kLcvzv0rtdXxkvyb8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3XwYtFfajwQV83c7HEcG4lBPXk2p8oqhRXS8V69BIOY=;
	b=BX9EZ7GtyRdXFgoZ8zVCVOc1PlrvdTpsXvsxzd4MiL85Dn51M7SYl/JU7O3nSAvnLc+F
	 pvJ4ZRl/u904rHH0ilb1r6m+lrt1qZfVuUJLUJNJkI7G52Bc30de2fZVMexwFMF11avdH
	 sEm0ldfEDxkf+6HqUZGeG3hlq7mcJDqt9ODb7PQG0bOgOAesAJErtq1Q/t5f7Z7pjd4nG
	 VPmHWZ4DNarUTOVKwCP13+C6pOrGFP6NfvEL7aukQKbIj/7nKp3cycMMhVabFzBXAnFLJ
	 N1afsWSueeEzzno8z5ci+AJBrJN8S7eYQ1gnZqyWAtvUFR4s5oZyvw0NoRo2aDx+sJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hphDgB+9;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5301606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5301606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hphDgB+9
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-82380b0f55dso617643a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205899; x=1793810699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XwYtFfajwQV83c7HEcG4lBPXk2p8oqhRXS8V69BIOY=;
        b=hphDgB+9sAcgRrW3GuQA9LYueU++2C3xR2Ye2YcOU6+SeyMbnX/FtqkDQ+uRCXMqCy
         0prBhemIp3MJ+laLAXLnPxVFzy3kjEsM/p8FTfUiTskrv2SsCZgSWxUonsCP6TsEYlyl
         jsWiLeqe297XgFpiLPTZ7j4bjXtU91+xjAS9ITybHCh5Apr9Ygs/zHIiK9iOkH3SMHxG
         wHZclpIVCMe3MM8xwNEZTc+BwuJRVTR/9RbBeBvNDllscApFMBGi8pTX9ea9AeYljEI5
         hx2mUWzE1ykuAitB4lRnDg1whBipI075g5PINmNNcoPxWRJdsnPMLxlCh758lRtArWgH
         hIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205899; x=1793810699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3XwYtFfajwQV83c7HEcG4lBPXk2p8oqhRXS8V69BIOY=;
        b=EgQV2iFHF5xMrxSJMf4pZkda1VvHOGNvwJ2Xw8RpFj52W3F9PLktyEZoTm3iPxvfrT
         dJDLMJV6WMnus/Mv5dsvF+8BJ3iryG4ySlS6265Wbs9fWa7Y2eQqHhmwKaZEgC3lkGan
         R4HYa5exy2a/SFSF57O9q5QWF1Q7i33bkigijbnf66LL4A2rwz4uIWGKvGu0g+JhnSKt
         uNoCrFEIEc10PNZMP/9e3Xm/p7WsVbNNorhlO2AUxN2UFnu+PqzRYeOIaCgH5HdxcdkZ
         JSHfB3hjxqCB6yTvuK636T6JwENDXhALjgMa71dutzFwLkCL7mqegiAUwW4yu1iM+cj4
         052w==
X-Gm-Message-State: AFq9FYKI+urHWfeo0wj9S6v+gaiMtuMeOa+0SNpScQN8QShFV2b9lJT6
	lUPZjdE/16j7doADsIyEC8dwF6F8fbi6zBJSqyOhxhd1ewOnL2XtYGxVr3g6YKEMq1zD6gyqAgy
	EymWo1Hw=
X-Gm-Gg: AYBFou1zOWFKt+DBNALGHI4WIlQ7M438Xl+Po+9N9hhLyi/WzxD1YpgNITNdjV4h0EO
	y6UwXttjuzn9r22x2UQ0qKJBcsPjIcpCl8Wvc72iIyvDI8HqJwbmMrv49/lgPh7b5zj2Ca4RF1q
	luzC11Wwr0IOGCNqbKwTV+CCjYEwUVrq7OfiNtLD2w6UMFNgap3oMrKAZFwubpsaLkFW52voWhF
	u55eiLUQZefqwWSafkzAVIGtuLYaiQt3ZDGo5srTEJ+RHtxrIlQWha4FfEuOh6LUS+hMqeaOeJe
	dHsWHZx3YnrcOnHAui1nJ2xDaBPEO3biXYw0GvemIzO9bNPgveUZ6rwv7vCUIaFHHaeXpNV8DcD
	HT8QpmWHC+NqDhWo+BVSP4XNPC8IqqBOZVMjmEVoRhzR0jUzhc0PostMdFNIdXQZ27Tkrs9hQBW
	Am+jnX93Uy2l9yzc90n8XxNHFDgH/7s6ctyYtsN5olNFjJfec4lrY/vZ7gVz/yvuhPuMCZJ0ZUz
	PIfNjgXCW/SKNShEtLOllYoQEtcnp9kpml00jmuJMF9Myodrfc0rG6wWgVqqsnFWubUq0ac/CdW
	1spTHUQUbBagyuDxJmKcAezjP0JBuzEd5mt9JSM4muKIML53JNVjTDqU5lY9vdxkzwEIhuh441t
	3AtwjQwnew9rANouZBr8=
X-Received: by 2002:a05:6830:a1d2:20b0:7fa:ab72:9e01 with SMTP id 46e09a7af769-85ababed424mr1852580a34.25.1793205898765;
        Wed, 28 Oct 2026 09:44:58 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 33/98] blk-mq-dma: map the metadata a passthrough request has
Date: Wed, 28 Oct 2026 10:41:36 -0600
Message-ID: <20261028164415.1262013-34-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

blk_rq_integrity_dma_map_iter_start() sizes the metadata from the sector
count and the device format. A passthrough request has whatever
userspace gave it, so too much is mapped past the allocated IOVA range
and too little hands the device an unmapped length. If the data needs a
second bio, the iterator moves on to it and dereferences a NULL
integrity payload.

Take the size from the payload and stop at a bio without one.

Fixes: fec9b16dc555 ("blk-mq-dma: add scatter-less integrity data DMA mapping")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index e0e7a18790b5..5df704bbd98a 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -13,6 +13,10 @@ static bool __blk_map_iter_next(struct blk_map_iter *iter)
 	if (!iter->bio || !iter->bio->bi_next)
 		return false;
 
+	/* All the metadata of a passthrough request is in its first bio */
+	if (iter->is_integrity && !bio_integrity(iter->bio->bi_next))
+		return false;
+
 	iter->bio = iter->bio->bi_next;
 	if (iter->is_integrity) {
 		iter->iter = bio_integrity(iter->bio)->bip_iter;
@@ -348,6 +352,10 @@ bool blk_rq_integrity_dma_map_iter_start(struct request *req,
 					   blk_rq_sectors(req));
 	struct bio *bio = req->bio;
 
+	/* User space decides how much metadata a passthrough request has */
+	if (blk_rq_is_passthrough(req))
+		len = bio_integrity(bio)->bip_iter.bi_size;
+
 	iter->iter = (struct blk_map_iter) {
 		.bio = bio,
 		.iter = bio_integrity(bio)->bip_iter,
-- 
2.56.0

