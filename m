Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0191AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAA8610A4
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241844AbhJ0MYD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241846AbhJ0MYC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 08:24:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E99C061745
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:21:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b194-20020a1c1bcb000000b0032cd7b47853so1048086wmb.5
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=baeDNJqUEMF5KJZcKkua2oxmhlA7b2HKEDmgofMMaIM=;
        b=bth39+snAD/GmR9yoPqP4F3fXDWBqoKWAlSRbtcNsfQypa84DkK9KyQlzw1OUFGe+k
         m5K4wuW/X69N7k8xpgMs1tkisssvVHBM0oFDfbTyaFvzor+c3lYhk8+olJlPNjEAYPAf
         sR4id8Eq47g6UN+jCf7lO3EsmwktodNdqO9IqyRcg57b3XjYqOb1XA6SmRn/lVhUzrmI
         U0LAc95nxHrMBEHyRWr2PoHEh5qyHjJxL2gJS5v5SZvHLvMsQFJm15RIN9/Ziu3q9or1
         ZNQibjsW/Weoau+myXj0hQLjFzX1JtzYbcFhtONVM7JeoPAjD55EGRRPYwPE0bGKc9Rn
         O7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=baeDNJqUEMF5KJZcKkua2oxmhlA7b2HKEDmgofMMaIM=;
        b=r3A5UR3O1ncSQSOGz/HKpmL3XK9UtKxHFk5L3Wv2bJU646I6tkLc9KI/1AF1bWDOPP
         fbLfH7HSrUkr6lwSW0Gs24pXlsSBlWU8jMExgBoiz0JHd7xO6trZ9GGQVxSRiYK6NO3Y
         gF28YEj0t9TKa3hCZr/Ojqj3lU/CUgFGG5pPGPso4sh+Sc1w0zSXDfCikFTLbAABckLg
         OLMmz2dBo5doDYARhpcUavMp3YwFDv/b+ECEMd272iOmWlulbsBMK29fxWcEFomP/sim
         2QLXN72ZkgKAVYkAirf4StulkgdSG4S7gFw4ds5qMsqzLGL1vwVIQxPI+Wf7an/V8YqW
         qIZA==
X-Gm-Message-State: AOAM5313uEDiqaV8uuHqamd041DKQU9Q8a9oxVR2G923H4q+VLfUaLZA
        BwnKbIsLpv6pe+YdGWUjJS3nJl3IdRY=
X-Google-Smtp-Source: ABdhPJz/gm7PC31LP3/ZNiPmmpHp4pDEAGKld6urmybxe6d2o1D3t2wAn4d9/Bu7ygTAI/ODM48Xwg==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr5491753wmc.108.1635337295740;
        Wed, 27 Oct 2021 05:21:35 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.132.100])
        by smtp.gmail.com with ESMTPSA id d8sm22738807wrv.80.2021.10.27.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:21:35 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 4/4] block: add async version of bio_set_polled
Date:   Wed, 27 Oct 2021 13:21:10 +0100
Message-Id: <8fa137885164a5d05fadcff4c3521da8d5a83d00.1635337135.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635337135.git.asml.silence@gmail.com>
References: <cover.1635337135.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we know that a iocb is async we can optimise bio_set_polled() a bit,
add a new helper bio_set_polled_async().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 8594852bd344..a2f492e50782 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -358,14 +358,13 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		bio->bi_opf |= REQ_NOWAIT;
-
 	if (iocb->ki_flags & IOCB_HIPRI) {
-		bio_set_polled(bio, iocb);
+		bio->bi_opf |= REQ_POLLED | REQ_NOWAIT;
 		submit_bio(bio);
 		WRITE_ONCE(iocb->private, bio);
 	} else {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			bio->bi_opf |= REQ_NOWAIT;
 		submit_bio(bio);
 	}
 	return -EIOCBQUEUED;
-- 
2.33.1

