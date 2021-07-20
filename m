Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE42C636CE
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 18:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA186120D
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 18:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhGTRk5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:40:57 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:54232 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhGTRkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 13:40:23 -0400
Received: by mail-pj1-f53.google.com with SMTP id p9so162841pjl.3;
        Tue, 20 Jul 2021 11:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aVxF8vfMwahjjcVE0G9rhQYp1/g2MPQW4J5K6wSY/5I=;
        b=pbJkBHtehGKfmwz6gipAEmPfhXeVychSKKhpzA77Y5FdKUddVTPQDi+fgUcoqmMdSs
         Nb/64ugnak9cxxTW5qSZl74/7zsZea8lRaFxrKlqu68x8YQInZD6nMnf69wpTbeQDFth
         9VrgWRxQv2SPgsYvwj6KpyXbA3LitI/TaO+IpeHpfEB54OCgkGY4aHtbqUDBDZgENwRo
         Rk8n/ciT+eBy7xuJ7OJlV2vwJNu57Cqd2+ChWzU2mt/gBvJnhogQnyLddVTNjncmYAZ3
         oKRoXI+5MuHDYpeODXr3XHtlKSqa1eSKI0tI+P1nSG0fBby3JFbckjQlpdHrASvnW+kJ
         keeg==
X-Gm-Message-State: AOAM531kUc+rDq6aBafcKvR5EhLsUVWhD9dSQvb4NxWwV7sbDxZgMrXz
        +qJy+Ac544Cgtrpz46Yheyk=
X-Google-Smtp-Source: ABdhPJwEuCvuy12ecggY03x8sSitmLbKvELW0ge/P1pcgnu4pEbW/CPQ6glJoi9TbvyqIehG3EVYTg==
X-Received: by 2002:a17:90a:2e0a:: with SMTP id q10mr36294529pjd.44.1626805259290;
        Tue, 20 Jul 2021 11:20:59 -0700 (PDT)
Received: from localhost ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id s15sm24582228pfw.207.2021.07.20.11.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 11:20:58 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/5] mmc/core/block: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
Date:   Tue, 20 Jul 2021 11:20:46 -0700
Message-Id: <20210720182048.1906526-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720182048.1906526-1-mcgrof@kernel.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
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
index ce8aed562929..e9818c79fa59 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2644,7 +2644,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 		 * from being accepted.
 		 */
 		card = md->queue.card;
-		if (md->disk->flags & GENHD_FL_UP) {
+		if (blk_disk_added(md->disk)) {
 			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
 			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
 					card->ext_csd.boot_ro_lockable)
-- 
2.27.0

