Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E60BC2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EE3613BD
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhFRArS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:18 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:39858 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhFRArS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:18 -0400
Received: by mail-pf1-f170.google.com with SMTP id k15so1181799pfp.6
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i5gCkuNHlEGJ1Akpn54s38GgYE/lyh/TpcqKbSnWT/A=;
        b=uFqQe8+JGnMV43W727jCJRf1eDVcmIp1y4EYz0C5xWU9us2m/j/BBxx/bblvXfkBB+
         fNXWcBJFZbj/AV8xCHrrVlNOkxm0WWgCLoyMNhtqEUaNWyFzEWSdRAT457r7abk5dv5r
         spTLOmvjmd6r1/njxGm5cJ2OFXXLNhmemDNijTg+rco5LQcoMhQ4He41WW5LHJqsAwad
         ykky4NCPOO3J8VspOeKOtlxrqfHyKVfOm48G/EX9PxV0f9gyUQXQKYXqSS0IuI13+MjW
         aXiQCreULkOZjF1pzj4B/joNk/+vNOOiOPDwWUoea7kPNh0jNWdlw30jLJLpd54nwx0H
         MBzw==
X-Gm-Message-State: AOAM533NYO3FCoyXyrwfJQ4yp6eLs0FipGem5HTCM/VY3vlS87DkO6sN
        C4ZXw13dWp8FtqXvlriCdjNviG+6h6o=
X-Google-Smtp-Source: ABdhPJxHwe+kVKaORyv0+8QDf51rxMjS9cg4eXOWOnBMWCSvAWdpYqWHrC/acEcyQk0HkZZiu8KMSg==
X-Received: by 2002:a62:be18:0:b029:2aa:db3a:4c1d with SMTP id l24-20020a62be180000b02902aadb3a4c1dmr2362445pff.58.1623977108411;
        Thu, 17 Jun 2021 17:45:08 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v3 03/16] block/blk-rq-qos: Move a function from a header file into a C file
Date:   Thu, 17 Jun 2021 17:44:43 -0700
Message-Id: <20210618004456.7280-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rq_qos_id_to_name() is only used in blk-mq-debugfs.c so move that function
into in blk-mq-debugfs.c.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-debugfs.c | 13 +++++++++++++
 block/blk-rq-qos.h     | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2a75bc7401df..6ac1c86f62ef 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -937,6 +937,19 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 	q->sched_debugfs_dir = NULL;
 }
 
+static const char *rq_qos_id_to_name(enum rq_qos_id id)
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
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
 	debugfs_remove_recursive(rqos->debugfs_dir);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 2bcb3495e376..a77afbdd472c 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -79,19 +79,6 @@ static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
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
-
 static inline void rq_wait_init(struct rq_wait *rq_wait)
 {
 	atomic_set(&rq_wait->inflight, 0);
