Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9426DC433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 06:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EAE66135A
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 06:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhJUGwF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 02:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhJUGwF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 02:52:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0492CC06161C;
        Wed, 20 Oct 2021 23:49:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m26so5039273pff.3;
        Wed, 20 Oct 2021 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3X0dKfWSn9dYzauSZ0s7ivgfJeIM+vlPe/JZZITA/tI=;
        b=V3nSIDq0YrKPom6oM4hfOq+8vLtJgLMGD/nE/IhmWuP/UKoAzJEsfI/mxxPQtco9Xr
         qP7PZNT70XHhfA0sxL7ilajqlQjbr41+tPjLz/VRot+mVmZJ/UTMSi1D7EEdK0iporpB
         V4Ryr4k4XCJCqOs3qbzax9VAQU5Mn3Mo2iy/EHYds9058nvYvkphgNqpiZkPxgOaezGF
         K927QLM4vQ67fzMFTyZ26hPA6QL8brnUjqLq8klnaUBX6G2yCPILl/GDDCXbYsFqIyo4
         ltSSUjm9UWzL+eCUnrIBqMktCG3zZ3ExEdkcvxtWn9GArnETRZoKJ606C24+x48FXeR4
         Yz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3X0dKfWSn9dYzauSZ0s7ivgfJeIM+vlPe/JZZITA/tI=;
        b=sMPKD+GWDRihp1o2BbKWnwDVR3ndmgfiusJIbaqPjfIoO7up5JT1/WLxkfUVvkC5cW
         1fbxaPy0WW18ik22tJGalrYcZpxPFx8F2A4Wp9+FkPWZQm7DueonAp+q2CMI2rpZ9y5l
         3S8VKqY02r8VVw14N+NeST7989p99jaEP8GYFZh3NrdZx+ssBB/9mtaOpk9bq8Rc57FT
         SemjOL2XXeuoSQ4xLtS53DzcbLq3lbE9l+drP/afuj1BZIa/A8zkgSSPWYSWoSmGwn2n
         ujENgoSif/uoDqOx877YxgzIaN7Y8gyP8RlSCtRBbfvfpCG6VaXD4Q0eSmJQAWQQuLtH
         OlFA==
X-Gm-Message-State: AOAM532NP+Ztc/kJDOHgU4MDNUAzkRrfJp8ZFKPyGNYk4O4SYXbdRXpu
        7kWA/QW/7Sk+cGVZcj/Cb6Y=
X-Google-Smtp-Source: ABdhPJztXgcRuEj6wqThjniZsB3Li96kLWtJLjHR1o28wXfbHXkrK+6lxc+IbEP9dkOHDNipVijj3w==
X-Received: by 2002:aa7:9735:0:b0:44c:619f:29fc with SMTP id k21-20020aa79735000000b0044c619f29fcmr3990325pfg.79.1634798989570;
        Wed, 20 Oct 2021 23:49:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d138sm4641130pfd.74.2021.10.20.23.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 23:49:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     justin@coraid.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] block: aoe: fixup coccinelle warnings
Date:   Thu, 21 Oct 2021 06:49:31 +0000
Message-Id: <20211021064931.1047687-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/block/aoe/aoeblk.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index e436b0e8eff5..52484bcdedb9 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -37,8 +37,7 @@ static ssize_t aoedisk_show_state(struct device *dev,
 	struct gendisk *disk = dev_to_disk(dev);
 	struct aoedev *d = disk->private_data;
 
-	return snprintf(page, PAGE_SIZE,
-			"%s%s\n",
+	return sysfs_emit(page, "%s%s\n",
 			(d->flags & DEVFL_UP) ? "up" : "down",
 			(d->flags & DEVFL_KICKME) ? ",kickme" :
 			(d->nopen && !(d->flags & DEVFL_UP)) ? ",closewait" : "");
@@ -52,8 +51,8 @@ static ssize_t aoedisk_show_mac(struct device *dev,
 	struct aoetgt *t = d->targets[0];
 
 	if (t == NULL)
-		return snprintf(page, PAGE_SIZE, "none\n");
-	return snprintf(page, PAGE_SIZE, "%pm\n", t->addr);
+		return sysfs_emit(page, "none\n");
+	return sysfs_emit(page, "%pm\n", t->addr);
 }
 static ssize_t aoedisk_show_netif(struct device *dev,
 				  struct device_attribute *attr, char *page)
@@ -85,7 +84,7 @@ static ssize_t aoedisk_show_netif(struct device *dev,
 	ne = nd;
 	nd = nds;
 	if (*nd == NULL)
-		return snprintf(page, PAGE_SIZE, "none\n");
+		return sysfs_emit(page, "none\n");
 	for (p = page; nd < ne; nd++)
 		p += scnprintf(p, PAGE_SIZE - (p-page), "%s%s",
 			p == page ? "" : ",", (*nd)->name);
@@ -99,7 +98,7 @@ static ssize_t aoedisk_show_fwver(struct device *dev,
 	struct gendisk *disk = dev_to_disk(dev);
 	struct aoedev *d = disk->private_data;
 
-	return snprintf(page, PAGE_SIZE, "0x%04x\n", (unsigned int) d->fw_ver);
+	return sysfs_emit(page, "0x%04x\n", (unsigned int) d->fw_ver);
 }
 static ssize_t aoedisk_show_payload(struct device *dev,
 				    struct device_attribute *attr, char *page)
@@ -107,7 +106,7 @@ static ssize_t aoedisk_show_payload(struct device *dev,
 	struct gendisk *disk = dev_to_disk(dev);
 	struct aoedev *d = disk->private_data;
 
-	return snprintf(page, PAGE_SIZE, "%lu\n", d->maxbcnt);
+	return sysfs_emit(page, "%lu\n", d->maxbcnt);
 }
 
 static int aoedisk_debugfs_show(struct seq_file *s, void *ignored)
-- 
2.25.1

