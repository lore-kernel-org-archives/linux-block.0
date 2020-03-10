Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651F5C18E5A
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 04:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4256B24655
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 04:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgCJE0e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 00:26:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42688 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCJE0e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 00:26:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id f5so5869201pfk.9
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 21:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9PgxsHb2RD/hkhXGR5lZxxO6K6f6TPbQLCzmEfn064=;
        b=k1SG3c8WuSKQi5Tvp1H0+MP6BYpI5HwGuedPeeobZv9M2ox6kGRGwvQnBl1PC/jWIJ
         jQnozVTAHhbLz3Rq9gdutVmFIoaMJZ8Tk+g6Tn1LNRhx7kAvICa6HuwDZnFT9/RJDajQ
         GOB/HGHNhL2nVXpZfgwhL0Nbz3zSGSgP8k52LZgHzvlwCK1FgfCX4vBXY6ghRBPhept+
         mY0f3Fzq/MhXK67tkdMKwOd+jcrq4P/cLkN1W2B93ObseXzfW6cs/+sYW3Kh+KHz4caL
         NaruvwbxYc/n+Pih99DvN3z5EIkJa06PNfsA7ZhLgnA431C6MTX/dVWElD1I+lkNTYq9
         H7zg==
X-Gm-Message-State: ANhLgQ2c3BJF1GOkY9rD7FMAWR5PtQeLZyBTqIo6Z1uhPtgTbX9/FdSJ
        D1ybXM1y3vKfz0zFqaY7oujcykCd
X-Google-Smtp-Source: ADFU+vsrFfecXsKZOB78ULSVVDGxyWef13VsrjO+7TsJTw/NlO3TbettC1PSoC6dth69WN9dd9jsJw==
X-Received: by 2002:a62:ab19:: with SMTP id p25mr19956879pff.137.1583814391904;
        Mon, 09 Mar 2020 21:26:31 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c0e4:71da:7a83:2357])
        by smtp.gmail.com with ESMTPSA id l189sm5963240pga.64.2020.03.09.21.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 21:26:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v4 1/8] blk-mq: Fix a comment in include/linux/blk-mq.h
Date:   Mon,  9 Mar 2020 21:26:16 -0700
Message-Id: <20200310042623.20779-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310042623.20779-1-bvanassche@acm.org>
References: <20200310042623.20779-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'hctx_list' member of struct blk_mq_hw_ctx is not a list head but
instead an entry in q->unused_hctx_list. Fix the comment above this
struct member.

Cc: André Almeida <andrealmeid@collabora.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Fixes: d386732bc142 ("blk-mq: fill header with kernel-doc")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-mq.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 11cfd6470b1a..31344d5f83e2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -162,7 +162,10 @@ struct blk_mq_hw_ctx {
 	struct dentry		*sched_debugfs_dir;
 #endif
 
-	/** @hctx_list:	List of all hardware queues. */
+	/**
+	 * @hctx_list: if this hctx is not in use, this is an entry in
+	 * q->unused_hctx_list.
+	 */
 	struct list_head	hctx_list;
 
 	/**
