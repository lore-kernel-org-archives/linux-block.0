Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B930328B4C
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788956; cv=none; b=HmM/RGX65wP4Vb0Hckj2BbJGNAhSdRh/e6nzog1Mfuwlx738CgPz+l0uFjjfvBEoode10apKJUHrGLLl7mAmrxPlShm5GD9YQD6NoWja1wpFaRfPzfEiXKfAra6ecHsUnTqtoVnC90lxotqvteV+4Eg1zuaPtM/0ifFJ8Mz4aX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788956; c=relaxed/simple;
	bh=vkIE579D9Pf51E5Sv3rJ8Ww4OOZEx5efXppTB3JrexI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCY8BWr+JiC8Fyyt0znuwfKTBa2qlTJqSbASRznEtEC4LOHWRGHEtN+80r+gtMpIIMD3ftMngOl8CvEi+cvrcseNsYpE9/efvXHvbTEyspEnKIwA8QQWLyC6JxHg2ouEQrYbnWpaIN+D0H6stFS7iPDIu0Byk50TQ+pbJt293Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRZ4FSnG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRZ4FSnG"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b9387df58cso4843609b3a.3
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 00:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765788955; x=1766393755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/N5vAhucA7uJnbwMQ9KUYNMH41B1zET6xOOzn4WvilM=;
        b=GRZ4FSnGzeQgvaVFFuDQHsXHLIYn3M0aSvWLCykK4boEHuna8ORoS9kDkHH+fFa1Mj
         3IPz2ZcQlERPEO+c8J49549G0/ntHIELpWAfKxS3ejoJmB5ovVodgZZwEIRlqj1e41i/
         oovTtqMJQRrdbejEQMe8C3A9/tmZvEIN3ddYae7vsLr6piGt0w1tBErnS/Dx9OK4n04h
         sGJPovbWqNSEgv98CZ/CLRQQSrAppULtydAIedP6E0fSPDO0IqH7cbmM3Juh59S9lYik
         ld7ww0bUxCQcZBtusz9KpUOLpECVnw+BpyujkKHnqIfJJStlDsMdU0WBn9/uxIFNJLEY
         FE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788955; x=1766393755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/N5vAhucA7uJnbwMQ9KUYNMH41B1zET6xOOzn4WvilM=;
        b=WOUFl+MiLbOD43NNK94NguLvtXczsnCZrOrGQoRuSp7+oE2DOK/HCL9zPQcNYMDWcF
         Cfgb4ltxoQ8L4phZx1pRIq8/LDSpI0UXOtqBpTMITTlN85ht7M0ISONgQrpCnNOWfQRZ
         sdA0Vv6pKMTni3HBBkiyZ8cQBKCdLiZ/NABJbCx/zGtlrJcJ9jEflxUEy2sIPp5xVm2o
         SVENvQupmN9YZoEZj6xJDzpqDWRrK1MG+gLXGT5V299DjI4rOSRYh8tK0omEUeyuFpnl
         i9E74NO9hi05jhGUu8K8sv1hrwDqSXmH6XdI1hCDOvrG05mD96pGloMDwPLxGN5egEAP
         BQgw==
X-Gm-Message-State: AOJu0YyMNrcs5HqsNjZBP+q+Zi0sIipTaDLLTBF/hpUix1tm3GjBWvR5
	qU5ozN2RznJzZHzmUbYtiaO9OX+3LBnvHdF4XYCUXiTtEhX8OwNNi2uB
X-Gm-Gg: AY/fxX5ucuqJYKfXUgC3nuQcUFU/uWbbZw0OUq++XKj3LVDXx2DSjaynxKueWOrf2MI
	VTmPJz0INQ3sykWLXGFuiAusKP7eJI1jYb0HZ2VIanqdDTwdpE/mJCeD7g1vcbg/GosFXLFUoU0
	1DVksMYZ8gPC1+APU2FCZ1RKzMZjfTB9kQe6Qsa23k7oBUgVb0Yki11P8iz6DZqiVMv7PqbrL8v
	IqZcHFBOTo5vwFQQ6A8UeOiXorwbvozkGQkH8OMUx2sciGgfHeGRn2VkNGhO9xiw6sMj31J3hkD
	zh0KltGfrHLhzEuuQK3As51NWTXkRb6/mVAaNT/QUJp2mgLQV/pHJFAeYAzEevdgSTxnbxR+EPY
	ngfSFWG+TlDLpNaZs4bB4aJZpCcbyS2KShfi5NURRtKWUTWk0XsP8XluNeQI4MdWBPTAg8lfbET
	3sHnyLug4ik9fY2oa/No8/vVsIhI2fpJ1Rdf6KiGILBcV28vNDj7zyXEl385B6A6Groo7N
X-Google-Smtp-Source: AGHT+IEt0s9tgTqv2Fxl3YaNfdE9BBsrwJ7AC3l6+9nM2j/CR6onhuRq8BTIequowO4vgl8do7JO3g==
X-Received: by 2002:a05:6a00:3309:b0:7b9:a3c8:8c3d with SMTP id d2e1a72fcca58-7f667447783mr9820353b3a.5.1765788954645;
        Mon, 15 Dec 2025 00:55:54 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2379e40sm12003114b3a.5.2025.12.15.00.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 00:55:54 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [PATCH v2 2/2] zloop: use READ_ONCE() to read lo->lo_state in queue_rq path
Date: Mon, 15 Dec 2025 16:55:19 +0800
Message-ID: <20251215085518.1474701-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215085518.1474701-2-yangyongpeng.storage@gmail.com>
References: <20251215085518.1474701-2-yangyongpeng.storage@gmail.com>
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
zlo->state and data_race() to silence code checkers.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v2:
- Use READ_ONCE() instead of converting state to atomic_t type.
---
 drivers/block/zloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 77bd6081b244..60cb50051e0c 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -697,7 +697,7 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct zloop_device *zlo = rq->q->queuedata;
 
-	if (zlo->state == Zlo_deleting)
+	if (data_race(READ_ONCE(zlo->state)) == Zlo_deleting)
 		return BLK_STS_IOERR;
 
 	/*
-- 
2.43.0

