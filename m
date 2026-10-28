Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205895;
	b=o5rHKmDGQxeAqCSL4Y7nuZcmTPvRWu72f8vMFhcRgNbapRAxYo3Z3kwlvAHVMSor2b3h
	 8k2ljbCMulc3WlP3OEVlF2dFopQTLRLXPxcRVm6GFNJ/P825n7DEgn2k9BaJYmvCaPq7j
	 CiLsOmx1MCDjjBt9ydkcdlxSuVtNZkfPEFdgCGiHIs4rk4GJO50BKsnTcmACmd6G8gbrS
	 9KVFz4ItNOdtpho+M9DHgps9sK+7xT8zZXLGLH9i1VuVWm2wgxYRxjBpFasy6csVWJRDN
	 9T01JhMr6ltCNLv3Wz3maU3oKuEgAHHL2ZMFdtoEL1i153bbI3k0TWr4TVsP4QaJqzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=78bb+mqb2uv99T8zCwLliT7H1Zgoycg4R2SVxJNabvY=;
	b=Ro7atS+pxwAYf9OllTYBPkbY189LxO5trClLiaaYMury41ZEjdNcBS6pPXp5BUJMN+53
	 qU8cfkG/+sZv7ev+K23RJdRo88xq4WaVW5KD+2HiDBoPLsVB2NisQxBOsbU1NE988sUq5
	 Pb+62pClVwISErGYUYmhSaA0Cf2F/AkN5xnUnxa9YiJTOuI/a0ofvMxYniS4DWkfultQ7
	 f/22TUz7O5fUVGRsXcFgxMKnW4gH5Ahrxzjzrk2bHa3F/ceHsLf3f08utEeoMcva6YNq7
	 7WVq2qaUYYtnhkHO/HxhfGONkLvtx0D/08Srh0zcAA34wojSHcGlXjYhG1D10MADrXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lWlYTe3Q;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44B606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B44B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lWlYTe3Q
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-84e513877a3so1111333a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205894; x=1793810694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=78bb+mqb2uv99T8zCwLliT7H1Zgoycg4R2SVxJNabvY=;
        b=lWlYTe3Q2Nn/bPK7U6OObXRkyWCXHKV3//TeUUy4DDvwHz/zD6qk6+l7mXguYrL2VB
         xm4zjv7FAfZv/e60SwWmg0mQsXBngFpixpPKL+we0wBvPVDfRCbJPpYS+lbXcNmfV65h
         R9mK58/dR/XStdrCjYSe2l8oy5lrHdjstuYMuEriaGf7ARoIfPJ+bxcagHL8a5lKmnJJ
         p/1u+AzWfW2kRHJsJlEUmZr8PaVhUIrn3deL1FWxa0RW6ED10teDb4GyLqzAbwftvyax
         1T3BttIp0yOXrNkTt6tQ9KGxxWdZk5ipPwQGLfCDwa4rI3JeItSjAIr2ijaDmaL+l/u1
         nJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205894; x=1793810694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=78bb+mqb2uv99T8zCwLliT7H1Zgoycg4R2SVxJNabvY=;
        b=IWita1ml4Dw/WBXWtQ4QsttGRXoLN1feXk6enPCOEDFNAqThurBn3ERg9JsGRj6Mq7
         zAsvMzfc4eCY3yhc32hJrn+/0bSCcv4sZ7gp2be8ZZSHW4bowg4Px0QI8w+WvMUBndd+
         A7YtRADjOvlsi4ItdqRRu5Sd58crfe9om/wCYG+sA49tD5z2bt0XM7VCilNvfoUes7B1
         qDoxcegKicpN6xtEu5FWNo/8dCxGoDJksdCRKQnjv+v3AZ7TBQuz2/Tsenen+QZLV1Vw
         4mB6igj12hCf1JdCpWVDtD1dzariKsk7ihazCLQYcAtBQFQ5Z3Im3XtC5gkkftjtWIoO
         qPpw==
X-Gm-Message-State: AFq9FYLmoIoBbBFXwcWym05kKfXUa1DrqDKIgmDQEFlz12G5nEnDapU4
	sKT1Nyx2sM/a8UnmQdu45UeKb3xbCgAoZNRy8BS8RgOAmue9VAyMgKQRbFzh3r2492x6PV1Lhc0
	i+Whl8Is=
X-Gm-Gg: AYBFou1S6MTjJXBVGggGSrdMXfLsoJYMkZtB+oUdKyVRRpwXIhVyXO+F4kBJndoLou0
	5YMOFAVBcKPaMFakKg/nNzAQ4MzxGACvnigovoodsNEmFzcdmMClTCo+i5aCWIXdvalprn4vnyq
	LxKfU6zMVQkdDA+RyqCYBxjuLbf5Raz5us4Hjx7t+jPlYXZE4h0Oh9KDDnEe1MQgGcJAmvJkZ69
	uFeuCaYX3hfq6K41+4/X0qVxpes7VJo1P7GjGMAQtQn3LkpR+bWZz7/8I0+hhnN3GtfM/5g9io4
	whsbomQtW7cOOcdWcWgs9EdNEeTB2Q0BVI6XKS5TwwwuQv488b0jWmDI6OrHFCb3/36qswBJJt1
	yzsDV8CQW+rZDBSAXo2nUG/QOpdDkNMknckyd6RFIi6vCtk6UZkXIfUclbzL6HrpkBNlSnF31+t
	5mz9yz9UlslozS0acO/UtKyi54tCMlqFuPCb4hjRD16wXMpGFMotH6Hc5iXzPUNo881VoZDB6oW
	pF6kzDisvLX8GEmzmJWcGtAv5QmiWwRwsZx2vrKT87e5jKz3fysRWXZHz8bm8X80O9jwYFHdcSn
	zHC0nqJIAwy6cOYxL6WJcNPqBrfdfxjHLw0bC6fLM8nJOjaD9Vr2fD9qDQNEFDPfF9E7LNF47Q=
	=
X-Received: by 2002:a05:6830:4394:b0:848:2157:c24a with SMTP id 46e09a7af769-85c21498a8cmr58669a34.18.1793205894197;
        Wed, 28 Oct 2026 09:44:54 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 29/98] blk-mq: keep sharing tags fairly after a queue update
Date: Wed, 28 Oct 2026 10:41:32 -0600
Message-ID: <20261028164415.1262013-30-axboe@kernel.dk>
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

A hctx only gets BLK_MQ_F_TAG_QUEUE_SHARED from
blk_mq_add_queue_tag_set(). The hctxs blk_mq_update_nr_hw_queues()
allocates for queues that joined long ago never get it, so they aren't
counted in active_queues and hctx_may_queue() lets them take all the
tags. One NVMe namespace can starve the others after the first update.

Set the flag on the new hctxs.

Fixes: 868f2f0b7206 ("blk-mq: dynamic h/w context count")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ebe2e23df5c..6d3c60b4ea2b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5184,6 +5184,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 			goto fallback;
 		}
 		blk_mq_map_swqueue(q);
+		/* The new hctxs don't know yet that they share their tags */
+		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+			queue_set_hctx_shared(q, true);
 	}
 switch_back:
 	/* The blk_mq_elv_switch_back unfreezes queue for us. */
-- 
2.56.0

