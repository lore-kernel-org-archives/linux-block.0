Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C63AC7EE22
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 22:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjECWwY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 18:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjECWwX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:23 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A7746A4
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:22 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ab0c697c84so21593655ad.3
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154342; x=1685746342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwyPTOfw7CLhqYC/Hv0uFzhwBy5QE+LBN1Uiqc5OArM=;
        b=F+VWMph2Bn7iA6nai2bWKLhVbHAP/A5Smicl+gL4gfaJAaub6RYe2qg2HguC1kTfh2
         +Rpxb06qsg9Xd7ilz/1d2FtFK9P7K1wLmqlsk0yYz4g0wv8oRDz6kxMnHdVOiMMJUwSX
         DPBvxzU9BmkAiynkSirw+FGGdl9LY+lxXfuuciCOQAv1iP1qfWhBELAzqMw59SOv68wD
         ubxcB/5QkH2cfOli8F80cO3gGwuikDWWne9/tM5901ZO6CetfXI0eCuAQUzW4vsMLlJh
         +6umyspo5NZ/oguvTSsTm4b3OCI9K+juipN+/bGXBTiOk96arMTP9ZdBbGJ5cmTMlThP
         k2bg==
X-Gm-Message-State: AC+VfDzgMnpF1z4KlTi6NlglBrVmnENuIZLoy5Tktu/F01wEpvlulWAK
        flybvCgM+s5XNcKUwj4RBG4=
X-Google-Smtp-Source: ACHHUZ4/QlVFvqbiHuwHslV38Ay+1+JNqePVVHbtfwzk9hRjJ/khggFlnLSwWgZCMDwNbcGZR9GqCw==
X-Received: by 2002:a17:903:2289:b0:1a6:6d9f:2fc9 with SMTP id b9-20020a170903228900b001a66d9f2fc9mr2225757plh.30.1683154342072;
        Wed, 03 May 2023 15:52:22 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 07/11] block: mq-deadline: Improve deadline_skip_seq_writes()
Date:   Wed,  3 May 2023 15:52:04 -0700
Message-ID: <20230503225208.2439206-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make deadline_skip_seq_writes() do what its name suggests, namely to
skip sequential writes.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6276afede9cd..dbc0feca963e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -308,7 +308,7 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 	do {
 		pos += blk_rq_sectors(rq);
 		rq = deadline_latter_request(rq);
-	} while (rq && blk_rq_pos(rq) == pos);
+	} while (rq && blk_rq_pos(rq) == pos && blk_rq_is_seq_zoned_write(rq));
 
 	return rq;
 }
