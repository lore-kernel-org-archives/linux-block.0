Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FAFC47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6379B613C5
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhE0BDa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 21:03:30 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:35789 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhE0BD3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 21:03:29 -0400
Received: by mail-pl1-f170.google.com with SMTP id t21so1503497plo.2
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 18:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPnT1JBCPsUBvPWopNHHnlw5sGKoI9+ydtrjdwNEk/U=;
        b=setXY8E1uVAtF/sLjiTvgkEpAxxnUb7Y2ibiUnnzGq+EITnow0waLVkfN83rP2MHJ8
         m3I5o+K4Jvecj8yRBwHxaSVae7PP2qKu/AI9h7qZvXo1lTWCWJPlITW7EXVXmbBHPBRF
         y5Q6i6f/7b4Lt7ZDPIykyWdeMSXUY/HSl7/Y9Vp3qEey+YW18PuYF07Dik7BQFwH3uGb
         E0hs8ScKuCY+f6Xn4/ZMbYkThj8V8VziJrkwl0wJRtA541Uwie6xVdUPrD5cqdBwtAxE
         v/gxyVwOiPH3KVzpdwwBHWHz5l3RokSOMIUibYz4LUwOcXlyQiPFHyuZqDrt9mJZqtyn
         05FQ==
X-Gm-Message-State: AOAM530Pz069wixk6zS1C1GbFUDHRsSDn0UX3WIyT8ShFXQvPufrz8Fc
        GoXEGQAug4lvedjlKh2l0xY=
X-Google-Smtp-Source: ABdhPJwCFSxLBLkZNgPOqiBb7AfRp2zslkhXyIJOEltSaUS5RePAIRb3EBBY4cjipb49t44ZH4yfSg==
X-Received: by 2002:a17:90a:bf91:: with SMTP id d17mr5897599pjs.17.1622077315356;
        Wed, 26 May 2021 18:01:55 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j22sm310707pfd.215.2021.05.26.18.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:01:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/9] block/mq-deadline: Reduce the read expiry time for non-rotational media
Date:   Wed, 26 May 2021 18:01:31 -0700
Message-Id: <20210527010134.32448-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527010134.32448-1-bvanassche@acm.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rotational media (hard disks) benefit more from merging requests than
non-rotational media. Reduce the read expire time for non-rotational media
to reduce read latency.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index dfbc6b77fa71..2ab844a4b6b5 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -29,7 +29,9 @@
 /*
  * See Documentation/block/deadline-iosched.rst
  */
-static const int read_expire = HZ / 2;  /* max time before a read is submitted. */
+/* max time before a read is submitted. */
+static const int read_expire_rot = HZ / 2;
+static const int read_expire_nonrot = 1;
 static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */
 static const int writes_starved = 2;    /* max times reads can starve a write */
 static const int fifo_batch = 16;       /* # of sequential requests treated as one
@@ -430,7 +432,8 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);
 	dd->sort_list[DD_READ] = RB_ROOT;
 	dd->sort_list[DD_WRITE] = RB_ROOT;
-	dd->fifo_expire[DD_READ] = read_expire;
+	dd->fifo_expire[DD_READ] = blk_queue_nonrot(q) ? read_expire_nonrot :
+		read_expire_rot;
 	dd->fifo_expire[DD_WRITE] = write_expire;
 	dd->writes_starved = writes_starved;
 	dd->front_merges = 1;
