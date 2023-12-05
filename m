Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38BB10F
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 21:32:32 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-286e57fde73so48687a91.1
        for <linux-block@vger.kernel.org>; Mon, 04 Dec 2023 21:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701754352; x=1702359152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMMQm/8P5vDhCfMmFJjm2M83Sx0o997ekT2Y80iR8f8=;
        b=ExJcudSis6llxTY2TogWHGFae748F8t89hsCbTqNumaEGuaJmtrnCUxZKGiYgl4eFu
         ypQaSbu//rnNAUDbfxRtgrkXEHFxmWoIvxUn7kriX/Kqsb2c6DMGAFkbKgEBXRf128th
         oTzB6aDOjws6imqAfKl3Dq4i7elE8g4OTfsRsg7sfXNWx8QyJaRQ6FVPsSLBU4IoD4Q2
         JIc6NHT6YotzcXxEmXYpIPEAmy/EVO+ZickQviVrgiQHSR9NfK7NvCDrsDt6U58D7EjJ
         1T0jBbYe3mY4MT8niSkViSxqxYld2Z5wdSHkdrE7H5iU++IIv8SkEFQ6rHb93K7A5y4J
         k2FA==
X-Gm-Message-State: AOJu0YxBlyiDqRaesQPMTZC6/+NbiAKdHXhcK29dTDWdvi2DIPKmpHPe
	iTW5qjD14lmow4Dq3H0UTiY=
X-Google-Smtp-Source: AGHT+IGgws/bmi2E3douBuTpj4XcQe6ylLbfH46MSfmxeHEJ5C3RKS2PJHd7xnkcx4c1AatjuGrDgA==
X-Received: by 2002:a17:90b:4a06:b0:286:6cc0:b909 with SMTP id kk6-20020a17090b4a0600b002866cc0b909mr418195pjb.64.1701754352199;
        Mon, 04 Dec 2023 21:32:32 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (rrcs-173-197-90-226.west.biz.rr.com. [173.197.90.226])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d30d00b001cfcc10491fsm1145375plc.161.2023.12.04.21.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 21:32:31 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 1/3] block/mq-deadline: Use dd_rq_ioclass() instead of open-coding it
Date: Mon,  4 Dec 2023 21:32:11 -0800
Message-ID: <20231205053213.522772-2-bvanassche@acm.org>
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

Use an existing helper function instead of open-coding it. No
functionality is changed by this patch.

Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..e558f3660357 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -798,8 +798,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const enum dd_data_dir data_dir = rq_data_dir(rq);
-	u16 ioprio = req_get_ioprio(rq);
-	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
 
@@ -811,7 +809,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 */
 	blk_req_zone_write_unlock(rq);
 
-	prio = ioprio_class_to_prio[ioprio_class];
+	prio = ioprio_class_to_prio[dd_rq_ioclass(rq)];
 	per_prio = &dd->per_prio[prio];
 	if (!rq->elv.priv[0]) {
 		per_prio->stats.inserted++;
