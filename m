Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955125484B
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250603; cv=none; b=W877JEbumMmpa+2THjMO2Vuo99rjiOusj+4dGRefFtFA6gUyBKhcI4qvSUSVq5FqqZ0GLenj2Adleg2N9vDzyP+4twWEtxxxZovEFxWQZPI0MoNKRq5iczrj/K/xdn0uus5dEk6SMy6zME8pcysIk7xspI1cotphNjC2RObHk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250603; c=relaxed/simple;
	bh=xNC4+5vXuGIoP3AubYqeZ73I0t9q26/OKWO/Q7/2G4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2c6K4a3feDNfRSSek7jpDX1FQpOnoHsJPsqzDtR603pYccd1p4AQyj0nBwu0L25jLgUiPKPwYDu707L/c8HkuK6U3xWdf9WmaTkHasYw1vrCuEks4Vn/KHIsZou44y1jUh3cU1UMdcQ0v9SdYYErNGxDokThdMskrFE2oRDkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F53VD4TQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F53VD4TQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24457f581aeso16767545ad.0
        for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 19:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758250601; x=1758855401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovDud+Upvoitt+mbnx9bJAksUkvB+hvEmFPUqVI4Vww=;
        b=F53VD4TQ7T1MFExVOJZH+AHAqsNVxQ4jMLo3r8Ii6q3JavLwt4sshQ3pxpboQEko3P
         WisUsce4WNVV9Fkn9G20N6fX/D4gusMOqo0Z8EFB8Mqrri+HYHMFjB3KxWJdOgHiC6tO
         3M5RBfargClu2kK9ECpZkxANw70hZR5W3Na6DRJFQolUO3XrUHdiAznCsbpIBD20uuP3
         M09yyvInrU4xMkmeMdCQ+ZfPAfhE1efOSbp/HKm0UUv2YCCi8+03qSQnmJkTTj8SwjRr
         BWDGc9+dz4oVUuOj27M9gETheGFO+u4uymBnoZguBoXqg2rdmuZYOv8AoeIVT8AxOaM2
         R/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758250601; x=1758855401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovDud+Upvoitt+mbnx9bJAksUkvB+hvEmFPUqVI4Vww=;
        b=lmbsb/BHh6nRnlZ7p+FMSWtcETB9j+gBFRnFHRQCiVDWBN29ap5vAPBwheTNUIEkI4
         MZZaVNGpS4ZyxLG/ZUn2C+Q6MUg2vljX49SrcaNKCEs1nkk6dQ35YdBrprLQrMLmQLSK
         OUHxCUTJf1eDAiADGiyIK4VvyEcW8cvW49gcSYSMXjT8mHqaYUb58oXBG7gOGgSXzoqn
         Ru3lIClHzFRmVm6FptC04q+A7a7PObJGh3cx31Ke6GOpFNBqXsq4gXuZyBxgiFMexcxK
         fUakk1vbspGnDph09CSCepr4bwl2Bj4jOEZ7L34IGWx147NQnWF+k/PjvXlUwfNbxliB
         z6UA==
X-Gm-Message-State: AOJu0YxYkYMHIiICLI4L7/wiSmLt3gCGoM2VlBXOg2Lcd6m0nmsJpX5z
	mEHdTNSVA6yQULPr8A96eWzQsuIgsgWfv+EipQznKjiVMfhhgagYhJfc
X-Gm-Gg: ASbGncvtI0nIlwvGz7PdyxmWlvxy69q5lBlQy1mcXxB0gWFQCRabfJbCgt7Pa0QS8BK
	5ZfoTDekJ8ZNZMTp1hG5sitbmit4cDLRzpk2lWNvIYESpXD8P8JcAWoiS8imPBTEjBzNrUqdA/L
	cKjaMbXikAI2HLJds6Iq7svgEV5jLwE+23D0IT1e+0F3goHW9krD/wFPI2JMb1Tfz/llfz1SMwO
	elBrukPwdjdBs/8x/3PdSk5VukfiuJGeuPlCqFJ4CcyxBsd0+1Gaw5EXPHTXRi9x4p7czCXgiTv
	LsrxkqhJC7VM2F3RQOMxhTqdJPUhCJtdBPzgM9evAXdxBXr3PVn6SRv8+bvCwEVFvGor+vsXaIg
	jxTeHOJZQL2fmMr61+nN5+ppnIiYzZJLg1HAcke8EHR4WAdLL
X-Google-Smtp-Source: AGHT+IFVASUMAByOUzxhSZOaC8eWyRPR1v9bRmGRUVLFszgWHEkfj3GYG9eKFdaTPNiM79F1DMo7BQ==
X-Received: by 2002:a17:903:1b68:b0:264:5c06:4d7b with SMTP id d9443c01a7336-269ba51703cmr21441145ad.32.1758250601071;
        Thu, 18 Sep 2025 19:56:41 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c08dsm39504675ad.51.2025.09.18.19.56.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Sep 2025 19:56:40 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH] block/mq-deadline: adjust the timeout period of the per_prio->dispatch
Date: Fri, 19 Sep 2025 10:56:13 +0800
Message-ID: <20250919025613.39771-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chengkaitao <chengkaitao@kylinos.cn>

Reference function started_after()
Before modification:
	Timeout for dispatch{read}: 9.5s
	started_after - 0.5s < latest_start - 10s
	9.5s < latest_start - started_after

	Timeout for dispatch{write}: 5s
	started_after - 5s < latest_start - 10s
	5s < latest_start - started_after

At this point, write requests have higher priority than read requests.

After modification:
	Timeout for dispatch{read/write}: 5s
	prio_aging_expire / 2 < latest_start - started_after

Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
---
 block/mq-deadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b9b7cdf1d3c9..f311168f8dfe 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -672,7 +672,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	if (flags & BLK_MQ_INSERT_AT_HEAD) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
-		rq->fifo_time = jiffies;
+		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
+				- dd->prio_aging_expire / 2;
 	} else {
 		deadline_add_rq_rb(per_prio, rq);
 
-- 
2.50.1 (Apple Git-155)

