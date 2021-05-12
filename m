Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E390C433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA18B6192B
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhELHDM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:12 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:34321 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhELHDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:11 -0400
Received: by mail-pl1-f169.google.com with SMTP id h7so12054286plt.1;
        Wed, 12 May 2021 00:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIU5NBd44rET5oIvFec47Js8PgNn4WiUZZ4zHjeP6A4=;
        b=C92edRZAsIC83kH1dWv/f2TvUQ2cJA9cnauH56BqfkccETkrApjef6yhKSxgU5WCpF
         NJPgnS9nRb/0yb6EPC5ZYyZkcNfgPedBBXMOsJooZNcQnSmCKexznTLtvNfQYMi/KiBt
         Pv07HrSDe6KLM/kTOZJveer7WwcZ29OBdoVRDO1QObxZ50h5ToMmgeR5bGq6RAVLya6v
         mLqnvDACyDsPjDkKMWknrpKbvsSxXDMQl/UUYU0jBDeg+xA62Riuelx7t2wexQxpRlkz
         j/7ly9wYeFsZrGjdZ9WLq8ow0PRdxjRCRRcg3F0wDOMINYgk7g9ZjnDPNcpY+JF2IPac
         0EtQ==
X-Gm-Message-State: AOAM533xHk2Hr9K+TyqIdAXTkTJQw2ke9wXk6ZDLRcVwn/oSCkAKMvRt
        /VPrM7D14rz/Wr0wNfk78w0=
X-Google-Smtp-Source: ABdhPJyEg+77pXW4TZbKBQt6IbwJveQvIAwyhyHRokY57ATBYzmicvabxKfdlfTXH0M4YjyQffXZ1Q==
X-Received: by 2002:a17:902:7444:b029:ef:80f4:67e4 with SMTP id e4-20020a1709027444b02900ef80f467e4mr2430995plt.66.1620802922738;
        Wed, 12 May 2021 00:02:02 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w125sm15173515pfw.214.2021.05.12.00.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:01:58 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 59E3D42435; Wed, 12 May 2021 06:46:35 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 7/8] null_blk: add error handling support for add_disk()
Date:   Wed, 12 May 2021 06:46:28 +0000
Message-Id: <20210512064629.13899-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210512064629.13899-1-mcgrof@kernel.org>
References: <20210512064629.13899-1-mcgrof@kernel.org>
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
 drivers/block/null_blk/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 5f006d9e1472..2346d1292b26 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1699,6 +1699,7 @@ static int init_driver_queues(struct nullb *nullb)
 
 static int null_gendisk_register(struct nullb *nullb)
 {
+	int ret;
 	sector_t size = ((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT;
 	struct gendisk *disk;
 
@@ -1719,13 +1720,17 @@ static int null_gendisk_register(struct nullb *nullb)
 	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
 	if (nullb->dev->zoned) {
-		int ret = null_register_zoned_dev(nullb);
+		ret = null_register_zoned_dev(nullb);
 
 		if (ret)
 			return ret;
 	}
 
-	add_disk(disk);
+	ret = add_disk(disk);
+	if (ret) {
+		put_disk(disk);
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.30.2

