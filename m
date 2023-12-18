Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D073492
	for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58e256505f7so2523629eaf.3
        for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 13:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702934055; x=1703538855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBp0e9bv3GavBOwkFpku03+RC2SEUPQU/wnkINj2HC8=;
        b=sqZij17VFvfLz8RaA/gW5q4Dcj5jQ1emVGe90o4ceBdjLP7JCAwZbKrfevZ+MbwG+j
         qZ0ivDA0rT/TPD4AtXNvmuEP6CLlhibSNXUYx2B3lAP+6vIEsTvK7KaieFyPjziqZzeF
         a7v2lACV9deXT9gGiRcM3A1YiqdR1/bEGN2Tb1Q5Pmlv59bErj8tXa8ULvTvj9LSDg23
         lxxl6L1yXzTNV2+pgAsySr/vre9iRoCVfd6XBsOIgU0BsYfW1QVJ+iVvvpyujhWBqYFd
         rVH69eiIqCWdvxR3/SvFE3TrJVIKPku+0GBQCiOvKMpf6g8EDLdxs9Z/id8Zmq5zS86k
         MCOg==
X-Gm-Message-State: AOJu0YwV3J1yQyEBZ4qd5otguEGO1nwP7qZMV2ZSXWup3dboAHpl0Kha
	wHNsBJcQbsWxSl6ElfKred4ANGXm7Ac=
X-Google-Smtp-Source: AGHT+IGn56NCoHBR49wPFLdylUi9WnvFRbQqHvwVWty2plVgQd7ipWfVvwOHiT+NMkvqGnX5myE80g==
X-Received: by 2002:a05:6359:4114:b0:170:bfb9:fb41 with SMTP id kh20-20020a056359411400b00170bfb9fb41mr11746604rwc.28.1702934055514;
        Mon, 18 Dec 2023 13:14:15 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78811000000b006c320b9897fsm3371497pfo.126.2023.12.18.13.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:14:14 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 2/4] block/mq-deadline: Introduce dd_bio_ioclass()
Date: Mon, 18 Dec 2023 13:13:40 -0800
Message-ID: <20231218211342.2179689-3-bvanassche@acm.org>
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

Prepare for ignoring the I/O priority of certain requests.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 8e5f71775cf1..a5341a37c840 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -190,6 +190,11 @@ static enum dd_prio dd_rq_ioprio(struct request *rq)
 	return ioprio_class_to_prio[IOPRIO_PRIO_CLASS(req_get_ioprio(rq))];
 }
 
+static enum dd_prio dd_bio_ioprio(struct bio *bio)
+{
+	return ioprio_class_to_prio[IOPRIO_PRIO_CLASS(bio->bi_ioprio)];
+}
+
 static void
 deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
 {
@@ -740,8 +745,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 			    struct bio *bio)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	const enum dd_prio prio = dd_bio_ioprio(bio);
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 	sector_t sector = bio_end_sector(bio);
 	struct request *__rq;
