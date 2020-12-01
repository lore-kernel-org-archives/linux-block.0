Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E31C83012
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC4E2084C
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="hcf1XlC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbgLAM5H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388743AbgLAM5G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 07:57:06 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD66C0613D4
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 04:56:18 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id c7so3060215edv.6
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 04:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDAJFTOJhz1IwZLtoSRx6PSuhtJlEvB7uRt7tHupXWY=;
        b=hcf1XlC2Q9J2qkWqVwiakA1iMAhjDc9uSsCZ3bmbKuagTYvoBjnQ8875DsRtTCOQ9T
         f6twovBHO4htj29liM9pKjbvE5hHEb3+It0TJKMqUWLmKUBDHq++SROR/zPEMc7RRHVI
         UpH4Nn+79mo9fXgY1VZWq4jdQu+yyJEYhDkCw8kn7AvTf/g7s4lQc3SSYNyHixuRxgJ0
         ir687mQTmgvrcWu7EvRzT7E1iS5VDDuQKg0TxfD5QlgEb/HFx/AWxRgknfWVe3+LlB7Q
         JZM6dc2e60Iwa4sj3K0uPnRoLzHtpMESZE/gUxZbzXwLs27Ywgtiha4fdWUgfbsNjW/j
         TA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDAJFTOJhz1IwZLtoSRx6PSuhtJlEvB7uRt7tHupXWY=;
        b=EgvBHrhXN4XQG4mPat5D7mWBKqNlPDo0ee2630H8XZ8MUlEasf6cKwqtqhlep2w+N5
         idU6uVebrE1+x0xALwvWflee5gY0zF1EMzQlvy+kEC+mSEMiNJTXlECiaCSE+MHsVHzF
         L6Y+0eJwV9nXWQj7uxZufCv4TclsCycGrcgpDF2PKk3lANgCztH9JTci4JRO8hdsgR/A
         XCtXUzaQEGHr1S5bdG0bwfYI2mJbzGpfxJfyWDmj29+UV0lDtuCN9uiesBrPE5xEXsId
         SmwPX19uU96TOfRQc2rKVU2RBZHe0YUpFwrMfax2CTTGH2Ym3nWghpYT1UfW4GeBry+I
         TK2A==
X-Gm-Message-State: AOAM5319RMvNt5nQcZcDBg0yq5uZEZbRNLG/gBWQIoAkaZ+KmiBcxh0W
        eTnxNo5VB7Sm7Z3fj1uwLFaeAw==
X-Google-Smtp-Source: ABdhPJzfLiUXsNDBawvEvhjO//SROUMUE3ztr/pyCDHEPwn/uzLjsAu6wF5TY2bt2LcD1BePUA+/mA==
X-Received: by 2002:aa7:db56:: with SMTP id n22mr2991040edt.4.1606827377397;
        Tue, 01 Dec 2020 04:56:17 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id be6sm796864edb.29.2020.12.01.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:56:16 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 3/4] nvme: rename bdev operations
Date:   Tue,  1 Dec 2020 13:56:09 +0100
Message-Id: <20201201125610.17138-4-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201125610.17138-1-javier.gonz@samsung.com>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Remane block device operations in preparation to add char device file
operations.

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c23c891a8fb8..2c23ea6dc296 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2292,7 +2292,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
 
-static const struct block_device_operations nvme_fops = {
+static const struct block_device_operations nvme_bdev_ops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
 	.compat_ioctl	= nvme_compat_ioctl,
@@ -3301,7 +3301,7 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	if (disk->fops == &nvme_fops)
+	if (disk->fops == &nvme_bdev_ops)
 		return nvme_get_ns_from_dev(dev)->head;
 	else
 		return disk->private_data;
@@ -3410,7 +3410,7 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 	}
 #ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
-		if (dev_to_disk(dev)->fops != &nvme_fops) /* per-path attr */
+		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
 			return 0;
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
@@ -3863,7 +3863,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!disk)
 		goto out_unlink_ns;
 
-	disk->fops = &nvme_fops;
+	disk->fops = &nvme_bdev_ops;
 	disk->private_data = ns;
 	disk->queue = ns->queue;
 	disk->flags = flags;
-- 
2.17.1

