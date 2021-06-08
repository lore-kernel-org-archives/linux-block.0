Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A889C4743F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219BE61278
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhFHXJZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:25 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:41576 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbhFHXJY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:24 -0400
Received: by mail-pg1-f181.google.com with SMTP id l184so2274444pgd.8
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9mlbGrne/i9hM5ojviqHTqgYxuBYYuowh8cFarteBM=;
        b=GAa0SsTRpUsO5ClecgGJwUjcwEvk323kNqjekRUB15Bd0lNcdr1bpamYmqL86aZloq
         773u8vI6CJztKeXx5KTOrAW6sM0purk8QWl5n4WoVYtDKnfGoG3Hm6LtSeyHrqVaUwVN
         lQcH4EGtspTGtIZO8yXPjhmbvv7yLF+MxpxTT059/tUvoPN2Npbtx9K0tO5/gjIj0ovj
         NdxHvtqnAT5SGy4CFQ1ODTOkPfGacGqaOk0zq/Ae3UFimQftVdmnrrzNea3pL56eZEmF
         vj2LLTDX/eMFTM8qglOXemOfS+y27FZBLtWomP/UY9FrFnPMH9MnEmQZ2VWhqLAyOe5U
         DCPg==
X-Gm-Message-State: AOAM532yu0haaXE0UdIRfiWa9TKDES5/C0V1zr76ckbTUgT46iKfB/sa
        4hQwvYziUAvoxgz3E2db16I=
X-Google-Smtp-Source: ABdhPJxP/M7v3Ck/aUbO/4UGNYO99vEw8JRe36cgyKEe17Kb9t1VlneEWEPABZUUThVVjo6mMsUZPw==
X-Received: by 2002:a63:e709:: with SMTP id b9mr614796pgi.153.1623193635335;
        Tue, 08 Jun 2021 16:07:15 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 03/14] block/blk-rq-qos: Move a function from a header file into a C file
Date:   Tue,  8 Jun 2021 16:06:52 -0700
Message-Id: <20210608230703.19510-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608230703.19510-1-bvanassche@acm.org>
References: <20210608230703.19510-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rq_qos_id_to_name() is not in the hot path so move it from a .h into a .c
file.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-rq-qos.c | 13 +++++++++++++
 block/blk-rq-qos.h | 13 +------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 656460636ad3..61dccf584c68 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -2,6 +2,19 @@
 
 #include "blk-rq-qos.h"
 
+const char *rq_qos_id_to_name(enum rq_qos_id id)
+{
+	switch (id) {
+	case RQ_QOS_WBT:
+		return "wbt";
+	case RQ_QOS_LATENCY:
+		return "latency";
+	case RQ_QOS_COST:
+		return "cost";
+	}
+	return "unknown";
+}
+
 /*
  * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
  * false if 'v' + 1 would be bigger than 'below'.
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 2bc43e94f4c4..6b5f9ae69883 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -78,18 +78,7 @@ static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
 	return rq_qos_id(q, RQ_QOS_LATENCY);
 }
 
-static inline const char *rq_qos_id_to_name(enum rq_qos_id id)
-{
-	switch (id) {
-	case RQ_QOS_WBT:
-		return "wbt";
-	case RQ_QOS_LATENCY:
-		return "latency";
-	case RQ_QOS_COST:
-		return "cost";
-	}
-	return "unknown";
-}
+const char *rq_qos_id_to_name(enum rq_qos_id id);
 
 static inline void rq_wait_init(struct rq_wait *rq_wait)
 {
