Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41632109
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 21:32:34 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-286ccf660fbso884065a91.0
        for <linux-block@vger.kernel.org>; Mon, 04 Dec 2023 21:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701754353; x=1702359153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL5unJHU5DJvy6MvHB/R0QfG33NtZCRnYDTLK5Cmqkg=;
        b=ohrgOYI05hrOJmuUgGHg/rIaXnDSrbUysFVbMhkF9ld7bYYIP+BV4F0PxY1e+jreKv
         ShvDmJ1fGdOXRZPAH8uYHK0uE5OKRSo2ax89EzAONqABnlfOJHFGNhelmgZIWro/kM7U
         MnQTwG7GZdqbbf8bBBrEw6nox0BqYpwSMbDJb5Yb4GJ900XBJJWVVwQnt4flS63VwmeJ
         TJwWRYxWN87RoDlROBXFNzVrS1/E9rcD60nUMXWwClC/sKhP+l/xaAOgeLji46wFlwH7
         r5eldMsZVPDHAGtTSLFZVSeWoEE+lQ19hAgG7da68IxW4P9Z9k3Y5g72+a1JrdHYrBwI
         9/eA==
X-Gm-Message-State: AOJu0YxUiVB1qyN5vmuwv/cMkgu8nlVCemvWUR8X7p1HlFyk1TlUgclw
	3LWH+a/RFrka5TDUSshvoqWeOF+lKFM=
X-Google-Smtp-Source: AGHT+IE/v3DSsvp7whs4/DSEJhwtSkYdwZav5myfQ/UmjITOGfjgrloeAd2ixKzYrK3bDQCT3kEnMA==
X-Received: by 2002:a17:90b:84:b0:286:815b:8c75 with SMTP id bb4-20020a17090b008400b00286815b8c75mr524274pjb.16.1701754353621;
        Mon, 04 Dec 2023 21:32:33 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (rrcs-173-197-90-226.west.biz.rr.com. [173.197.90.226])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d30d00b001cfcc10491fsm1145375plc.161.2023.12.04.21.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 21:32:33 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 2/3] block/mq-deadline: Introduce dd_bio_ioclass()
Date: Mon,  4 Dec 2023 21:32:12 -0800
Message-ID: <20231205053213.522772-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231205053213.522772-1-bvanassche@acm.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for disabling I/O prioritization in certain cases.

Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index e558f3660357..fe5da2ade953 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -128,6 +128,11 @@ static u8 dd_rq_ioclass(struct request *rq)
 	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
 }
 
+static u8 dd_bio_ioclass(struct bio *bio)
+{
+	return IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+}
+
 /*
  * get the request before `rq' in sector-sorted order
  */
@@ -744,7 +749,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 			    struct bio *bio)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	const u8 ioprio_class = dd_bio_ioclass(bio);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 	sector_t sector = bio_end_sector(bio);
