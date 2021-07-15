Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC90C636C8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9328E613D0
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhGOU0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:26:53 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:53780 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhGOU0t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:26:49 -0400
Received: by mail-pj1-f51.google.com with SMTP id p9so4916015pjl.3;
        Thu, 15 Jul 2021 13:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jpkbAh2zGtVnXE5Vrs6EbebFesmpRHOXPnwAKrG5O24=;
        b=ZkgghTuPb74KpBQ+nx4S2tfDDXW0UeKJGftc5Q5ZkFlyEO/9L89gZJrGnuVl+Od8Eb
         JzLu3uUUzapytK1Fsks6ohD5WyEDjiaaFPzw1xN9eVVarkoEjLdYscClpEW2VhvDXNQX
         oA4sq//FKu8xlMJdaUrv9EW/nz39M91gttVL/x9LRClnHeBZ+0ysUKjnJgaxsyMR5cwa
         3t7iXiplcE6I4Heu72V1SzjdjgioOgBeJIHBF/CxKAdTVQgMxwihM8cJrMf6aqx2DKh6
         3ymSIOr4VaGWfxpE8BJdV0nUEyM/VsJaQGzMVHmrumgvT2EWRAFoTXgVXxDy3ei+W9Vh
         6IsA==
X-Gm-Message-State: AOAM533LULV+g+/DyFy8l3HcLBuKCkIhW2LB4I8SYBwZuw1s9MySC9U1
        Z8/W8Lo7v+aEScHndEDmCDQ=
X-Google-Smtp-Source: ABdhPJwbMyXTDD66AXNzOglt9fDniCC9F5SUVPDHZmJFGQKTgpQNXglkn71IK39i0hhbf6GYo8s7/g==
X-Received: by 2002:a17:90a:6a0e:: with SMTP id t14mr6171722pjj.19.1626380634310;
        Thu, 15 Jul 2021 13:23:54 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id p25sm7319984pff.120.2021.07.15.13.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:23:53 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 4/6] mmc/core/block: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
Date:   Thu, 15 Jul 2021 13:23:39 -0700
Message-Id: <20210715202341.2016612-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715202341.2016612-1-mcgrof@kernel.org>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The GENHD_FL_DISK_ADDED flag is what we really want, as the
flag GENHD_FL_UP could be set on a semi-initialized device.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 9890a1532cb0..5bb3e604e618 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2637,7 +2637,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		 * from being accepted.
 		 */
 		card = md->queue.card;
-		if (md->disk->flags & GENHD_FL_UP) {
+		if (md->disk->flags & GENHD_FL_DISK_ADDED) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
 			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
 					card->ext_csd.boot_ro_lockable)
-- 
2.27.0

