Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A2C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9B623884
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbhAHOhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbhAHOhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 09:37:18 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A965C061381
        for <linux-block@vger.kernel.org>; Fri,  8 Jan 2021 06:36:38 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id lt17so14842977ejb.3
        for <linux-block@vger.kernel.org>; Fri, 08 Jan 2021 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EiNKIQB4SZxip9loF5DwUxC/dWXpbt01EaFO3eOT2KU=;
        b=Tgt1MfuWl+vRPjQXNZ4+snCEsntO+/55gXY752tM30tkjXNW2vppg1YyARuL0Z/UF9
         1kju9SjwHXTJ/MVYn6NgfTZYUAMzgCvwTfatafaBfSIQ2unCZuQ0yqVoXR5rRczD18kT
         wbjVMPvEXILPKo6FosMir35NQDOLvzB2GmQhMrOsN5vmXUvGKLrj4/9+HNfv6D3afeOE
         YajoJ78U+v+lhVs1my+gH/uvRfAC00E2m/PTYaRX/zyD0QuMH5uQDC8NfsvmvUFlDYcT
         651ypY1nhuZBwHz5aod/Iz6vaasEftykGwo8wAKRA3gnG5Fe2XVl9e+uWu+rnr3Jj9OI
         jRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EiNKIQB4SZxip9loF5DwUxC/dWXpbt01EaFO3eOT2KU=;
        b=ZeSyI4uy9iOIrmdDzuZYoP/YluckS7UHzNpw/CV39zc6kQ9mt//FIbtze51XDvOc9s
         VHsDdBCX6dKyjsbwPDHl/9bwgFOh4qCavk3rVjVnpuwTfqB0KkzrULSupffvtqdBpb2F
         JplruQ+FprfVvOhLFlJ9tWzSsODj4OJNldUGXW/9XzDViswK3RYfjDRELBBRoUW/plQt
         tUKoO9Q7O9QvfsoZm2yOeWTO4eyHBpuQOMUqNipY+ov5a4eq0SK52FM/xndaFhmxZG5h
         l4WCYGv5/GlMXg5BtgQ6RdCtwg1tUCysAID28MUoOG8BkhKSJtB7VighW/emoOVLc3ev
         CU5w==
X-Gm-Message-State: AOAM531Mom0DQEueo/1EKPQSzwbWhsBBXqi1xeA1M/yvhS+ar5M2Qq8M
        6CVY36xjWL2vrwz0YWFdccv5o60zlZZ9ZQ==
X-Google-Smtp-Source: ABdhPJxO8NtKkA1WDM4pPA5b3EkOPgvOOTOBLcznjWn/MI+h/we4DFbBePeVS/b4wJDzJxUiA8S/CQ==
X-Received: by 2002:a17:907:2506:: with SMTP id y6mr2830044ejl.53.1610116596459;
        Fri, 08 Jan 2021 06:36:36 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4906:c200:31ac:50df:cd1f:f7fc])
        by smtp.gmail.com with ESMTPSA id e25sm3858698edq.24.2021.01.08.06.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:36:36 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-rc 1/5] block/rnbd: Select SG_POOL for RNBD_CLIENT
Date:   Fri,  8 Jan 2021 15:36:30 +0100
Message-Id: <20210108143634.175394-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
References: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

lkp reboot following build error:
 drivers/block/rnbd/rnbd-clt.c: In function 'rnbd_softirq_done_fn':
>> drivers/block/rnbd/rnbd-clt.c:387:2: error: implicit declaration of function 'sg_free_table_chained' [-Werror=implicit-function-declaration]
     387 |  sg_free_table_chained(&iu->sgt, RNBD_INLINE_SG_CNT);
         |  ^~~~~~~~~~~~~~~~~~~~~

The reason is CONFIG_SG_POOL is not enabled in the config, to
avoid such failure, select SG_POOL in Kconfig for RNBD_CLIENT.

Fixes: 5a1328d0c3a7 ("block/rnbd-clt: Dynamically allocate sglist for rnbd_iu")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rnbd/Kconfig b/drivers/block/rnbd/Kconfig
index 4b6d3d816d1f..2ff05a0d2646 100644
--- a/drivers/block/rnbd/Kconfig
+++ b/drivers/block/rnbd/Kconfig
@@ -7,6 +7,7 @@ config BLK_DEV_RNBD_CLIENT
 	tristate "RDMA Network Block Device driver client"
 	depends on INFINIBAND_RTRS_CLIENT
 	select BLK_DEV_RNBD
+	select SG_POOL
 	help
 	  RNBD client is a network block device driver using rdma transport.
 
-- 
2.25.1

