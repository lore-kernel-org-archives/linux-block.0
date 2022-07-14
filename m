Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4B1CCA482
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbiGNSI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiGNSIY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:24 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523A568725
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:23 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id k19so1119529pll.5
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OScutpI6WflGHAkhP3TPlkwOpwBuRNS4LW24iZ5zQGg=;
        b=yYTs9QxOT3YYhBIamamY1Tbl6luLNmq426TsN7q741Q9YONGmk7c1UfIhQqSnrE6Qi
         bj30GhJcFY5iazTzmqE/OidCBXwn8u7MQQZ/CNgCSmSvPDp+BKWXUxNv0IqmoAl0ICY6
         jEUcnj1Vx5dXQBHxY8gi8ypKCO0RZ1SJ7ukt0EcVXM0HWFAmn041bokpABamBXEB66R5
         iyuTy0s6aV3Jybw5lvbhJqzs6soTzoqUmP3hTrfhGvxuBRaH3MYY/vrYsMqrvijtYZIA
         HvdVlt6IyMpzRxFBkmuY+97RP+bhbC0UgG9XiOM6FCrx/3gx7HlGZGAO4SnhgJxdm9r0
         wynQ==
X-Gm-Message-State: AJIora89Z+tckMp/lWspLtoBmb7nDOtRtYY861WZl/aZJbdlOakZ5XNZ
        iWbJMhygjzS8DzOXaoqS+9o=
X-Google-Smtp-Source: AGRyM1tjSP30F61HyvYFXGQ0L0PG6XBvkhD/DY/s0D1Ptq98vpNbIEXAUS5mjrnK/ckHx798lBfWXA==
X-Received: by 2002:a17:902:8547:b0:16b:df3b:203 with SMTP id d7-20020a170902854700b0016bdf3b0203mr9130727plo.137.1657822102769;
        Thu, 14 Jul 2022 11:08:22 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v3 29/63] dm/zone: Use the enum req_op type
Date:   Thu, 14 Jul 2022 11:06:55 -0700
Message-Id: <20220714180729.1065367-30-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the enum req_op type for request operations instead of unsigned int.
This patch fixes a sparse warning that has been introduced by making
enum req_op __bitwise.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 2b89cde30c9e..4d10f302c62e 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -359,7 +359,7 @@ static int dm_update_zone_wp_offset(struct mapped_device *md, unsigned int zno,
 }
 
 struct orig_bio_details {
-	unsigned int op;
+	enum req_op op;
 	unsigned int nr_sectors;
 };
 
