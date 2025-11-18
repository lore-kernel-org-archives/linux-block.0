Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B30D25D216
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429152; cv=none; b=XaJm00ccYihakwcZkDz9siNUxP34vjRMDJGh6E7zbQ5jtPnyysmakqeNqxcRSeXD736qTn40VQwEfUSPQV7B1xDQz43I2Pd+3uq0rQSDgpQ06nPWWjBUQgpwwmzjMt5TDXaW9XELXMGUozgpAM3VSHW2xThsQsVFVaMicrzo6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429152; c=relaxed/simple;
	bh=XDstMFVLf0fP39sy4/htDz6ee1i4BahZzUlULH/1Prc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/bYDQimit7ln2DMUuDK8SajK0GEFk0osxGZ/kC1HrgNB1Z7umZxmJw59pz0rA9RxKN88rJ/ljB4Ov/9nIm6RXQp/V6/IXzvCT5SvOSdGvmSlFR5KMTwCL52MriMpPhLhZv+9T2ukNkMWVd726HX/ZffBvKRmRULfGw30pDxllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrFo9VgY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrFo9VgY"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so4240490b3a.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 17:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763429150; x=1764033950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oy90XwmtXS5bXn5O2JgnV9Joban47vmmIBqycG2o+zA=;
        b=GrFo9VgY6Qjx01a3nBvMQkKxC7AF2rZxNt0fR6bbJ9Q3Fr/+8oPOB0k+5ns5p8MUXG
         pVECXJ57aMiVE5lhvcs1YDKWexk+N9Tnuk7/DUPl3futZwopLmSCSqw1tPsZn5PkvdGZ
         H6UnAYW2K3MShKqX9DSwPLVgN0UIsi5a4I3AdsNLXLT1ZuntNiAknG88/Tu0Sf78ggGC
         p78LM8KNTI1aZF5uWmT7+Xj7mpfnaNXZdi23RQT9mnHM6wKzoelfv7HJOMaNokNvaR+W
         i7EAMuob/xzdNjjEnUuCd7xiXQadmeA73SqFk9QPDYcdg2yP390nu13mygKA2ZUDz8HJ
         fFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763429150; x=1764033950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy90XwmtXS5bXn5O2JgnV9Joban47vmmIBqycG2o+zA=;
        b=ixtj3KPhcSQ2rvyyW5O4p9x4L+0hG9idmU5JELRzT5s9dBCmOQkv9Sat+bzvlxmYG8
         fDU6gTZqvl6wPclzuHN3p55lhSpm28ZQb4Jx3BY3SOr7CE83eo2Skd9crMwait4EwMUe
         qFhFPE9T/RCU7E8cVGuys12NVya6qwLmhIyDBhXOvEEUvwSH4xcP4BybehMOiV7PjTHX
         PGJaekBZPX4mwiefk+gMYarb8ntVGrtx5ZbNzO2NsidBNy6S7AOjd3JydWSt7EOyr1P/
         btrP7gZ+pVXmXbhcRG21qunknUV4/ha8khZcOW7F8rqgK85c4lyc+srTydmSVc2y7qgq
         1ezA==
X-Gm-Message-State: AOJu0YzIx3y1VYvJfIqooSWs7kqFr9oB/L2AZ9nY2oGDlr6mihiuIwyi
	og9BqWEhqPaw9CU7HmxiexC+wDQhkmBpynU9jeggG+QWvkp1NGAXp3Xa
X-Gm-Gg: ASbGncvCCQF+2NdEf/TM73w14nlg9KwAROq6nyxwQvOedKg2+HDRuuDZAdk95TPRfrk
	uQ06r2FJaCRgd6z5O+sCvYSoUuGWoDF7FUVC6HJTGj5TyRQm9CtQXxnBPWHKBm+AGBIlyNej4tP
	/a70qWiscimjhp95UhqpOJ4rXGwy8L5iJ/BuSQbn2mHaKECaNAZEr1V/478jNLszD/7MqiI0TUw
	wHCcgIqdEp7Mf9dQu5ShrUUJ+O3ejIHlh9khl0lnxxT+oTW8GS9Flg52Y00UDDxrirTHkOMiWnV
	eG5U27s+gBzmTGFMPZ4nMiP2dUDLg3ytzFptjsnwbrm0cfWSORkb27d8CnJdEtsEnKge5kH00sL
	YZQD9R+Xq2KjYbPyLqgCw/Y0YM64R0gZ+tyMaFmo6JLojRSd3A9lyMEYa/oCbSaclhDzuf4qpQj
	KrgKl1l2DLqjJ1FTvDNI4BYzU7K9TTkbr9
X-Google-Smtp-Source: AGHT+IGhVrl/+ZuzzSTdqJH1tr1q39eDqyR2QaUPM8zIEEp7x4SEyy6ymgaO82H9kmRNFf4ep5dv3A==
X-Received: by 2002:a05:6a00:178f:b0:7ab:e007:deec with SMTP id d2e1a72fcca58-7ba3cd6d62fmr19306494b3a.32.1763429150530;
        Mon, 17 Nov 2025 17:25:50 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aedb73sm14409054b3a.12.2025.11.17.17.25.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Nov 2025 17:25:49 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v2] block/mq-deadline: Remove redundant hctx pointer dereferencing operation
Date: Tue, 18 Nov 2025 09:25:39 +0800
Message-ID: <20251118012539.61711-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

The value of 'hctx->queue' is already stored in '*q' within
dd_insert_requests, we can directly reuse the result instead of
dereferencing hctx again in the dd_insert_request function. This
patch removes the redundant operation and modifies the function's
parameters accordingly. We can eliminate an LDR instruction.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
v2:
  1. Remove the changes related to bfq-iosched.
  2. Add more commit message.
v1:
  https://lore.kernel.org/all/20251016131651.83182-1-pilgrimtao@gmail.com/
---
 block/mq-deadline.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3e741d33142d..5007d811a738 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -633,10 +633,9 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 /*
  * add rq to rbtree and fifo
  */
-static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+static void dd_insert_request(struct request_queue *q, struct request *rq,
 			      blk_insert_t flags, struct list_head *free)
 {
-	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const enum dd_data_dir data_dir = rq_data_dir(rq);
 	u16 ioprio = req_get_ioprio(rq);
@@ -694,7 +693,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		dd_insert_request(hctx, rq, flags, &free);
+		dd_insert_request(q, rq, flags, &free);
 	}
 	spin_unlock(&dd->lock);
 
-- 
2.50.1 (Apple Git-155)

