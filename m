Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9EDC2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969CC613BA
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhFRArZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:25 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:39760 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhFRArY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:24 -0400
Received: by mail-pg1-f177.google.com with SMTP id w31so6360651pga.6
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rkBqJ3UYA2WzpE+Shn97+2YWtxkFcR7b/FvEGWfprc=;
        b=pUwAKk1RwwFciW5jmyZuXQBVil7JRzWh3x7HqxlW1COD9/L2UMtVJ2ZQsgGQ5kWEDS
         RlLPzpTurbY5Ckmk3tT0aGccLR6BrIAeRyV8j2KDFnazQRu9FKlF8aO5K7p6pY+86ZDk
         L9S8+M3Ird2oVTnX87mg3dyhwkmngpphs4sURxb5qiwTCViNYrpUiRlAor+v3mP7Vfid
         hXiHefeID6ngCPkCBpErQSFoZEhQqD+9snKcHjcW01ThJBM9oyUae0SqH+CPDCKUvfxb
         yjN708FGut+TUp3wtk7DQ2jLaHKg2yvcQ/H8uLkFE6xOzWWbaRKYukIldopLEstBKRdX
         /aBw==
X-Gm-Message-State: AOAM532IDAZNu3nUlg4tE6w30GaiXUHBT/CVyWfhx98sP4Ue9o3MNsHi
        i3SND6v/eeweAXeO/POh8LA=
X-Google-Smtp-Source: ABdhPJzrF1plvbkaAAoCRq/B7RcJeUF/4HL0efXvOJZyGlKlrPcSkKKjkA/F9pcxg7Gxj+lHuPaYIQ==
X-Received: by 2002:a62:76ce:0:b029:2fe:f4fc:b2db with SMTP id r197-20020a6276ce0000b02902fef4fcb2dbmr2401992pfc.12.1623977115027;
        Thu, 17 Jun 2021 17:45:15 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 07/16] block/mq-deadline: Remove two local variables
Date:   Thu, 17 Jun 2021 17:44:47 -0700
Message-Id: <20210618004456.7280-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
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
 
