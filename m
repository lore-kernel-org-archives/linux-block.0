Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60EDA2D
	for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d7750e2265so841228b3a.3
        for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 13:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702934057; x=1703538857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAiSiu05NpJmzIVrTZabB/0AwAkLIp2fczQUUurdWuE=;
        b=q5I4hmpmNHWCTGhkrv5lMPYmyiA6va1l035Ts9/z2d5VTBYQdpYf9AQ/hBrp2iD/T+
         rEJ3da1YcNnlofjyOxWmU6FN0/+aV5i3KDZzSnWzdCRJ4p/J2a9/PvvDz42/RqACLp8T
         wNuv28jz5NTNYQ3u185IB3jwFKsHEoCceI9S/1RfNQsG5SGxV0YtqSK95briCWm8GYey
         TEyUALkbMOz0yiZrd07jcHOq5wzf5344Ut1hYODxreb6GTSCIAFj6FP1rTa01cJ3Qatt
         uFFSManK1uiGaPqGMsk6Eq+UGsd1cIYuKv1aMFW2v+WXOQRSGopjtsP41NQwykwCr4AV
         0XGg==
X-Gm-Message-State: AOJu0YxVFTIj4Rru1Qc8kxBzsJxyQJnllHeKLcScagT7NfCgqlE3Qjus
	eCjAOXVxV/VjuLsrGjWLnhk=
X-Google-Smtp-Source: AGHT+IHp79gIuF2cWlzENCYnCUG+u/H/06KhKIERsNXNHmasD6M6NrPnJIzA5iiTr1GuEyq9Sw8Tnw==
X-Received: by 2002:a05:6a00:8c4:b0:6ce:3bcd:61df with SMTP id s4-20020a056a0008c400b006ce3bcd61dfmr9947045pfu.31.1702934056874;
        Mon, 18 Dec 2023 13:14:16 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78811000000b006c320b9897fsm3371497pfo.126.2023.12.18.13.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:14:16 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 3/4] block/mq-deadline: Introduce deadline_first_rq_past_pos()
Date: Mon, 18 Dec 2023 13:13:41 -0800
Message-ID: <20231218211342.2179689-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218211342.2179689-1-bvanassche@acm.org>
References: <20231218211342.2179689-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for introducing a second caller.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index a5341a37c840..c0f92cc729ca 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -147,6 +147,28 @@ deadline_latter_request(struct request *rq)
 	return NULL;
 }
 
+/*
+ * Return the first request with the given priority, data direction and for
+ * which blk_rq_pos() >= @pos.
+ */
+static struct request *deadline_first_rq_past_pos(struct dd_per_prio *per_prio,
+					enum dd_data_dir data_dir, sector_t pos)
+{
+	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
+	struct request *rq, *res = NULL;
+
+	while (node) {
+		rq = rb_entry_rq(node);
+		if (blk_rq_pos(rq) >= pos) {
+			res = rq;
+			node = node->rb_left;
+		} else {
+			node = node->rb_right;
+		}
+	}
+	return res;
+}
+
 /*
  * Return the first request for which blk_rq_pos() >= @pos. For zoned devices,
  * return the first request after the start of the zone containing @pos.
@@ -155,7 +177,7 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 				enum dd_data_dir data_dir, sector_t pos)
 {
 	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
-	struct request *rq, *res = NULL;
+	struct request *rq;
 
 	if (!node)
 		return NULL;
@@ -169,16 +191,7 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 	if (blk_rq_is_seq_zoned_write(rq))
 		pos = round_down(pos, rq->q->limits.chunk_sectors);
 
-	while (node) {
-		rq = rb_entry_rq(node);
-		if (blk_rq_pos(rq) >= pos) {
-			res = rq;
-			node = node->rb_left;
-		} else {
-			node = node->rb_right;
-		}
-	}
-	return res;
+	return deadline_first_rq_past_pos(per_prio, data_dir, pos);
 }
 
 /*
