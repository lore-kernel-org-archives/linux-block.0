Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205867;
	b=29NYGKwPxEp7+IGb15CKZwZHx3GH5hgozCgjDdzrv/nXN5lJDirdghV4oaE7/4aAk3eS
	 HZnSFHt2S5f92v+VNoiS30bZiYhxR8vvYzW05EAZ1AviD75kqozJ2g9YCZoHtcPHKKBVd
	 ZiY8s2vDlleGLCt5n4IPaTTf6QCMc/ORy8D+0kB2Lnyc5lkDRfEQVD8SIK0UW/nj6h8Su
	 aro5JfM+tOXqU+F5AQH/nASfX8njBlEYI53lJmfKJzrP7O4JlaUhCzYSh1RBvAmo2QdVI
	 G9qVg6X7aE9TZflEc/cnaTbvAR6m544KWt5bDJj5rmGMugV+5suEnNQxObAYF0wYVsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3zlksk+szWesURHU2uP/038+MxMvNFlFw7Ao4PeKoEw=;
	b=IeB7kJhCi5xwR5l32dSPYVDAX06Y54WNCMhCX9Nw+irozaVI8e+AAi6LJAgL1C4mYIG6
	 /6QZY9vAJv7tivR+8eMwXQtVD18iMvc7D9xv2KQDs4vjziOUU/cuaDW4vmzm/6wuJsAQ1
	 yj/3ntdUH0reVO2oAOxh1nt2+Yk2qNOevLPmvJKvCKBsvZ3sE3NNI0WcZRNHgGPRHN/XV
	 ZUABBuoMo3ap774W+PZvXRg1x0WnF0OJ/KiXASWSdxeBBtVHMxPDKDtB7m8ovqNDFVMWl
	 LbPV4SjkeQqSMQEjqKCefzjN72S+yyDoYuhgF6XiBUzlePYXh8K/ER36VY5M/QsJUYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n5uZz6Xk;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D364606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D364606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n5uZz6Xk
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-84a248254f4so775098a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205866; x=1793810666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3zlksk+szWesURHU2uP/038+MxMvNFlFw7Ao4PeKoEw=;
        b=n5uZz6XkmEJMrCkjYPM3+vpciNA6SFyZHuPPoLd7HgRdyemHWG9zQNU4K2CnLZLOyt
         SU0huidsesOd0FqCjuBAoKFUWQqXdXiM+KrRy6a96vWrM1g+CMw8kp+MBbmH6xlGpLT0
         dCycf4ZCkpb3a+1s12kyR83xDevMFty0Kgo3qwACjAGU03CohSh84bxKSk294Opoh7Zx
         wrIhvRkM3+ENtGyAHdAfWzB/ri5fv2ioH8pzbHiR8kgR1Hbsc+zTvPiZezzFR1jiFv/2
         uKwPoQSNUlvKyzooaPM8HbHLlIfZAlooq2UMDAtQGp2np6bgaKzBDmCqXShUyDt4A/gc
         +JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205866; x=1793810666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3zlksk+szWesURHU2uP/038+MxMvNFlFw7Ao4PeKoEw=;
        b=IPQFpPwecvi6TNjJlhr2u117qgSZiHWoXVOYoE+s7XLq/wvfvxs0q+yeFg8wjWOOzE
         QVtHgMW0btAiWhd/VUAYHpUkVupe1WGpC3ZD7uAifL5JX/U+oytiVg/9PUQG70rA+cc1
         +X2Sl17VONOkxPEhqO/pyfHEUn28iHatPXXj2frS2T4HgPHkAknM8NF50GyNEko6Vlvs
         Dkp0y5JIvFr16b32vmJ6oViasUtYUWa3p2Wb4Iz9XXytc5/xjgeTdmf9/ODEOKH/9Bew
         VG7OSu7o8g5M8O7JDX4Vpm6Hs9ZYXVfb+YYZVvOzHYY/gG89zdLguAVsZp2tOwWiS0Ve
         rRsQ==
