Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFAECCA47C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiF2Xcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiF2Xck (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:40 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017FAE7C
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:38 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id g7so12040277pjj.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=em6yC1nJBqhda0/ce2JkGsc6X9Cc4a1yxA2aCbnqMj0=;
        b=unriyezk5YzZld38CYiun593hdzhCnCXeEGp2JhMwr8BgeMkJmlGmKPz17YjrHpdJ8
         eH9jn/vjk5bfoFnCuZ/IsimJfaoK9VzGzGUeOJZDvkFTqSKu3nSrloq5sUYBLWjiEjrI
         fKw6mFdlNEkOjbV6tu2Pah5Ca5vBJuCrr4ZtcytBuRdIfIY5Tk3fHIxOZuCBjL+YBKEK
         oGc3wXIalinW32rfQBuU8uTd3bKxfkdOyyLJXR4YhfLmo6nh69YV7WyAUqzkMVbTIJ4P
         mV3+LD1jGFK9SWHQe04Tq5uYT8iCTmZ7zDL1AIKi66aaHoKLSUB/FcIzj4aPE87SX/PQ
         Jr7w==
X-Gm-Message-State: AJIora/JLNZR8LE/Mxl11YnYTcTtOt9j2EyIrWVNEqd6gRcaOAXG6OC4
        omRjXNpFc1dcQg2B3nHjMiw=
X-Google-Smtp-Source: AGRyM1uL5RLmiPHHMzHBkR3bqTeu5To0KkqdELf3raquW/kwKV5jrnsqxZ7xzqTxI61PSIkPSASigA==
X-Received: by 2002:a17:90b:1bc5:b0:1ee:9563:2fca with SMTP id oa5-20020a17090b1bc500b001ee95632fcamr6359223pjb.87.1656545558390;
        Wed, 29 Jun 2022 16:32:38 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v2 29/63] dm/zone: Use the enum req_op type
Date:   Wed, 29 Jun 2022 16:31:11 -0700
Message-Id: <20220629233145.2779494-30-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the enum req_op type for request operations instead of unsigned int.
This patch fixes a sparse warning that has been introduced by making
enum req_op __bitwise.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3e7b1fe1580b..2e87237a35a5 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -361,7 +361,7 @@ static int dm_update_zone_wp_offset(struct mapped_device *md, unsigned int zno,
 }
 
 struct orig_bio_details {
-	unsigned int op;
+	enum req_op op;
 	unsigned int nr_sectors;
 };
 
