Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DBC47082
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5FBD613C5
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhE0BDY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 21:03:24 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:44870 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhE0BDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 21:03:24 -0400
Received: by mail-pg1-f178.google.com with SMTP id 29so2403326pgu.11
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 18:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4edXMHzGiEojjOWUWm/R1SRrs1nterPwfP9eCCDFqEE=;
        b=joYYRpojv1xNoHiKDq3IzYkdrU2V68T71Ou9YUYp5c1qFDAVVekyxjQ0Mh1RJJWr1C
         oXy5B/wEsXa6C2M+ql4BSy7MNvjZtSfTl60wiZHiICBytEhcu9AuR1MCZILnDEPbrZFj
         7GRm3QNWbZDXzEbuWsmfYADiPJsXhPawt/oXhIoZfrIrtJfRkNFyaKEdgzuaBTBiS5xl
         hHQuL1QPtpJDJheUAG3aQ27GrB4PamBV6W+xgvbp7/Xgq9/iIc5tKgMdr2v9UEZrRj5h
         e9k/HP/7B64/UnI73tTQLT59+gn5JOGAkvzdfcvJeh3Sn9EHj7XWZbLH/e8O5T1Ayhdq
         sa9w==
X-Gm-Message-State: AOAM531727FP07Mh98o0u8Tjtpk5+y/NEBfIF4g9S2X6VHEM2aPiMrzj
        jKDTPsytuhpZv6gj7TUBI0g=
X-Google-Smtp-Source: ABdhPJzA/RN/PgULyICnmurS/sqpc5Au6b65XYMwOpUgI2H6BzePXQZfeg1v8mYAwLnkuM1tqV1iiA==
X-Received: by 2002:a63:1d09:: with SMTP id d9mr1243805pgd.302.1622077310905;
        Wed, 26 May 2021 18:01:50 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j22sm310707pfd.215.2021.05.26.18.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:01:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/9] block/mq-deadline: Remove two local variables
Date:   Wed, 26 May 2021 18:01:28 -0700
Message-Id: <20210527010134.32448-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527010134.32448-1-bvanassche@acm.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make __dd_dispatch_request() easier to read by removing two local
variables.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 4da0bd3b9827..cc9d0fc72db2 100644
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
 
