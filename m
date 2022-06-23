Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A955C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiFWTBj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiFWTBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:14 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A4910EF5A
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:35 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id l6so10659514plg.11
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3L+13jbsL2KytYOAIGe5reLvhMdInbYdB1ucfP6bHbc=;
        b=isJXMcWwn6OxymS7/yeu2A3lOKJTOtr0OP7jVxQhQ2TH4teFaoPM6MFQTI25A3XaNz
         3cf0BkVMmg+GOJfmrGq4HHdVBJU7lecar1IcjcoBIjlLtgWO+9BhhecPLceitvmEFi8+
         Sd2NXCvXMaZ2Jc9bCAC3eIgvL9cjrYEy0T0JgFyLR9CJQ5XJ9zdqD/wJbQE3IOIG07sV
         E9t8RtlKwrhDlR3mRxQAMhP668wvXKBIZBHP872bWyF+SYWYg/Q+6DThc9lKRYCeaRrj
         nbkhpVnHpgmKTWbdNtkIjcLZhb+vhGhaGa3k1VTWRHe/m/p1E0TYmIlU9MN0Ru8DbSs7
         uEwg==
X-Gm-Message-State: AJIora+0NYZrG9inc5kx44wFpJki/1XLjrXwJ//3Dq9tsiEoAPAqxT2o
        ANfMxqs4eq5gJEj9hHzcXaE=
X-Google-Smtp-Source: AGRyM1t+m8unQSgbAX2f3v5YB1NbrYPrKQ1SEc+UVIGs2gYtH9wnIBhnk99hPJcsoHPFis7g9RcNtA==
X-Received: by 2002:a17:902:7486:b0:16a:cfc:7f49 with SMTP id h6-20020a170902748600b0016a0cfc7f49mr30847575pll.135.1656007594754;
        Thu, 23 Jun 2022 11:06:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 38/51] fs/mpage: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:05:15 -0700
Message-Id: <20220623180528.3595304-39-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for the
combination of a block layer request with block layer request flags.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/mpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 0d25f44f5707..5830705672dd 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -145,7 +145,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	struct block_device *bdev = NULL;
 	int length;
 	int fully_mapped = 1;
-	int op = REQ_OP_READ;
+	blk_opf_t op = REQ_OP_READ;
 	unsigned nblocks;
 	unsigned relative_block;
 	gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
