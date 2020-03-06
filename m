Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF21C3F2D1
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A242073D
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDA7zUNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCFCNL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:13:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37954 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCFCNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:13:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so525345ljh.5;
        Thu, 05 Mar 2020 18:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wabg51D9gVFdZmwGILk+PNoiwB7CSCBLaOu5bBJA6MQ=;
        b=CDA7zUNFYgBiMnVeXxblPUiuodOsV1slXflncfVLlsmh7On/RMeAS3ws4jEY2cT7Z/
         LLUcZZ9zZGuTulKxYJXi30qqPuT12NApmI+yO3fco89K2UsjM92N5E0LrA6IIlNUofwh
         3/s7DZgg+M0UqE6pQ68ZWohEZr3qk3WarWZG2HkMwDICffxjUlQByoBx+68vTVP6uiRV
         kOmCs+u62hms+qw/d/VpZ4Sw5aS15Ibx6u+O+zjZOCbs0fjJWTA0zdwT+I+8ry4QwmHO
         1N7hkNMdWSAHMFZ80p0p9g88rJNextyYs76fyj8WuUsRNrfx3D9JMCWy7lLSyb9OMTzz
         XBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wabg51D9gVFdZmwGILk+PNoiwB7CSCBLaOu5bBJA6MQ=;
        b=GBtzKyG7MW1y76kjcJhbi2R05T2PluvWzLkRep8+qE4TJG5SU+NLNntJlZHMyP0WbJ
         3GFNIkXWaxG95q0xj4vYNoPDbLFxT4qBrs0AYcAotcTPJvdHZuX+T4202Gy4E+rDINQ7
         8llmb/p0RINP+daIaBmYo424ewIWi/FR0S7f5tSnWXMCXgTc4rxMsLZa6Lwvj4BVbckW
         mFOePszh4V9xGIaSQ8CdMcM721eDF90HWucHtyqNPl8aLZfMwS6t2ZJ2WBnRQRCOxsuj
         emRjOPi5wZdZrWxhUJCczy5na3V5O9prZZ0aZ3vONIBP3jgzhe7NMun19RqyW5Ti08pX
         KyXw==
X-Gm-Message-State: ANhLgQ2auxsbBlwYO3q8WWzg9Wpw9djNhwq5FUfUKAE+BneDXIpAES35
        v9VJ30dP2Ibv7jRlUffXYnw=
X-Google-Smtp-Source: ADFU+vvoPGanJEdTBlfo3M7P+8VNt4spDbAkZRi5yTmd5IEWTE+o3rxEJ+Grhf4f+K/dPqWnou0NcQ==
X-Received: by 2002:a2e:b78e:: with SMTP id n14mr564850ljo.269.1583460786531;
        Thu, 05 Mar 2020 18:13:06 -0800 (PST)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id l11sm10592772lfg.87.2020.03.05.18.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 18:13:06 -0800 (PST)
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
Subject: [PATCH v2 7/8] mmc: block: Enable partition-table scanning for boot partitions
Date:   Fri,  6 Mar 2020 05:12:19 +0300
Message-Id: <20200306021220.22097-8-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306021220.22097-1-digetx@gmail.com>
References: <20200306021220.22097-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some NVIDIA Tegra devices store partition table on a boot eMMC partition,
and thus, boot partitions need to be scanned. This patch enables scanning
of the boot MMC partitions. Please note that boot partitions will be
scanned-only, i.e. the scanned boot partitions will be kept hidden.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c2bec114fd6..b834c830e19a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2410,9 +2410,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->parent = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
 	md->disk->flags = GENHD_FL_EXT_DEVT;
+
 	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
-		md->disk->flags |= GENHD_FL_NO_PART_SCAN
-				   | GENHD_FL_SUPPRESS_PARTITION_INFO;
+		md->disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
+
+	if (area_type & MMC_BLK_DATA_AREA_RPMB)
+		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
 
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
-- 
2.25.1

