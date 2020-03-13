Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1147C2BB1D
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 19:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71E9206EB
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 19:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLmZhN2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgCMTnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:43:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40458 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMTnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 15:43:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id n5so8625621qtv.7
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2020 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ggG97PMSFtpsrNjyvM6qaaI0TkTeIbIfJ8gHIBPy3iw=;
        b=QLmZhN2gOWV8dz/BPa0tRXjbumSbMTvYedK+AQNZ6Fzv2rVt1A+FOQygFFQsLMXsid
         9Q9pfiQiwzk2iAx2WWmYVLvfso6sxp33Y7GaYX+je+NCQIHqardDmg0HmaXwmlubMNKK
         e9L3t96sYJTta0EMPhoPVNpRUtopBaw9hoEMDKUVO6N5kCPR8sqzpVQJIkcR+E6tbMSK
         euoPUMtw+YkJsM4PmE4/sxU1Jq+dOJfnYNAIEvhxvKcFv4s5TBU95TeJtawR2q6WJ5nJ
         rThDuPqRHO7gnDMMPNy8v4nT4KRicbl+tCisIOdJ5RnGO2ByweqoZ7jjYPFrSf2pskVX
         RenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ggG97PMSFtpsrNjyvM6qaaI0TkTeIbIfJ8gHIBPy3iw=;
        b=rrAVwsbMYhEncxtZG0fh0RhlikhDTkcGsbOBdOBiGQDpJC+7qjOP732lj8Re4YC+NB
         ZolVKZgHHHfje1oebOPzXN9hprKXvvhAbn3m8hkwXQbqRuN+6OuWl/FRtWrCXFS1ZeBu
         kRhtx02cNCDjRwsuW9EC4qJm1E9tj9MfvmaxLbigiG32g7OYFy/xMG6gdq6QIxopo+u8
         weIZziyHFywDNG2ESMLs0NUxiGQbbohzYO0E9H1u2nRJtg/pEj4U+JWOPefNEA9ggEEy
         1gm/x7B+GNm0Oq51/gdtUWXi8p11LoWIIuQkgdiZbj9nS1NzEn4W8ssmdaNQkPJlb+wk
         Y0Vg==
X-Gm-Message-State: ANhLgQ3JLlPE5DsADatrtqIuwV4Yw8yW966j+dBYPrr52ykbSWAwtJ/m
        tB4yxlHCXnHMhExMAFUkmAs=
X-Google-Smtp-Source: ADFU+vv1uk6zK8YSIzT+gB4C0gde/Msf/gzpVKsXwrz497FmbQqlnf502eYsMctmP/MmvubvnrESiw==
X-Received: by 2002:aed:32e7:: with SMTP id z94mr14163378qtd.382.1584128629191;
        Fri, 13 Mar 2020 12:43:49 -0700 (PDT)
Received: from localhost.localdomain ([129.10.122.21])
        by smtp.gmail.com with ESMTPSA id w30sm6102140qtw.21.2020.03.13.12.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Mar 2020 12:43:48 -0700 (PDT)
From:   Changming Liu <charley.ashbringer@gmail.com>
X-Google-Original-From: Changming Liu <liu.changm@northeastern.edu>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Changming Liu <liu.changm@northeastern.edu>
Subject: [PATCH] block: fix integer overflow in blk_ioctl_discard()
Date:   Fri, 13 Mar 2020 15:43:01 -0400
Message-Id: <1584128581-31058-1-git-send-email-liu.changm@northeastern.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The the sum of two uint64_t integers, start and len, might overflow. This leads to bypassing the check in "start + len > i_size_read(bdev->bd_inode)", and passed to truncate_inode_pages_range() as the 3rd parameter.

To fix this, also in accord with the patch 22dd6d356628bccb1a83e12212ec2934f4444e2c, the sum of these 2 integers are stored in another variable, and compared with start to make sure it will not overflow. Otherwise return -EINVAL properly.

Signed-off-by: Changming Liu <liu.changm@northeastern.edu>
---
 block/ioctl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 127194b..4347d1f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -207,7 +207,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 		unsigned long arg, unsigned long flags)
 {
 	uint64_t range[2];
-	uint64_t start, len;
+	uint64_t start, len, end;
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
 
@@ -223,14 +223,17 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 
 	start = range[0];
 	len = range[1];
+  end = start + len - 1;
 
 	if (start & 511)
 		return -EINVAL;
 	if (len & 511)
 		return -EINVAL;
-
-	if (start + len > i_size_read(bdev->bd_inode))
+	if (end >= (uint64_t)i_size_read(bdev->bd_inode))
 		return -EINVAL;
+  if(end < start)
+    return -EINVAL;
+
 	truncate_inode_pages_range(mapping, start, start + len - 1);
 	return blkdev_issue_discard(bdev, start >> 9, len >> 9,
 				    GFP_KERNEL, flags);
-- 
2.7.4

