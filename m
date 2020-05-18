Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A332EC433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A93020758
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgERBsW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 21:48:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35672 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgERBsW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 21:48:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id n18so4233105pfa.2
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 18:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNgFI3Zzntrg8wH8qDcGqM2PA4lzawmbPyKh6A9kpT8=;
        b=DYw6pwUlXRqefBHTgSGpBLqk1pcDtTSjP7Ogp9xFZI5jq6cOtgCYZ9yVF3Ilxc1CqB
         mhZu+MUDY7iio9Of+Ok+AoOSNjDffCZuEc9xlglbq/mRCqVYCe3ENG92/RqZS2wOblel
         K0Eo8VtcjhYRbSilKJrq9i8jTAWEcC5gQxcm5Vwt4JSi0StRdHJ2wj/tQBzb9pSzybzo
         edxvqypHTdfOArJXWd57A/lgON5tbEUIsco83e1TxydQYCvIEWHL22CM6iGaRNmztkwX
         qm10G2yhhMP1/SQuV/9Dr9woUongtHVAx3DJ1Og4hkZw7QqB2++X45jwr4dZLtMqRTUD
         Miqw==
X-Gm-Message-State: AOAM5337MbhEMJ2vy2siQsy8hQC3ejofBf57Kcl6hZ7BQS6vtFlCP3Ve
        UcAnLjULsPW1xUStY/h+Hqs=
X-Google-Smtp-Source: ABdhPJwkOZuk5qFI1gt6z3cNHDgvY4fyId5IhZGbeH+6x7xxwELw3DoM6xBSQhZmw2hYh+9Vp84txw==
X-Received: by 2002:a63:de06:: with SMTP id f6mr13581605pgg.238.1589766500460;
        Sun, 17 May 2020 18:48:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:1c3f:56a2:fad2:fca1])
        by smtp.gmail.com with ESMTPSA id m2sm3778353pjl.45.2020.05.17.18.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 18:48:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 3/4] block: Document the bio_vec properties
Date:   Sun, 17 May 2020 18:48:06 -0700
Message-Id: <20200518014807.7749-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518014807.7749-1-bvanassche@acm.org>
References: <20200518014807.7749-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since it is nontrivial that nth_page() does not have to be used for a
bio_vec, document this.

CC: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/bvec.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index a81c13ac1972..ac0c7299d5b8 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -12,8 +12,17 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 
-/*
- * was unsigned short, but we might as well be ready for > 64kB I/O pages
+/**
+ * struct bio_vec - a contiguous range of physical memory addresses
+ * @bv_page:   First page associated with the address range.
+ * @bv_len:    Number of bytes in the address range.
+ * @bv_offset: Start of the address range relative to the start of @bv_page.
+ *
+ * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
+ *
+ *   nth_page(@bv_page, n) == @bv_page + n
+ *
+ * This holds because page_is_mergeable() checks the above property.
  */
 struct bio_vec {
 	struct page	*bv_page;
