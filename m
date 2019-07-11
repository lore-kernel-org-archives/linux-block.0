Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9E3C742A5
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 19:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8793820872
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 19:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="kRCDtdkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfGKTWh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:22:37 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:42992 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfGKTWg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 15:22:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 956F7ACB
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2019 19:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id okYuYL9TnsYG for <linux-block@vger.kernel.org>;
        Thu, 11 Jul 2019 14:22:34 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 6DDD1A12
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2019 14:22:34 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id 132so7863145iou.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2019 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=04r+xkfi3OIxIAnYMbyBVwPuxdAwHrdKDxo/QJz9TXo=;
        b=kRCDtdkKWDupkwiDvuAHjTjjn6YF6vYe+M23iFm7rjC9nCrglDHxUtsu9IqVnPNCUw
         f1efLF/yBqTHqxnNCsqMC4iZCGCu2FiBJBRDofzVGoOeNd1aEjcIB3EQ1AecMz19ls4Q
         dkJKau+qfJRQnsQC5BgI9cI259ChqPd/LRs1T8/1UjSsrNMWjzAvNTrTYhhfhByM8ai/
         Fuy1f00937LWrXRFuBCiNieNncfblHnTD2if+0J8Vk9a5qUW1mqEmI0EFKblfyvyuy65
         VQbiEGyFf9+GcFtQ2laOCumU/cr+x85rQKzlqHBKqeUsuf8jfQG6ciLpHJnq70t0Mhpk
         WJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=04r+xkfi3OIxIAnYMbyBVwPuxdAwHrdKDxo/QJz9TXo=;
        b=dOzBZbmRRjCS6G/5EOQOjr12MvPPF6BpA+WWvxXyO8e2w8eVs9+EguV4Ugbb9R7E1O
         bBnnP9imBtI49YMw78CZlQGIkWIXQCvRDwqG2eIbP/HuGNrFUC5WYIlSM0odgsduL62U
         DTZgxxYPsaEE/7KBWost467PlkFk2jkPW6a75uM3jicG5nguDO3C4zBQpfxI2bQ13k5Z
         wG0yl/0BPNVwpdf7N2Ko5ZpkisiSXWeLoFNFGyMHxaQ5UiVvTogHTkwx8y1aQ25zvS1H
         9GBIoWUtEime/8zM3MbLXfIE7faBeq4HCYtZcMHNi/FENswzV9lPV22LPYgL0LEJ1YPt
         TuOA==
X-Gm-Message-State: APjAAAVEwGjAw0gTpWRMGOSgYhKmRTkzz5/lFhk/eZa0J6iJHzCtzQVH
        H05uFy6eOZSeyHjnUPdfmD/xpEYSuSZFBL6Cw9SacDc8Iq3D9McGPH7EbpOfjSiP37Qe2TZ7dZV
        kwhbB4B81ePxLcZ0SyrKFRJf1TRo=
X-Received: by 2002:a6b:f711:: with SMTP id k17mr5891515iog.273.1562872953858;
        Thu, 11 Jul 2019 12:22:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/oBuIk60mhI4isOWmFv2H/1EonKWKX/fEvEckRCa0a+lY1XboOURnqhKOt66OGfCLdBxd3A==
X-Received: by 2002:a6b:f711:: with SMTP id k17mr5891495iog.273.1562872953548;
        Thu, 11 Jul 2019 12:22:33 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id 8sm5505611ion.26.2019.07.11.12.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jul 2019 12:22:32 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] block/bio-integrity: fix a memory leak bug
Date:   Thu, 11 Jul 2019 14:22:02 -0500
Message-Id: <1562872923-2463-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

In bio_integrity_prep(), a kernel buffer is allocated through kmalloc() to
hold integrity metadata. Later on, the buffer will be attached to the bio
structure through bio_integrity_add_page(), which returns the number of
bytes of integrity metadata attached. Due to unexpected situations,
bio_integrity_add_page() may return 0. As a result, bio_integrity_prep()
needs to be terminated with 'false' returned to indicate this error.
However, the allocated kernel buffer is not freed on this execution path,
leading to a memory leak.

To fix this issue, free the allocated buffer before returning from
bio_integrity_prep().

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 block/bio-integrity.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4db6208..fb95dbb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -276,8 +276,12 @@ bool bio_integrity_prep(struct bio *bio)
 		ret = bio_integrity_add_page(bio, virt_to_page(buf),
 					     bytes, offset);
 
-		if (ret == 0)
-			return false;
+		if (ret == 0) {
+			printk(KERN_ERR "could not attach integrity payload\n");
+			kfree(buf);
+			status = BLK_STS_RESOURCE;
+			goto err_end_io;
+		}
 
 		if (ret < bytes)
 			break;
-- 
2.7.4

