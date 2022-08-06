Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A17C25B0C
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 15:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiHFPUK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 11:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiHFPUK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 11:20:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9A511A12
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 08:20:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso10777369pjr.2
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KQkxJ7Xt9ACG3CLAZzFZxHFZSW93HMroBHCMM5ScDhY=;
        b=PpOGzcizOZkg0RFbAfq/VBwaHTwNveQxnWvIJZX5jiO4YFP8V7TcnI3N+Z2MEq6isr
         ElX9mDWtl5+mDewuU3MpARtITiJNl1UvYZpgihG2/g+A/0bfIwldZaXAnJDU6MhO9xq1
         O28LnFdujA+s7nVTaW4GgCtnS3/TM3f8DZREJeegD+yXeyGpdAcaz0Tbu0Q8Rrr2P8R9
         0yvzJtGgVRMUiLwLqMw4hQofm+eh6n94b/VvBO/QSQdNa1g/MuADCST9LbRtU9panUDW
         BksTxRIIi50RRGPIkO0HbBIHcRs4gIS165Kr6V6P6tvljM+9zM9YxCGmn4SSpeEAp/0s
         Bgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KQkxJ7Xt9ACG3CLAZzFZxHFZSW93HMroBHCMM5ScDhY=;
        b=63krSit32QCgcVPOKkqqjU34d9d19XYBASbWjt/2u14JFdTLJGyuMJhUrKs7EmdpnI
         UMhB9ed+j3mNIv3UUFeLaXuK5XVQvfd/I/tsJdXWJ4STW37/w+NjGKRml6MM/uwPGwNP
         TV2QcdU3yuoSHkSU3mlXZgj40D1vUtXLGct2Pl+PO7fshK1fqs5GvGBPk4AdzuyEBkh1
         ETPKlq8ehrMwuE/5C7wJLT6dmNEYrKkYPDfqu+J9/U86UiYrplGlg5ik+LnIUaWnnlb6
         T6mh1rbvCTbhcpuv6GNcVdN7DOUq/m/IeYdX2AK4A8NgzqeBLNNx3qPg6WwMd4EcxUfj
         Yxlg==
X-Gm-Message-State: ACgBeo0ZzJUlRNHobAPFzYJrUuLzrb4luFCTbLVpWWGk9+hmx3FmCh6l
        ocGIRq6ITgmFChs0uIOhFtu2zkj4zJYJAg==
X-Google-Smtp-Source: AA6agR4Zyu06NMsedS3qStSFFnwVOul4lTIFw2LFfPB2a43FI8JEvX61ZP2eJ2NZnK0CMl4daxdZgw==
X-Received: by 2002:a17:90b:4a4e:b0:1f5:431c:54f8 with SMTP id lb14-20020a17090b4a4e00b001f5431c54f8mr20943801pjb.161.1659799208925;
        Sat, 06 Aug 2022 08:20:08 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b0016d1f6d1b99sm5158661plw.49.2022.08.06.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 08:20:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     joshi.k@samsung.com, kbusch@kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] block: shrink rq_map_data a bit
Date:   Sat,  6 Aug 2022 09:20:02 -0600
Message-Id: <20220806152004.382170-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220806152004.382170-1-axboe@kernel.dk>
References: <20220806152004.382170-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't need full ints for several of these members. Change the
page_order and nr_entries to unsigned shorts, and the true/false from_user
and null_mapped to booleans.

This shrinks the struct from 32 to 24 bytes on 64-bit archs.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-map.c        | 2 +-
 include/linux/blk-mq.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index df8b066cd548..4043c5809cd4 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -158,7 +158,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, req_op(rq));
 
 	if (map_data) {
-		nr_pages = 1 << map_data->page_order;
+		nr_pages = 1U << map_data->page_order;
 		i = map_data->offset / PAGE_SIZE;
 	}
 	while (len) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index effee1dc715a..1f21590439d4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -964,11 +964,11 @@ blk_status_t blk_insert_cloned_request(struct request *rq);
 
 struct rq_map_data {
 	struct page **pages;
-	int page_order;
-	int nr_entries;
 	unsigned long offset;
-	int null_mapped;
-	int from_user;
+	unsigned short page_order;
+	unsigned short nr_entries;
+	bool null_mapped;
+	bool from_user;
 };
 
 int blk_rq_map_user(struct request_queue *, struct request *,
-- 
2.35.1