X-Gm-Message-State: AFq9FYJSxk5ZqNMM6zHNpvrk+Aub/6Oreh8ty9dz+wlJ3hmV8djf4m4D
	nMM6P3CbWTIgkroOW21WSGSWdlqb5nou0WwU8BQEP+qE9Vcg2wlUAfk2+lQVTUgdxOC47NfOtVO
	ouf3jig8=
X-Gm-Gg: AYBFou0G4dBV8hy3msLiCc5H/9fHBJ1h8uJUbeKGwIhc6CqmTBKxH2LTmtc9QZ1QAwO
	uc4AUb7TrZxiLNIN3OTJ1Ja8y/jIZgsxajoItELdF8I+2mHhlba3H0RJAgX5B11QWOlBOxuU1LH
	Nf3HaI+SOA1yNUrspb7KwDQOU2ngKrYsEiiTVV0VZbiSiMcHkWWX9sronn2kpvQyMBwYZOzaftN
	n85UcGWJAwGh8D5em3yg18L+qz23DKB8NFueO3/sN56dV8vL2Ex4RcY2Mpc+IijnN/gnqH4X9u4
	mDig58i2Yi3qH78c/lGVw43SjjssHBGAbMpzQ1iYqeLVzQIlqY0HLyZDA8o73iDGo6LBd+mJFiF
	fxjNeFvQk4MUSjWJzSDdYT5AT0ajED12wDbEdcszseNpBnQITpQoAhVODkPhF/0d522juAZF5to
	SGrFqVoQW5cG11AjktSRrdGqIiHxNEp6viu1lRPHoQTbzsb3BGjdIySR12uvLPGPCriklgbQ7kj
	lfxwDH+zkcna3FOZKvwqkYJmAfs3ZY7BRCRMpm/u3Q0x3jwR2q0Kza5ozS7ToNLC1RfGw6SQvyY
	+Q098KzT91rWhFLByJC1W5rAkmDSlse66c3T2o6nlOhyouJ5IZNWlEGiifcpN552a6mlxndUig=
	=
X-Received: by 2002:a05:6830:90f:b0:7dc:dbe4:3f21 with SMTP id 46e09a7af769-85aba80af99mr2354297a34.1.1793205866229;
        Wed, 28 Oct 2026 09:44:26 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/98] blk-mq: don't batch allocate tags from an inactive hctx
Date: Wed, 28 Oct 2026 10:41:09 -0600
Message-ID: <20261028164415.1262013-7-axboe@kernel.dk>
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

blk_mq_get_tag() checks BLK_MQ_S_INACTIVE after getting a tag and gives
it back if the flag is set, so the caller retries on the hctx of the CPU
it runs on now. The batched allocation for plugged submitters doesn't,
so a task migrated off a dying CPU can fill plug->cached_rqs from a
drained hctx, and those requests never complete.

Check the flag in blk_mq_get_tags() too and release the tags if it's
set. The caller falls back to blk_mq_get_tag(), which fails the same way
and starts over.

Fixes: 47c122e35d7e ("block: pre-allocate requests if plug is started and is a batch")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-tag.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2b751bfa50e1..aaea2e2c2f23 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -139,6 +139,18 @@ unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
 		return 0;
 	ret = __sbitmap_queue_get_batch(bt, nr_tags, offset);
 	*offset += tags->nr_reserved_tags;
+
+	/*
+	 * Give up this allocation if the hctx is inactive, like blk_mq_get_tag()
+	 * does. The caller falls back to it and will retry on an active hctx.
+	 */
+	if (ret && unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
+		unsigned int i;
+
+		for_each_set_bit(i, &ret, BITS_PER_LONG)
+			blk_mq_put_tag(tags, data->ctx, *offset + i);
+		return 0;
+	}
 	return ret;
 }
 
-- 
2.56.0

