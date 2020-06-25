Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7A1C433E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F28A20724
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="a4kPMuPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404451AbgFYMWZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404343AbgFYMWY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 08:22:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17DEC061573
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so5629346wrm.4
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Ju3UDNPPwBAk1TA1zeQdRuOHY5B22Z1S54Q7dxG7ro=;
        b=a4kPMuPRI94jYMbUyDiniUkJA4zHEgowzmPRA9qYcmXUwmmW3U2rYITJC0+M3sTR78
         KVXqrURRTM+O4yO3SgN2zJ86WC0cyeLX4d6ryi0wJ4Nebi7WZSqa6HHD+ZxZvrewq2P1
         OX/BOsVovRoiGC4xBatKL4iWx1NRQVYBtAw4yOxNz/O3PjT9uXFP4y4Nj8oL38r/lITX
         kAbq+bt36sje5oCKcgh4VWXRlBXjvDHYB7DPPqkFBXZ5RjqJzA2sYDnBwcoQeylDqJar
         Y8bM/RXncZrCOKNrv/To5XmqAVNpHfZwuL7rHFdVrXynZOqA5NRy1K7PRNn08PiUkKLB
         pxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Ju3UDNPPwBAk1TA1zeQdRuOHY5B22Z1S54Q7dxG7ro=;
        b=meV75KAL1RTNDU8MnO1GaEmPym3ztN1kbuf8DHMeuSrnB/vrXRKdTbIh7Pocxy25QL
         fEYJ4gHsGYLKcctDlT8Lcab/+7hBSK2dPA/TYCB8cVQXve/ERHJBK0POj6aaO4zZ4qEj
         lsxeTgM6zuKmUAMOYDQccalwU6niG8sYpRbPl/dBRNyxTD2nsFAHUY1y+gAYcd2etPYs
         /dbY1b7M27eVnsMO7SerNrhZKfPx+dK0pBEw9AJQCIFNqbPpcmHOZZHXIsE5zFDb+slY
         ofZGNBi2e+R2BuX4qmk3mElSJo3Ixvst6fuJYzkfV5aGvT6pscbQSotzm+iqyP35u3QG
         jPyw==
X-Gm-Message-State: AOAM531UtVEJqbtqJVpkOTChT76oH834/eev+DgNloCdQtvV6hd2w70g
        lFVUNC/GhiFOznS7vEtGixrepqsqzKAJ7Q==
X-Google-Smtp-Source: ABdhPJxWQm3VN+zqrMTnb8iXcKCR7M7Ez3ONvMlEt8CNYRRoA4A76A69bhclHB00O5N4pgSPkhGdNg==
X-Received: by 2002:a05:6000:128e:: with SMTP id f14mr39466905wrx.276.1593087743370;
        Thu, 25 Jun 2020 05:22:23 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 05:22:22 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH 6/6] nvme: Add consistency check for zone count
Date:   Thu, 25 Jun 2020 14:21:52 +0200
Message-Id: <20200625122152.17359-7-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625122152.17359-1-javier@javigon.com>
References: <20200625122152.17359-1-javier@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Since the number of zones is calculated through the reported device
capacity and the ZNS specification allows to report the total number of
zones in the device, add an extra check to guarantee consistency between
the device and the kernel.

Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/host/zns.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 7d8381fe7665..de806788a184 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 		sector += ns->zsze * nz;
 	}
 
+	if (nr_zones < 0 && zone_idx != ns->nr_zones) {
+		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",
+				zone_idx, ns->nr_zones);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	ret = zone_idx;
 out_free:
 	kvfree(report);
-- 
2.17.1

