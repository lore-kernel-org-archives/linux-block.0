Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E89C433E9
	for <linux-block@archiver.kernel.org>; Sun, 14 Feb 2021 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988C164E4E
	for <linux-block@archiver.kernel.org>; Sun, 14 Feb 2021 10:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhBNKcF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Feb 2021 05:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhBNKcF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Feb 2021 05:32:05 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F063DC0613D6
        for <linux-block@vger.kernel.org>; Sun, 14 Feb 2021 02:31:24 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id v7so4782302eds.10
        for <linux-block@vger.kernel.org>; Sun, 14 Feb 2021 02:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/U2T4IrWRqK1txY9dbrzK33wHubgqmrESvD+fiR0Ik=;
        b=IweCYZrQjO55Sbina76EkLEFEUqimSM3kdWGF2QZQ1hMfq9hfYRyiE4RejWtOx6Vnz
         5VZ3Z9NTeAwDGTgmYVXAtPPmmylHMZuAU2Gw7y8s7Rsp0Iqbe8NNFaPfnjdbRyZtcogD
         Ubkuh2BdNzs3hJCjx7nBRZKbh+uwF+TtngUD2M3Th4PxO46IgK0j/SapXyys5voqU3Bm
         6qGc9MpIDvQ8Pv6/QJRieHZK0XEwyoOIaWYLj433NBprqthKpCIR80X7ewWcFKGBeiLL
         v5Pu6P0XsVmQzTZc9pqd5++ZA5XO5/do3pRErGICdHoajIIU01cWme7y18i4G1JroCsw
         LHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/U2T4IrWRqK1txY9dbrzK33wHubgqmrESvD+fiR0Ik=;
        b=BJ8zD2dCu7aEY4T1W3jE05gspGKgF3FW9nScoq9VqGLV/33FdLjxCBs/vHh+C4IDt/
         ONaFU2u4ikQjFPMSBF1TGrsLKe4PifwH05/1IhYVp+QJBolQfilWUjX7xFYa0j91+aZ3
         F2Tz4rzEZ/GiEHQ0irsldqoolQ2iD3Ra8LBdiT7OJ6rQ0/ye2ae7M//TlPpesCLJ8Q1K
         F4h2ga2EgSKqOXwcCZ47ag+arwaFkX5jhphz05bC5h3Mq17LEqncMNbI9w6RFjfHf2Wr
         3GrRpcJdAgPH5zJ8hwVOAFCuJo+SWjWr3t7/Zm884gsNwDfgND/DtPzPJ5S3xGZEh264
         mNPA==
X-Gm-Message-State: AOAM533qhrcAssb9ytxb5a4w3yJ3SVK2clSciFqlNo+Nz93KqsThtToP
        sMfWcDgj5kcpnIn6xiZL6dgn9jR8Y8ZWy/Wp
X-Google-Smtp-Source: ABdhPJwpbPyaj6+mXTsLty1o+Epl+/TGdkeM1Mc6eky404j/UaBfoiprEvg17ns1GfUD9ESv4BJI5g==
X-Received: by 2002:aa7:d2d2:: with SMTP id k18mr11214897edr.222.1613298683768;
        Sun, 14 Feb 2021 02:31:23 -0800 (PST)
Received: from dellx1.cphwdc ([87.116.37.42])
        by smtp.googlemail.com with ESMTPSA id c18sm8180512edu.20.2021.02.14.02.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 02:31:23 -0800 (PST)
From:   "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <mb@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
To:     axboe@kernel.dk, m@bjorling.me
Cc:     linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 2/2] lightnvm: pblk: Replace guid_copy() with export_guid()/import_guid()
Date:   Sun, 14 Feb 2021 10:31:03 +0000
Message-Id: <20210214103103.122312-3-matias.bjorling@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210214103103.122312-1-matias.bjorling@wdc.com>
References: <20210214103103.122312-1-matias.bjorling@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is a specific API to treat raw data as GUID, i.e. export_guid()
and import_guid(). Use them instead of guid_copy() with explicit casting.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 drivers/lightnvm/pblk-core.c     | 5 ++---
 drivers/lightnvm/pblk-recovery.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 1dddba11e721..33d39d3dd343 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -988,7 +988,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 	bitmap_set(line->lun_bitmap, 0, lm->lun_bitmap_len);
 
 	smeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
-	guid_copy((guid_t *)&smeta_buf->header.uuid, &pblk->instance_uuid);
+	export_guid(smeta_buf->header.uuid, &pblk->instance_uuid);
 	smeta_buf->header.id = cpu_to_le32(line->id);
 	smeta_buf->header.type = cpu_to_le16(line->type);
 	smeta_buf->header.version_major = SMETA_VERSION_MAJOR;
@@ -1803,8 +1803,7 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 
 	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
 		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
-		guid_copy((guid_t *)&emeta_buf->header.uuid,
-							&pblk->instance_uuid);
+		export_guid(emeta_buf->header.uuid, &pblk->instance_uuid);
 		emeta_buf->header.id = cpu_to_le32(line->id);
 		emeta_buf->header.type = cpu_to_le16(line->type);
 		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 299ef47a17b2..0e6f0c76e930 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -706,8 +706,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 
 		/* The first valid instance uuid is used for initialization */
 		if (!valid_uuid) {
-			guid_copy(&pblk->instance_uuid,
-				  (guid_t *)&smeta_buf->header.uuid);
+			import_guid(&pblk->instance_uuid, smeta_buf->header.uuid);
 			valid_uuid = 1;
 		}
 
-- 
2.25.1

