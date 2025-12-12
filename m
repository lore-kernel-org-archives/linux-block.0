Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E161E1E16
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550814; cv=none; b=mgt9L01nFnRb/EO9DP0CU9jbcV44iql22nXQV9j54mbY+Mm+IeAKZLbwT8atH7DzTxON0BIBlEPkKObtop1XT1MHHTzzb87qRpfdz26lNCGKR4GsDaGyZAPT+MxZp9Aq94aSz/AXTwEzgAvlXkj/VDZOeiAD4fc6P2bmJYOXF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550814; c=relaxed/simple;
	bh=qmFEDa2NLLasOLSOhm8txfA1/rGqYmFJ6IToPq4wHTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4YRQcbkBnIdana5sizMbUoxnNfI4/+uKqn7WUmYwWtXmKUdbAdqm2xkHyNZfwcutmTsZXjCZxjGrzKrSxr6FdyXJYvAw4G3CVdJiKhv9kjo5nj0r3oEDYqKV9HP3oGaJ+m75VE/CI6SbWnAfmXDL8708vFqZwUvNH9cY34m3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgdDqqWM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgdDqqWM"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c21417781so199546a91.3
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765550812; x=1766155612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXPSxf5AEZ1DIE0pya5/aXKXccXbdzZZtG1gO5bf3j0=;
        b=BgdDqqWMqlr4zyl3OOMXHOPkVLoPC7zPskjZCWNXfQTnuDlsG0XyDN7aOM3GHY1qid
         AZusnNmG0r7K1KPmR/OdHeykD49VsmExsJq/iQjEIPqLmyBilraNtJQO74VgKHJ2ux8k
         r4Iav6o0b4y6zNUOP3qFCNboG4eRliYWascGQJwemVRIGgzLa/hknzrCsKcJ0tvAZltD
         zayYGHO3m6LPO++Mq9yimVexK5mGYC4EmxFPTpXfj3OEQEgb04Hyiu0kR1yOxSjdv/zt
         9jUkPJ68QNeUqKLEhTRe7H8JRKP/5ToJasd4nc7D48UGfqxKrgphlMzlsoN/3bSV61c5
         dwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765550812; x=1766155612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXPSxf5AEZ1DIE0pya5/aXKXccXbdzZZtG1gO5bf3j0=;
        b=SV//vPS4f/GxVZJab1MS2xgWGBSjn40EYTCvxhNgWYS6efx7afmq5enoxLdSY7F4/Y
         zmF3u2lsurUkJNJ4+Jm78tIjnAPoL4I9T48iNM6DB86YbFUrk0zwQo4uqp7/yaqVuRMA
         gYWxqbGVgr7hefCiN2foi2bmDb5OVaPopsIdEuD+nKwJH3CV6omwFLvp1WSyuf79luBB
         A+LmSh6rktrarBmorgrbUPMY6IpoKdu9SQ6ICUj/sWz1PaN17GXOIeqX1TvfILoI/hZG
         3Q/We9XgAYkMlcUiBTmdP0dX8s+Civs3leWIWmCWDFY8IHIhGijDLyYyu4B2uSftuzDg
         6wAw==
X-Gm-Message-State: AOJu0YxoEYGlSJ4zOKYZhKamUNevN+NytnWvD9zFBzf99ap49YqeSCI9
	bdtNm2HKQ9cRA4a3aZ1veLQU50vMuWWBDljL7aQI86QCj6barfVtGTgl
X-Gm-Gg: AY/fxX6SyhW0zmrYHFL2tJv2KAjLOUewva0YTdj+MXXAO/doogpjk+jP9Bo8Bbm+GJ7
	WInw5IFsAgfuMvtxfqg47Ktbqwah7fLscYr84/YTXjp8Ezhd8CBmqb6UvwWjvWw6+Nx30AjeHM8
	syY4kvUUG0iZjoXOqnW83aUI9ryKfj5iSuRP0WKDNY+N5gTHOS52KImR9Ii4Np4xerWEEpIbp5o
	ATH9Msm5Q5JV1GImr0ZRN4Ifgvhndtb6acfdLbFk9EMzH6q/0NCNmtrn6oPL5Hw7UlXBlUVvyLV
	n0jLV0tKSwvjj2AQfOwABW1Poa7I/XhArd6nE49E31MQEgBpQ6QeQGA1fSHwbOIMGEnVeYpJwlW
	2J1r+k4NpZez6OgKfZe8tND7UnCJdAhKcbN1Iy0Zj2+vITtQYFHRf4siDoejkr1ybyZ3k2DqwLY
	IM5jwomP7YMgyTCeRY0DLKSJZWbBoTysq8sXvM4GA8sm49ibLO8UWOnMtBrA==
X-Google-Smtp-Source: AGHT+IH0K3c5a6NfiBsmD6GN37HU7vqnQEiOpkN0hzscNbsmfEZ52UMguOyL0xnqW5uAtVVwXwv33A==
X-Received: by 2002:a17:90b:4cc8:b0:343:e461:9022 with SMTP id 98e67ed59e1d1-34abd75b841mr2292679a91.24.1765550812180;
        Fri, 12 Dec 2025 06:46:52 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe32d3c8sm874664a91.6.2025.12.12.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 06:46:51 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [PATCH 1/1] zloop: protect state check with zloop_ctl_mutex locked in zloop_queue_rq
Date: Fri, 12 Dec 2025 22:46:18 +0800
Message-ID: <20251212144617.887997-2-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

zlo->state is not an atomic variable, so checking
'zlo->state == Zlo_deleting' must be done under zloop_ctl_mutex.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 drivers/block/zloop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 77bd6081b244..0f29e419d8e9 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -697,9 +697,12 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct zloop_device *zlo = rq->q->queuedata;
 
-	if (zlo->state == Zlo_deleting)
+	mutex_lock(&zloop_ctl_mutex);
+	if (zlo->state == Zlo_deleting) {
+		mutex_unlock(&zloop_ctl_mutex);
 		return BLK_STS_IOERR;
-
+	}
+	mutex_unlock(&zloop_ctl_mutex);
 	/*
 	 * If we need to strongly order zone append operations, set the request
 	 * sector to the zone write pointer location now instead of when the
-- 
2.43.0

