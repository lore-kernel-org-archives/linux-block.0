Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA2C4708C
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 22:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B4A613E3
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 22:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhE1Wed (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 18:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhE1Wed (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 18:34:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FBEC061574;
        Fri, 28 May 2021 15:32:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a5so7522142lfm.0;
        Fri, 28 May 2021 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yKC7wbzMjkUdXdUvQOdmRx8muC6k4+GVXbecAt/sIDI=;
        b=Rd/SkuiY6LaPNwYcLbNJ1Y0pdoBIAnZcZuTBHL5WDfDFoL3GlNrN+mJfoEyOnmFbQW
         L0I0Ou19Xg5slw2xnjxNJ4FixUNifgwXfr0cmngDWflRhK7x2yPSAV5hCm4+XwfMAiJJ
         5BIQ6afNFM3olW15gIc8B1rc2ssEX971EhrA+SmurxYNiscT7rMb5zXx31dy8ywjFeW/
         to7FJwI2GcoLBU6zseMhOZWzJw4dD0SCntIhaaoOQzsf07YpNELnAJZTFS2iTrzVD4Fz
         p1RWpCN18E/UmVNzLP6eZClXoASZ4LjntQv4YO+QW0D8yNvc2C3ydWCdnrgA/AlM3HvG
         wi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yKC7wbzMjkUdXdUvQOdmRx8muC6k4+GVXbecAt/sIDI=;
        b=EkM3s61x0qa+K35yLc5pcdaven1nLtDVdhexge23OMkr/7L9oYHJq7EF/x2SRvFoA8
         riPb1czFYvdalV1KR5pkJAXQFNIV34Ul4Rn3sHC1vOqxqDTJtmORKDeukr0YScwjPr49
         6L+uWjczC9MeQcaWEfaSPh3mFJiVlmByuSJzmcjuQ4FOWOt+R+eJOx+lWcQG3uVB7qOH
         yZkfHiDD17fka1aTwmv0m16xpDD+2Qi2c9S2wsDd5hO1Jhnw04a2kJsClDajtWFwL506
         JwL6x7UUgpRe6AnqL02MQ0Fb7iPqmk4pfAdGXkfeddkPb5QZKRZO9xnhRH0QRB6UJOkI
         jqHQ==
X-Gm-Message-State: AOAM530y+VwyVRhu/r2njKQuCy5vvOf51uvWp3krCssQFm/0akLBVzWs
        bjRZ8IF2VYrOE59FwoMImU0=
X-Google-Smtp-Source: ABdhPJxGpGYMAGOdDQrj4PMP8gtGEmTDS8bBRi5adUIgPHqdrw/jh1XmezPbgEEDGodxS+BIb8fieg==
X-Received: by 2002:a05:6512:3a81:: with SMTP id q1mr6868948lfu.383.1622241175356;
        Fri, 28 May 2021 15:32:55 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id j26sm682810ljg.76.2021.05.28.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 15:32:54 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] block: Constify static attribute_group structs
Date:   Sat, 29 May 2021 00:32:52 +0200
Message-Id: <20210528223252.29343-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Either their address is put in an array of pointers to const attribute
groups structs, or the address is passed to sysfs_create_group() which
accepts a pointer to const struct attribute group. Make them const to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 block/blk-sysfs.c       | 2 +-
 block/genhd.c           | 2 +-
 block/partitions/core.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f89e2fc3963b..5c5d21b7d278 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -698,7 +698,7 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
 	return attr->mode;
 }
 
-static struct attribute_group queue_attr_group = {
+static const struct attribute_group queue_attr_group = {
 	.attrs = queue_attrs,
 	.is_visible = queue_attr_visible,
 };
diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..0f85687a7c69 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1090,7 +1090,7 @@ static umode_t disk_visible(struct kobject *kobj, struct attribute *a, int n)
 	return a->mode;
 }
 
-static struct attribute_group disk_attr_group = {
+static const struct attribute_group disk_attr_group = {
 	.attrs = disk_attrs,
 	.is_visible = disk_visible,
 };
diff --git a/block/partitions/core.c b/block/partitions/core.c
index dc60ecf46fe6..8c3237f11261 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -246,7 +246,7 @@ static struct attribute *part_attrs[] = {
 	NULL
 };
 
-static struct attribute_group part_attr_group = {
+static const struct attribute_group part_attr_group = {
 	.attrs = part_attrs,
 };
 
-- 
2.31.1

