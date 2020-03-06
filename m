Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD95C3F2D7
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4523E2073D
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsCV181M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCFCNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:13:07 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37382 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgCFCNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:13:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id j11so608109lfg.4;
        Thu, 05 Mar 2020 18:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w0YlAmpluZ5D3NO8kHqv749YNcVtvXYMv+8BYDY6gX8=;
        b=hsCV181MEGJLDvWFZgWaLAlN9Hm3d50nlxh66iesrGVhHMN/vPEJQCqd8pCEt89nZj
         k9vnx8idWPoKXIuVKzj94SopvJdroGM4O78DMBVhgn0XUfPaF4UKLDEQCv4IYWeOZPmh
         8p0dkM7QyNLUr6Ym7ytwv8hv8JliSDIZ/+jwgZrTIlugMk4SmZ87ieBMvaaYvUCuq1hL
         IlCPwObpeVNxe/zYwj79BnOzV7BW2/x5vP4E3Dj5vWfR6blv6OuBfVTpb7GbrJme0S/w
         sORm7nKocKEfJK1pp7iuUai5ACEJbonceSysClu2m1TbqtUE1pRm63UWMSu23UhVYkJs
         QYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0YlAmpluZ5D3NO8kHqv749YNcVtvXYMv+8BYDY6gX8=;
        b=gT4zwPCFTmkmjDAQPM0J9DDlc+V/P7gjek+G8p+5Vkth7iDVT/SLM/czKRqy0+hrT9
         myRepiC37/o5qLx7RLa6+l/YpRex/4QZ9sxJyfOWQiBVRlTU8DmqS51o7I4FwCk1IT4X
         1/OaVe/4cxQ/FzhEDWoqF5pl3nJGiehoQLAPZdiltuy/tEnqrrpdM31eDE1sPJ0XwwGZ
         ut+EUV+0xX0gzDZb0Bvy+1y1Gf0cyIXa4OrwNuqjd/5+2OljlEhpFaAw+wAuRqDiRNca
         yweDBtuwCf63TMP3WqriVIn6oO5+z31k/+YN92YkOg3C2Ad0PQ/R1nwuHIitdhL3WfOm
         cCTA==
X-Gm-Message-State: ANhLgQ1qK1duVFinpsIWlpKPicTKoeO3iyo9/okRU5DGuqBCVspIIQD9
        3a0ttB1lxsG7dOTXO3N/+UM=
X-Google-Smtp-Source: ADFU+vuGmr3S9NwjJoS2M2yUJSkaF54dmtDYx9pIkC8T+YfNRrdI6CbLbMiYb5BqQbR8gHCZiMAOKw==
X-Received: by 2002:ac2:454f:: with SMTP id j15mr416289lfm.20.1583460782961;
        Thu, 05 Mar 2020 18:13:02 -0800 (PST)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id l11sm10592772lfg.87.2020.03.05.18.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 18:13:02 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] mmc: block: Add mmc_bdev_to_part_type() helper
Date:   Fri,  6 Mar 2020 05:12:16 +0300
Message-Id: <20200306021220.22097-5-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306021220.22097-1-digetx@gmail.com>
References: <20200306021220.22097-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVIDIA Tegra Partition Table parser needs to know eMMC boot partition ID
that is associated with the block device in order to validate and parse
partition table properly. This patch adds new mmc_bdev_to_part_type()
helper which takes block device for the input and returns a corresponding
MMC card partition ID (part_type).

This is needed by tegra-partition parser in order to distinguish boot0
eMMC partition from boot1.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c   | 16 ++++++++++++++++
 include/linux/mmc/blkdev.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 36d84a8e182c..2cee57c7388d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -321,6 +321,22 @@ struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
 	return md->queue.card;
 }
 
+int mmc_bdev_to_part_type(struct block_device *bdev)
+{
+	struct mmc_blk_data *md;
+	struct mmc_card *card;
+
+	card = mmc_bdev_to_card(bdev);
+	if (!card)
+		return -EINVAL;
+
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md)
+		return -EINVAL;
+
+	return md->part_type;
+}
+
 static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
 {
 	struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
diff --git a/include/linux/mmc/blkdev.h b/include/linux/mmc/blkdev.h
index 67608c58de70..24e73ac02b4b 100644
--- a/include/linux/mmc/blkdev.h
+++ b/include/linux/mmc/blkdev.h
@@ -9,5 +9,6 @@ struct block_device;
 struct mmc_card;
 
 struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
+int mmc_bdev_to_part_type(struct block_device *bdev);
 
 #endif /* LINUX_MMC_BLOCK_DEVICE_H */
-- 
2.25.1

