Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE663C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiFWTBj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiFWTBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:13 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F191D10EF54
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:33 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso3386544pjg.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvjW7rY36ZMy0wNyWgmCOUx7rdaNJWo/Gm6UsZieMd0=;
        b=s+k1ZOgac64boll1RoOE0Xvb0gcf3NJ2WbuVMGPdlpIUU2MNDllaRx8d0dR7hijxSS
         JC3PwWadQZicSxdA/Q2nS1SrVbG8TQOfoZZZFVktqcuLcKmBThk9DJmfHx5SlhEN3lhq
         +e0MvR6LBWsi8Uv4FhBiOHVjLh0XR8srUJd9sx1JyEftfZPfp3aGA6diE925O4BNKgg8
         713AMTUklgpZoasZAcUrQhO6FM9DOAK++IunlMB/7xdgQPuH4LzNvzdBQ0oPgTw/qVyR
         keO/c2YCWAOzBdsta3sVcFzT6RYXQ8usQ3XKOg6OHDZoaSQXV01z5JgQSoxBO87CqjRv
         YBXQ==
X-Gm-Message-State: AJIora/mFyhXWD7+Rdz7KpX89xDcwl+6TVRvflV5ctV4Rob/qv5QNcIe
        sHbwI24xRk2F6mBmS8f/kGE=
X-Google-Smtp-Source: AGRyM1vbu9NW6J1bk5WNGNl3X/fLLGTmlzqVXr35Iy2pVCKodgANyTisggoBomfcNjgw19uv3hlcvg==
X-Received: by 2002:a17:902:8546:b0:16a:2460:3e5b with SMTP id d6-20020a170902854600b0016a24603e5bmr22239990plo.19.1656007593371;
        Thu, 23 Jun 2022 11:06:33 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 37/51] fs/direct-io: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:14 -0700
Message-Id: <20220623180528.3595304-38-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for block layer
request operations and the new blk_opf_t type for block layer request flags.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 840752006f60..9cfbb37ec62a 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -117,8 +117,8 @@ struct dio_submit {
 /* dio_state communicated between submission path and end_io */
 struct dio {
 	int flags;			/* doesn't change */
-	int op;
-	int op_flags;
+	enum req_op op;
+	blk_opf_t op_flags;
 	struct gendisk *bio_disk;
 	struct inode *inode;
 	loff_t i_size;			/* i_size when submitted */
