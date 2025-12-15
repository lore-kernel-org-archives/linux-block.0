Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67925FA10
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791957; cv=none; b=S1VEEltmMt3m+BEIUTLN9bdFuPZBfhVgNYV1qr/N5xw9cWwUcdtnKa/Rcc7zKH+dsCJEXUoI05tVMbIHJshXmTbFnEj7iP+or1QGr+teiFwhushh+2wM11rGbsZCjIlNbHyoagYjTWhvYEQo2GtUsZ1j0lMSk06U98/xK/g89Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791957; c=relaxed/simple;
	bh=gc+xwiruNX2aoKS3gVXc992G5uu0bka6oJO1vnI5phE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vy+oWLTHAYTS+qA94TEN3e2+d5438cLw2wEHjOOi6WqPSTLk7BvzWNpJm0RMaaiDw/nw1x/XAKsbKW2ljl/KYDh4ibo1lB57B5xxDzFBn/vRvbMTRtWgR52VdTJjMOdSkAUUKAF+KzxctUyxQeszSgltqcz6F6sZ8S0ECqV93d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuNI8WXo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuNI8WXo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0c20ee83dso13532455ad.2
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 01:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765791956; x=1766396756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHLS5xcPpyPgWAt9Fd6TVCm/E/uoSUqnXwT2zX99KXE=;
        b=CuNI8WXoNc/z6MeC4BVHSm0jn/uHPNVtmDZm5fPHbZhFLpBBay/89CMG4K7mOiSy45
         SPoEsq9Tj9EC2klG4MMPSNTOcjWCn8SeTJ6MOBQyvmNb08AvTqZOW3bdN5CS0Z4oI5l5
         QS8YmbEumzkrxK6PDs7ofwNOmZgIkedsvHaKW/f3A6e2bmRY9nOn9039QxAxNWZ9VU/c
         e240h7DSDcroA3xlmLqG4nuTYRlkktiNpdfTm86Y90v0NrZKkHY1L5MypPiKbLDbjNCi
         BWFDIPCr/omvVOZbMid9Ym8Tg6bqzYOwyPl9ZU5ThZ+IBDKxC6jvzRekb0Y8A/Tzi9Fj
         VCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765791956; x=1766396756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHLS5xcPpyPgWAt9Fd6TVCm/E/uoSUqnXwT2zX99KXE=;
        b=F4ufYh/+u++D+MQ1eVWG6Zhh1mJuxvI39f/NzTufAgv/3MmxHoaEai+apsXZkwfddH
         YV8/D1Rzfcdgji9g/IkeFcoH9/RrKz1pH17Vo0P0+5O7xsLO7n2NjcociygvDQb/3pvC
         nAqe0CBGuWq/qeu/FDx7EjQ98msfYpG/a+QaEe6KdVduaNEjYZ1qYwwfx4Aps0gy1u4G
         GIooYKwxYCuIF4nQ3Y5+W5W4MlUaDY0Dx+cTpAPi4kQ3HWwoDQdbpSZE6s/PvAYpjgUG
         7CN0Kj7tx3Rabc9JDsGtnauV1g3PNFsaO7Ioqj91cKrwwv8ifPo6yUdarfyCvYkY95Va
         PL0A==
X-Gm-Message-State: AOJu0Yzzf0RS9WenM4SuMEFa3aTdpyp/OoGgMSuC1ZxZPoDqzvoEwN6+
	HugPIWEHmp6itXmuyK0j66z1dKY9oSaaYkxQTxyQCNrVme0lv86BGi0g
X-Gm-Gg: AY/fxX5pBRUTW4S6D/bmYOhhh+02Hf2di7pCkTxcowSXlvKH5qYoIA/LLsAiuU54gNs
	0NoFE1W15sNsbF4UqzRL8nlY08JDcmZisqSS5o4vmHVE6stFVCM5obxmRldYLvihxMG9Hd5tveZ
	Zsvw09J9O8lsGn6v6aBhoE0DqWZhTcHlCBEWRycRsI6l87ohl3UaM3T7gz9HFvoRAosZEVxqHuc
	sb5t52RBrp511a+xl9JVFw5kKMZ1sZqxS3jCisLwcFVkmQ4ua26rw2UAc2sDpLVEhOs6it6GQgX
	Hkcqy44oPPLi/4m0PxN9ifJ/0a6Q6xVl1rNhZa03x3nBaM/PXGS2XYtzltlL63TmxmUbAM0GKFX
	Vcfx1iCXj4uNONZgGO+rMHLgDgSa/MTnWjANQW8eeTqFYrD05yp2+E1UqLWZ60R+bdFpTXVBdNj
	NMCWjqg4LqME/XqN3o3VnOVfH87JW6HPSSpPBLW/lgYdkSRhcDcdUaxAFcew==
X-Google-Smtp-Source: AGHT+IFssWf/G3w3LgQwO34Cnf0OECnECE1d2OZZ5gpS6O5qBsuss+4V4Z6/K8PlT/w/phj9cddJvA==
X-Received: by 2002:a17:902:d48d:b0:2a0:a09b:7b0 with SMTP id d9443c01a7336-2a0a09b0d8dmr53093695ad.61.1765791955578;
        Mon, 15 Dec 2025 01:45:55 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea06b651sm129401435ad.94.2025.12.15.01.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 01:45:55 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [PATCH v3 2/2] zloop: use READ_ONCE() to read lo->lo_state in queue_rq path
Date: Mon, 15 Dec 2025 17:45:24 +0800
Message-ID: <20251215094522.1493061-4-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215094522.1493061-2-yangyongpeng.storage@gmail.com>
References: <20251215094522.1493061-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

In the queue_rq path, zlo->state is accessed without locking, and direct
access may read stale data. This patch uses READ_ONCE() to read
zlo->state and data_race() to silence code checkers, and changes all
assignments to use WRITE_ONCE().

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v3:
- Use WRITE_ONCE() instead of assignments to update state.
v2:
- Use READ_ONCE() instead of converting state to atomic_t type.
---
 drivers/block/zloop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 77bd6081b244..8e334f5025fc 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -697,7 +697,7 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct zloop_device *zlo = rq->q->queuedata;
 
-	if (zlo->state == Zlo_deleting)
+	if (data_race(READ_ONCE(zlo->state)) == Zlo_deleting)
 		return BLK_STS_IOERR;
 
 	/*
@@ -1002,7 +1002,7 @@ static int zloop_ctl_add(struct zloop_options *opts)
 		ret = -ENOMEM;
 		goto out;
 	}
-	zlo->state = Zlo_creating;
+	WRITE_ONCE(zlo->state, Zlo_creating);
 
 	ret = mutex_lock_killable(&zloop_ctl_mutex);
 	if (ret)
@@ -1113,7 +1113,7 @@ static int zloop_ctl_add(struct zloop_options *opts)
 	}
 
 	mutex_lock(&zloop_ctl_mutex);
-	zlo->state = Zlo_live;
+	WRITE_ONCE(zlo->state, Zlo_live);
 	mutex_unlock(&zloop_ctl_mutex);
 
 	pr_info("zloop: device %d, %u zones of %llu MiB, %u B block size\n",
@@ -1177,7 +1177,7 @@ static int zloop_ctl_remove(struct zloop_options *opts)
 		ret = -EINVAL;
 	} else {
 		idr_remove(&zloop_index_idr, zlo->id);
-		zlo->state = Zlo_deleting;
+		WRITE_ONCE(zlo->state, Zlo_deleting);
 	}
 
 	mutex_unlock(&zloop_ctl_mutex);
-- 
2.43.0

