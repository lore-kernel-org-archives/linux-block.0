Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FADC4743D
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4926135D
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhFHXJ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:26 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:38658 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhFHXJ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:26 -0400
Received: by mail-pf1-f182.google.com with SMTP id z26so16893755pfj.5
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rkBqJ3UYA2WzpE+Shn97+2YWtxkFcR7b/FvEGWfprc=;
        b=bYPpzuyvALCXIN6XUvCs36Rr1oVZESlwyEBVk308JHIARsgATD05yLO6RGhz6P6iIs
         +nMwQt3oLO4hfQ/PKxL0qEOXmWy6f3WiwiJxihWhF53lsLKeQXpvZDCi7DGM0YSUL8q5
         3ksFpuIQ0lZOFWjWnX9cLFa94l8K2cqXpy7EbJjR8gns3/RVE0/gtk4s2AtYa7nha7NN
         NmGpSUpipngSmJa6UU2jKaKtO6kLGxMsX5nyspgd4WLgQKyf9kAxIpVtnwmcefcl/bA5
         Ax+3+2xiWzj7jCf2cDSu6aJ9G+nEGNak5RzsGS4UynGJSpvVGQxG8le4asYQPL7VYFgg
         ATOQ==
X-Gm-Message-State: AOAM531BigXFQIzmoJjcwwG0InmGBeKU9wswAIYNPGjtisLzt6yAPhgW
        boS30GU+s4gG2/jzH7FQprM=
X-Google-Smtp-Source: ABdhPJwVoFogZdrxecKZalsNHDC45x0mGOYuZwEGjyZLuFqj16SzqpSiqsKzfW3JeLTLX6mWaYob2g==
X-Received: by 2002:a62:760a:0:b029:2e9:e039:20bc with SMTP id r10-20020a62760a0000b02902e9e03920bcmr2322869pfc.7.1623193641224;
        Tue, 08 Jun 2021 16:07:21 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 07/14] block/mq-deadline: Remove two local variables
Date:   Tue,  8 Jun 2021 16:06:56 -0700
Message-Id: <20210608230703.19510-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608230703.19510-1-bvanassche@acm.org>
References: <20210608230703.19510-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make __dd_dispatch_request() easier to read by removing two local
variables.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 191ff5ce629c..caa438f62a4d 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -276,7 +276,6 @@ deadline_next_request(struct deadline_data *dd, int data_dir)
 static struct request *__dd_dispatch_request(struct deadline_data *dd)
 {
 	struct request *rq, *next_rq;
-	bool reads, writes;
 	int data_dir;
 
 	lockdep_assert_held(&dd->lock);
@@ -287,9 +286,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 		goto done;
 	}
 
-	reads = !list_empty(&dd->fifo_list[READ]);
-	writes = !list_empty(&dd->fifo_list[WRITE]);
-
 	/*
 	 * batches are currently reads XOR writes
 	 */
@@ -306,7 +302,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	 * data direction (read / write)
 	 */
 
-	if (reads) {
+	if (!list_empty(&dd->fifo_list[READ])) {
 		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[READ]));
 
 		if (deadline_fifo_request(dd, WRITE) &&
@@ -322,7 +318,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	 * there are either no reads or writes have been starved
 	 */
 
-	if (writes) {
+	if (!list_empty(&dd->fifo_list[WRITE])) {
 dispatch_writes:
 		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[WRITE]));
 
