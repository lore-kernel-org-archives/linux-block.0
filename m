Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44488C433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF272070A
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgESEHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 00:07:51 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54219 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgESEHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 00:07:51 -0400
Received: by mail-pj1-f65.google.com with SMTP id ci21so761715pjb.3
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 21:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNgFI3Zzntrg8wH8qDcGqM2PA4lzawmbPyKh6A9kpT8=;
        b=KQDsc014cfHPoCtFtXNqpGOcPyfjaSyBwn5TMQ21WKoyqCIHso8vh0IhG46+maN4YC
         8S9Xz3X49EMtxp9qyuJJhnNHutAl/Cj2S7N/LtgthZbt7/MwslRTZmk6Y3eNlEso2A3k
         3jaj9UTwU30qwCjtM4hE0FFvrQKRC0L0gmFkQjftFp8yb0rdIUywgR5y68QD6thcTYQq
         mNflJV91lXuBxRHoyXQQizu2J8uti3/ci6z7clVV11zl+V5cjHbmoPits7iqt2IS9WLq
         0X0lxgI8byunZx1ZeKsRCHIjjAabF6HWu76V4AiUVzFxCa+it5fTYH6hHdNMrLDt2z0j
         CSNA==
X-Gm-Message-State: AOAM53329G8qHm0is/Yqw3tYNokbipKY3ZSjIWfmOYGkpFiuws1STKsd
        Ykwtt+uj6TVzpXyrJZ2aBG4=
X-Google-Smtp-Source: ABdhPJxZPlEnbgvKmmUU71ZQ3s8Bb/Xrboe4AY+dLY0D9A8Cv7dvogNBDkq8r1v3qaRgd5S6cSphXQ==
X-Received: by 2002:a17:90a:aa84:: with SMTP id l4mr2959519pjq.100.1589861270467;
        Mon, 18 May 2020 21:07:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:dc5d:b628:d57b:164])
        by smtp.gmail.com with ESMTPSA id l3sm823479pju.38.2020.05.18.21.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 21:07:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 3/4] block: Document the bio_vec properties
Date:   Mon, 18 May 2020 21:07:36 -0700
Message-Id: <20200519040737.4531-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519040737.4531-1-bvanassche@acm.org>
References: <20200519040737.4531-1-bvanassche@acm.org>
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
