Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58830FC36
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812209; cv=none; b=i4b7Da9j45hLy5wg9tBQ4psZriNKvDZIPZdWNeCwlOZvCq9KXJSVfOSzbHCvXIfS31dc6/senY4Q4No8M1C7pDcOXkUMjL8exX3qS7WdeZ3NMty5HkhtW4NkAteuTw6iScb/ZBbw4le2AQhvEfACnIlVZXHEN5vcY75J8Dhn+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812209; c=relaxed/simple;
	bh=0xOuk8wdxbwspBJ3FazLf0rAttLNWlB6G2P7qkAgELw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTpAjdX6uwRo5XzvK2Z80Wl+0fj8xffyO7yGRy6iGDhEEV/mPkqPhZAu+7fg/kwloaQ4p52V4GwA+AwHm/WRvMPTnRpdJC7ttVpcVpXAdb2NtDPNBeGty9aOlxp3hxVsHYFudfBZNccbyGc9HH18zb/Yp3vskrky2HHAsta/oTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkA+U/nh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkA+U/nh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0fe77d141so11601025ad.1
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 07:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765812207; x=1766417007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubDpDSlwGiYxCEZry3gIRHR2IV/uiKKz4PYzcpfsWNM=;
        b=WkA+U/nhWk5mBhEC8wo5PQhImQ0MoT2dZneqW56oz3Grv/VI0QfB8yNfglSpVA7NYz
         33qw+E86GGcYy/K0bYnNdRE6vCZXQ1I7rd/zQZGAnO8EUnX8BZu4Sh23jq6Z0ZXfZw2I
         A9QHGhZqTY18bcTnnwNxXEa+jlne6FaMtv1MTiqiTvIKrufBgZGZ5lSdor7MlvJTRcvQ
         i29ommitA+DJg2GvCecMH13uxli3gmkHZzkIxL/zCpsmpT8vduNC0XP2KS9e570mPK/z
         U7pgwe844mU7UzizEhllJdgF7EicO1PmQvSD31G7QvZSqQPWpjtTIOavMPcv5tMiQSGS
         nkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765812207; x=1766417007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubDpDSlwGiYxCEZry3gIRHR2IV/uiKKz4PYzcpfsWNM=;
        b=ebqGE52G6s6xWD0kqL11uTbhJGW8aW/KCt7mhfwO0ZOTtt7t9Q+mhPYrxSMjQO6DVI
         G50Jb1OBaQ5+cS91I+fclkP4gGWspByglqyqSW2iy9o60TBaijzosQl/Jq/vtDqVlh3M
         n+VwOzPtfZUIcimdYVkGU/VGf0+27BH9bqM6WZaywVX2C/R8S8jvn8effCAmW/Z/4Agw
         pb+LFNYakGUU2LYkM8Mh0peidGjF2vGDyolOhNx5uNeG0p9PjOb/V6Nn2oA0wzgvEJ/n
         aS0TqIisR+XSKj4RuVRkF0Ye3/rggFvhTT/Yz8u1VMaMGLtW0dl8N9EDzr7Ixmc5KZY8
         rnKQ==
X-Gm-Message-State: AOJu0YwdmgV9/EvcYqaFFlPMg74g6OyPl01VOIu2SSBn22j74D6fbBft
	ol+XshNKKjB69xuijA2tUFcEZARJWlbEEPw3BFFz5XN514FDbW+c2c7c
X-Gm-Gg: AY/fxX55bgzaUZX0yxUFAqVq7mnpShuz6GjpyG6h6092SbdgzsGW4d3alH0z3ysPWYS
	jzL+4c6IXIc3LX2/I6/0FnDAdOB0dQynkAY2mayjLAlFvOY/xN01t173oR8LOqjMQwEa1yY5YCd
	/T6ahYzNRld8u862Qr0LUgu30989Ncrk8iGVTfuO1nYuL1Swm4QvqaCBSvcoudTJRErkwFFu3II
	dav6VfBXCiZsXaj6YzNAXJxna5DCm5MF8WrX4x7j4100qHHqayAI5nDMNB/P0n3tFLV7v+rjF8K
	xwa9DViBLOugvmgdrUeAJDrQ18YtSjEt3cKi1aNhcSx+UPV0xqcmHbCcrsctvbZu4D+vSgMG1bM
	68a3khRQ6Kp8lzEYAwbwYznrRj27LkIwQDhkpaQuc0smOcRJRyurok8glJFLTane35NmpzID9tE
	ey09Oqg0a/IjTRfLxUxDbW4gfPcF0=
X-Google-Smtp-Source: AGHT+IGpIXm8vVvX+I3IToPwO/s6cUeXASlSeUb/djN0AOkueLh21W2xQSX6dZvQajgW9ovu84v2dg==
X-Received: by 2002:a17:903:3bac:b0:295:7b89:cb8f with SMTP id d9443c01a7336-29f26703786mr108796435ad.0.1765812207204;
        Mon, 15 Dec 2025 07:23:27 -0800 (PST)
Received: from monty-pavel.. ([120.245.114.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0b0a708a6sm59372525ad.97.2025.12.15.07.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 07:23:27 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [PATCH v4 2/2] zloop: use READ_ONCE() to read lo->lo_state in queue_rq path
Date: Mon, 15 Dec 2025 23:21:06 +0800
Message-ID: <20251215152104.6679-4-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215152104.6679-2-yangyongpeng.storage@gmail.com>
References: <20251215152104.6679-2-yangyongpeng.storage@gmail.com>
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

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

