Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A86E776CE
	for <linux-block@archiver.kernel.org>; Mon,  2 Oct 2023 22:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjJBWCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Oct 2023 18:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjJBWCJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2023 18:02:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAC8B0
        for <linux-block@vger.kernel.org>; Mon,  2 Oct 2023 15:02:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so276176f8f.3
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2023 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1696284124; x=1696888924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiE9hgbeMO5MlY6aT2grrNu73E6OP67GEb0mAAXUID8=;
        b=Kkt4MHuzFr/KiO25JuyaVoSSUIQhO6lna/9zcGi2nFACq1dZW9jdUaKcirRTGUF2h4
         11UuxHyumFZdzWdJYuZDxIJs+EdPRLbQun33Os4hPCHurkMND0g2/fCkMMHXOq8ir17z
         zqvtp3Tm+DFP8kVx8Xwvc7wrVlLnHh3bfFNpit2ChT3TuJaeFjVS//J4vyLkHtF4r7AJ
         7RjdY/hixKBIXDwdKlwXNWncVQlY3pAQoU5H/ARA2dtu1fpS9keZBE7BgbDJgw1Dypxv
         U/pgnFHKn4NBej1LTNepcFTaK3NmZUg3EndGBfiEP/2wMXt8fb/ieL6cRHg6y2Onv5ek
         fnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696284124; x=1696888924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiE9hgbeMO5MlY6aT2grrNu73E6OP67GEb0mAAXUID8=;
        b=eapJMzIQTTPTfmQaQPC2PqWXshn0dqG9MOyg6YqS4SrsbmhhWUKmFIiDaZrzQnIxxG
         dc0I2+sae0O4qMmmsUs/6/Sk8hqawcTgcziEdyNMoc5nnSI/c/wgMkDSe86T9Q1jNyvS
         OeiSQGg4HJiKYlp+ck6v/mu4ZyU6yMr68IBNyz437RLc0Z5KJW8RGyg7O4ncmBmf/9B3
         XTE2DZOhgUmsjbJhgPyQ8adTIeKhYMfbZJr8y1LjHwB6bf0wi8YzBsZEvb4t9EeOznbT
         AzuZzP//pISDOjSRYnWJ6upsz6GYRtmKgLCb56tlCgLqsYHEYIBTtmxWmcdMedAcA8Ii
         wuSg==
X-Gm-Message-State: AOJu0YxBV3ISap6e51+hbfCfYI8BZP3Jp9LICJaZ1yWB5m/+pN4ycrZl
        NaYp79f2EFJRKKVtSAJhkKwvOQZFti1eczTVsOmvYYWOOSU=
X-Google-Smtp-Source: AGHT+IE4O6Z05eiyMbh0WZLDM+Tq3nR4H8+IkTZtmvXB2yLbYpgyOhFpT5B474k2hNAWMEnNVMVYMQ==
X-Received: by 2002:a5d:4cd2:0:b0:323:2f54:b6cb with SMTP id c18-20020a5d4cd2000000b003232f54b6cbmr11530884wrt.8.1696284124346;
        Mon, 02 Oct 2023 15:02:04 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c5-20020adfef45000000b00326dd5486dcsm6757397wrp.107.2023.10.02.15.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 15:02:04 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/1] cdrom: Remove now superfluous sentinel element from ctl_table array
Date:   Mon,  2 Oct 2023 23:02:03 +0100
Message-ID: <20231002220203.15637-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002220203.15637-1-phil@philpotter.co.uk>
References: <20231002220203.15637-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel element from cdrom_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
Link: https://lore.kernel.org/lkml/20231002-jag-sysctl_remove_empty_elem_drivers-v2-1-02dd0d46f71e@samsung.com
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Link: https://lore.kernel.org/lkml/20231002214528.15529-1-phil@philpotter.co.uk
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index cc2839805983..a5e07270e0d4 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3655,7 +3655,6 @@ static struct ctl_table cdrom_table[] = {
 		.mode		= 0644,
 		.proc_handler	= cdrom_sysctl_handler
 	},
-	{ }
 };
 static struct ctl_table_header *cdrom_sysctl_header;
 
-- 
2.41.0

