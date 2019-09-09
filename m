Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C595C4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A0E218AF
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKecVQdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbfIIM5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:57:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55344 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfIIM5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 08:57:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so13723088wmg.5;
        Mon, 09 Sep 2019 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9dOAoF+NVQifcpb/BbgRzIPKsZ1zx/+IZ0bgP9rlPU=;
        b=GKecVQdo5QlW/zjjYlOyec6TpmIU9rYRk6sGaQ4C85qEoGFeVADlrwkNfV+e0SmtpA
         Hcf9MSjmF6GuLrhv8jkFeypMzR8QOjwVNvwV763nEcLEFft8mf5xuCn3j6mDTsCKg/xv
         ZPcsgpcBY1cwAlQm+FCUNtIk3Ew+Uv+lbjfaalcXoGtfT/axRAeH1El3e784ONPfSrCu
         0HcqCgF/VeSFcGmIce18RLXHReTd/2eZ21krOzPVncukV77O4QWn661C7fUs1wvDBT9f
         toZBMb/R8L76N5EdFfiem+4zNhqnwcGBAIMzLz/aMv9HbZmeAHVPB9w6trFAH6nv7rQI
         5zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9dOAoF+NVQifcpb/BbgRzIPKsZ1zx/+IZ0bgP9rlPU=;
        b=a3qZIcZqgx9Ut/DPdN9U7kJPux6+VCkLPwtKXhpRc6rs/iTp2ol52qEAb5iZ0Ri4v1
         hTG7DXjdDAGUCxEaruA9/d0u41pEXPmNvXrHMigmBwzA3GetPBzoSiZvARpv/epdxA/m
         qP1n5YuLm7w8gtY9zZsz8yDTqK6aaqQHf66/Otgbf2R60yRW1pegjUQtHSZ5C3p7MMxr
         eQZ+SHAtHz3o5Z0Zyxn58vmXb9Xt8wGCDNonQDrAEh5sCVWImwY/lxshrKowSe8oC8WH
         wzGNFV1z95gDzbcZsWuHkYTTxhUaZTE5x4uiyfogvI3kchXX+Zg4yxeoClMUBu5u93fs
         6oRQ==
X-Gm-Message-State: APjAAAUl8s3iYXSaWp6CJu2xzpStJJ+KnmLOwXl8d9yjmOtXiRju/2JU
        5kOm5QVuv1C9KgAkfC7iTgk=
X-Google-Smtp-Source: APXvYqxfR39uvTELiXDUIBV8O0QVMGbRh9Q7Xqc/ClttWuFq3LAk3zxHhGtXnG50kIBA0mILD0eVow==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr18408055wmg.25.1568033824301;
        Mon, 09 Sep 2019 05:57:04 -0700 (PDT)
Received: from localhost (p2E5BE0B8.dip0.t-ipconnect.de. [46.91.224.184])
        by smtp.gmail.com with ESMTPSA id l62sm18297104wml.13.2019.09.09.05.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 05:57:03 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christoph Hellwig <hch@lst.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 2/3] mmc: core: Respect MMC host's maximum segment size
Date:   Mon,  9 Sep 2019 14:56:57 +0200
Message-Id: <20190909125658.30559-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909125658.30559-1-thierry.reding@gmail.com>
References: <20190909125658.30559-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Do not overwrite the MMC host's configured maximum segment size for DMA
transfers. For devices behind an IOMMU, the queue's maximum segment size
may be larger than that of the MMC host, but that doesn't mean that the
MMC host actually supports it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/core/queue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 1e29b305767e..987b01f4cfb3 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -389,8 +389,6 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 		blk_queue_max_segment_size(mq->queue,
 			round_down(host->max_seg_size, block_size));
 
-	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
-
 	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
 	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
 
-- 
2.23.0

