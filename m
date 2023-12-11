Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A3AC4
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 15:15:20 -0800 (PST)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so3507234b3a.0
        for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 15:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702336520; x=1702941320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9AGs1I8qvO501sa5Q2pSHj1LRZaw/B1/vYIB5CxHi8=;
        b=Vo/VuQXaUnftz36b9nbUOpxZL+JS1tgIi6d948wZ8sTtTdMmiHr77G+Bg6BhuBpQ/m
         DE3j2MQdpG6uo+Jb0VQNpGlfaQKWOQqlHF/Foe5OljOixBWDJYBbVp44YAknsfPFBsd4
         pJq8LENAjXXWl2O5SUOB3J7Q9DlNuBW0C7axZgt4ostP87eDtuHDp2V7AZb1r88SD9oh
         PjrhN6zERFnVNTC8Fa5ixS2lUf9fjCOlElLxWBg31AGu/aamcMSHXFS5+kYwJCE20LYB
         /WL/6sEyFBXa93Mi5JBl2FTjQH3y49SukTOVBD6b9/GHG1t7DxQyodzinNW9y86tiIA9
         7H/w==
X-Gm-Message-State: AOJu0YxLwS8bN0E5Jk4WuODoE+13VNnZDLyNbZ+EckT6SnEeYekgh3wE
	Fzn/6RI9KTYWMX08fC/XGP0=
X-Google-Smtp-Source: AGHT+IFqwqHEupM91Ek8lqS7xf4i1a75lKEtvT7IFKlOUOr5KWQznExAvDWNSJgtaeen94xF0Cnykw==
X-Received: by 2002:a05:6a00:852:b0:6ce:2757:7865 with SMTP id q18-20020a056a00085200b006ce27577865mr7699784pfk.32.1702336519833;
        Mon, 11 Dec 2023 15:15:19 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:3431:681a:6403:d100])
        by smtp.gmail.com with ESMTPSA id t2-20020a62d142000000b006ce69a70254sm7146714pfl.56.2023.12.11.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:15:19 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block/blk-ioprio: Skip zoned writes that are not append operations
Date: Mon, 11 Dec 2023 15:14:51 -0800
Message-ID: <20231211231451.1452979-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If REQ_OP_WRITE or REQ_OP_WRITE_ZEROES operations for the same zone
originate from different cgroups that could result in different
priorities being assigned to these operations. Do not modify the I/O
priority of these write operations to prevent that these would be
executed in the wrong order when using the mq-deadline I/O
scheduler.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-ioprio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 4051fada01f1..09ce083a0e3a 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -192,6 +192,17 @@ void blkcg_set_ioprio(struct bio *bio)
 	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
 		return;
 
+	/*
+	 * If REQ_OP_WRITE or REQ_OP_WRITE_ZEROES operations for the same zone
+	 * originate from different cgroups that could result in different
+	 * priorities being assigned to these operations. Do not modify the I/O
+	 * priority of these write operations to prevent that these would be
+	 * executed in the wrong order when using the mq-deadline I/O
+	 * scheduler.
+	 */
+	if (bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
+		return;
+
 	if (blkcg->prio_policy == POLICY_PROMOTE_TO_RT ||
 	    blkcg->prio_policy == POLICY_NONE_TO_RT) {
 		/*
