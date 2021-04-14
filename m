Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8984C43461
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C996117A
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhDNMYg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhDNMYf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EDC06138C
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so31147374ejc.4
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/i9IowC0wtrivcjsB/Fsbsb8BNaaM8Yaedx4yrKH5I=;
        b=bZwhGcr4kHd2BS7ckqSseh2C03Fx30n4lYW9ZLHyT7SrtqTe+1A9a0YNmsyretC2L8
         e4cdTIo7Uf//2Y1Iie/GQHMZgDKF+MkW59SbOcpx89An89vz66WNCYM9kPcRUzdKLNHm
         3yw+++4wwO+nqpiagbva+CYwkUK9Q6oSMRotZrbrESyJxNRQoSZOVGhxPs4wA2hUj3x0
         NoVIbDUPMhZ0oDBXO68wpsdit3Tnwd2YgLZN7xKla4xT953qrZ2hCx8tVCMIT57G2RGX
         NGIPRn5goRMRNnhR3BR6hBNTmR8HYDsJjJAU4lVSuyGNenOcFUE6/NJPtFz3e0Jco/1Q
         N1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/i9IowC0wtrivcjsB/Fsbsb8BNaaM8Yaedx4yrKH5I=;
        b=Tcll4pTbwMRqyluLlqSptjX+jZKSSGaHS43nojCyL3H/E9GocC/wa3jld+YzaOp8zz
         nLficyd+YNJy4dTFs0gavNUuJTQHB2A1vjUegKwsATihjAb5JnLbpfQOiMK1NbSa215e
         y3ksqQuinGKrI73OkkaoLxVB0l3fKIE051YsUwlbH+NTVNjYueRn5dWlS7PzAdHkMczX
         GnZ6hcTaVFs/Odl0MPBfhSovn5qXGfAm4cSdVejzldRwTdOfDf9/YM7roalHRUtYqLAr
         VXnmZ5bfEmJadZJ6Iq+HndetMKZFA0oe29dzNmTF/hhXfjI+v73KOu6ALfvjxU/nKpO7
         aPWw==
X-Gm-Message-State: AOAM5328sTR14G2U6PK5KuwJVtVQNFYw6UH3aetrvAkeNVjLeiTcxce5
        mgg5fqH2s76RvwRABEg+ttL0LD9sVNeJHRWe
X-Google-Smtp-Source: ABdhPJzsFbv7wkhBPV6uO2w+UtS5uAOMI6ZjEUh93XtwdYCsOpNHJPt5olvwRMwtj+ZO3b4E/8F2xw==
X-Received: by 2002:a17:906:a385:: with SMTP id k5mr5452898ejz.148.1618403051759;
        Wed, 14 Apr 2021 05:24:11 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:11 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCHv4 for-next 03/19] block/rnbd-clt: Remove some arguments from insert_dev_if_not_exists_devpath
Date:   Wed, 14 Apr 2021 14:23:46 +0200
Message-Id: <20210414122402.203388-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@gmx.com>

Remove 'pathname' and 'sess' since we can dereference it from 'dev'.

Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/rnbd/rnbd-clt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 45a470076652..5a5c8dea38dc 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1471,14 +1471,13 @@ static bool exists_devpath(const char *pathname, const char *sessname)
 	return found;
 }
 
-static bool insert_dev_if_not_exists_devpath(const char *pathname,
-					     struct rnbd_clt_session *sess,
-					     struct rnbd_clt_dev *dev)
+static bool insert_dev_if_not_exists_devpath(struct rnbd_clt_dev *dev)
 {
 	bool found;
+	struct rnbd_clt_session *sess = dev->sess;
 
 	mutex_lock(&sess_lock);
-	found = __exists_dev(pathname, sess->sessname);
+	found = __exists_dev(dev->pathname, sess->sessname);
 	if (!found) {
 		mutex_lock(&sess->lock);
 		list_add_tail(&dev->list, &sess->devs_list);
@@ -1522,7 +1521,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		ret = PTR_ERR(dev);
 		goto put_sess;
 	}
-	if (insert_dev_if_not_exists_devpath(pathname, sess, dev)) {
+	if (insert_dev_if_not_exists_devpath(dev)) {
 		ret = -EEXIST;
 		goto put_dev;
 	}
-- 
2.25.1

