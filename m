Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEACC636C9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088056120A
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhGOVDA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:03:00 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:36402 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhGOVCs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:48 -0400
Received: by mail-pf1-f180.google.com with SMTP id 21so6706643pfp.3;
        Thu, 15 Jul 2021 13:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSVfGQ1R8Z/Rw4wG+xwCYEvkoa1oHaXmWTWRMMqFlL0=;
        b=oV5flFS4BPd8Ly6UEDnuMZhVVWQvkolipKDRXgItjlQ9sshIP3YIqxi5l9+a4Y6iL+
         lUwvqvIt+PF3kMQuya3a/UTs4R4Liu1MprFXVT8ShZS7QSmNBuf4LlK3LkXmCacTyAlV
         gObrKrEGk46R1i2wUHoshvnWjWX7kuGFrar3O+uLb2hVM7eqoQe1BLOIDFBCoEk7j0vN
         ny5hgT7VA1QGC0gvVxolCltSqN9OsTysp6Mnw/JGgD8uMJPG2/yTdF4hgsPp7AbypXri
         LXeEtiCQwOuiuL+zKEJAXMUmgPkIN4hEV77osI+sB/WwXObtBNoxRgyn9VIRlI5ajQiO
         Y+IQ==
X-Gm-Message-State: AOAM5337rHBJwMXufTPQqYBi5aBVWJvSqfFFe8QrHuNehmtLmtXYPTxK
        +YCeeX7dVTsPFXIvxqt7rxg=
X-Google-Smtp-Source: ABdhPJy0O+QorLEM+UZWloHx4fFjEw0Nae2ObjbDOmkUqoz32hSvSdExlbNKj0x1NZ9uydMh08OHtA==
X-Received: by 2002:a63:4302:: with SMTP id q2mr6350916pga.428.1626382793933;
        Thu, 15 Jul 2021 13:59:53 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id l8sm6107970pjc.17.2021.07.15.13.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:53 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 11/12] block/brd: add error handling support for add_disk()
Date:   Thu, 15 Jul 2021 13:59:19 -0700
Message-Id: <20210715205920.2023980-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/brd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 95694113e38e..ca017ca315c5 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -375,6 +375,7 @@ static int brd_alloc(int i)
 	struct brd_device *brd;
 	struct gendisk *disk;
 	char buf[DISK_NAME_LEN];
+	int err = -ENOMEM;
 
 	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
 	if (!brd)
@@ -413,14 +414,19 @@ static int brd_alloc(int i)
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
-	add_disk(disk);
+	err = add_disk(disk);
+	if (err)
+		goto out_cleanup_disk;
+
 	list_add_tail(&brd->brd_list, &brd_devices);
 
 	return 0;
 
+out_cleanup_disk:
+	blk_cleanup_disk(disk);
 out_free_dev:
 	kfree(brd);
-	return -ENOMEM;
+	return err;
 }
 
 static void brd_probe(dev_t dev)
-- 
2.27.0

