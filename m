Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FFEC7EE2A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjEQRpl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEQRpg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:36 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F97A275
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:06 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-64cb307d91aso1080267b3a.3
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345478; x=1686937478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1Mh8aRLXpq1JQWihv+khZjFLFcjuKpLPc/SIHkC/Ro=;
        b=Uc6QB004FLWsLM2ucoeJOmk6UKsLLjgUdP52Jrbe1OFhT9i6hvbnZCtdJZ6+CH1mYN
         SWyS+32qv49bpQhEhWcM4yWHctog9jmjwWS84TPxQw/WXw01ohefUyKUv1K9ECjFFWJp
         I0r+NTrSaRr+D2oTXCmToB2oO8tlQ1W2jNRJipC3HrVclyizogTgi+LZvnWLDR+Qy+u7
         bOpyHxSQVge3W6gjPnIxORQ7THdj0ktUVYW7feN4FnJobhfBEiiIDv14Qu4lZKjcYlf3
         RFnVIHNez9nqWEjQTNj5VKje2/NdjYDuHVI2mHfzQnDZ0MdrjfMR7JwcvbChyH6YhljI
         fIug==
X-Gm-Message-State: AC+VfDyoXAWl1DLLEA/TxEWfdiynTVmsd0fXmjESXeeyTbmIbxEx1MGd
        btbKvbCoJ9Sm4oj0D+nRAig=
X-Google-Smtp-Source: ACHHUZ5NBVUMEAdnIfUfe/U5K/xh+AOAl6pB0IE3/rqmMVUBanjOMA+dCLmRrJ7bqpuIlFCfoa28gA==
X-Received: by 2002:a05:6a00:138b:b0:64c:ecf7:f4a4 with SMTP id t11-20020a056a00138b00b0064cecf7f4a4mr617684pfg.24.1684345478060;
        Wed, 17 May 2023 10:44:38 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6 06/11] block: mq-deadline: Clean up deadline_check_fifo()
Date:   Wed, 17 May 2023 10:42:24 -0700
Message-ID: <20230517174230.897144-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the return type of deadline_check_fifo() from 'int' into 'bool'.
Use time_is_before_eq_jiffies() instead of time_after_eq(). No
functionality has been changed.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index cea1b084c69e..cea91ba4a6ea 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -272,21 +272,15 @@ static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
 }
 
 /*
- * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
- * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
+ * deadline_check_fifo returns true if and only if there are expired requests
+ * in the FIFO list. Requires !list_empty(&dd->fifo_list[data_dir]).
  */
-static inline int deadline_check_fifo(struct dd_per_prio *per_prio,
-				      enum dd_data_dir data_dir)
+static inline bool deadline_check_fifo(struct dd_per_prio *per_prio,
+				       enum dd_data_dir data_dir)
 {
 	struct request *rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
 
-	/*
-	 * rq is expired!
-	 */
-	if (time_after_eq(jiffies, (unsigned long)rq->fifo_time))
-		return 1;
-
-	return 0;
+	return time_is_before_eq_jiffies((unsigned long)rq->fifo_time);
 }
 
 /*
