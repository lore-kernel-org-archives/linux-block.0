Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B603CC433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA8D23BAC
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLIIVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgLIIVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 03:21:36 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6976C0613D6
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 00:20:55 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id qw4so809820ejb.12
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 00:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0es42Aa/rvDu/nGYWkHzt0D8sik7Ir6dCcdmicZQ30=;
        b=VVVQ1FiRl/gjQscUtCkjwwp27lRRUtrYr5i3uN+hpS9/aCg4Em3eKFQ8tCJUbzVnUC
         z9Pp6nsrG3NR08oHgpXSBAcOqjheLlvzzZpb/JQZEtW5zvokYM4RVMdT0i5lpJ36LCuy
         iNW0/mbIW9Gpkt4mNsnjzJQpFXY735jgoRq6IT7AW6i7GEernVwzV7iOjWdlMgNazAYQ
         q5pd08q8UVJw0yduADu2qTT2WCtpoevvXO2bTUDBJr/vAeAr2Lu7lDnBuiTGb3z4q2a3
         2dsZRbwoIyanQDfRnfy50gr2iny0u/GgMOWDDsZHfklz1qmZwUjfaMHX+JrNrax9euB2
         dg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0es42Aa/rvDu/nGYWkHzt0D8sik7Ir6dCcdmicZQ30=;
        b=aZCBAwYOo57+zZ92KW1NrU3gO4mZ+LCM/4TtEDMG1/N0XZxan3A/AnjFrbKpYia26R
         gDGubm8TLjirHA2K1bkZ1NuZnH2ffRd2hhFrzwkZKLfiNxC/056zuwkODi3lmYj64IJ/
         pjpL5DGreLlmlJknK0+uToeYhTtn3SdmPy15TA8f93uAz5p3sVSeBGgj/meYN9l0v7ru
         mEd/GhLfds/a2D7LVKr+XrP7wjcp/9TY+zCKdinn3npaDRK7ZNDECmj9sflCBKs/53Fv
         rxnDlzeBZIGJswfwvKa0bc295SkmBgmpFYqfDbLAkfcYnsr8mg1q4HpdNpywdwe/Z7Ex
         Ss7w==
X-Gm-Message-State: AOAM533xodSwjetUII/6gxVDWOkMUM3cIB1ivMzdfWnUjM/bbgAEMPj0
        qvflATKAD70nUr4uXlcS5LzBlMOy70ujHA==
X-Google-Smtp-Source: ABdhPJx1Etru+OzCMNCiuB6rWpCjveRpilZxhtD6r7Ud2IFGI442XjoObaRGYGDR541HmNkblL8uuA==
X-Received: by 2002:a17:906:76cd:: with SMTP id q13mr610934ejn.67.1607502054182;
        Wed, 09 Dec 2020 00:20:54 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id cf17sm823225edb.16.2020.12.09.00.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:20:53 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next 1/7] block/rnbd-clt: Get rid of warning regarding size argument in strlcpy
Date:   Wed,  9 Dec 2020 09:20:45 +0100
Message-Id: <20201209082051.12306-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
References: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

The kernel test robot triggerred the following warning,

>> drivers/block/rnbd/rnbd-clt.c:1397:42: warning: size argument in
'strlcpy' call appears to be size of the source; expected the size of the
destination [-Wstrlcpy-strlcat-size]
	strlcpy(dev->pathname, pathname, strlen(pathname) + 1);
					      ~~~~~~~^~~~~~~~~~~~~

To get rid of the above warning, use a len variable for doing kzalloc and
then strlcpy.

Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index a199b190c73d..62b77b5dc061 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1365,7 +1365,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 				      const char *pathname)
 {
 	struct rnbd_clt_dev *dev;
-	int ret;
+	int len, ret;
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, NUMA_NO_NODE);
 	if (!dev)
@@ -1388,12 +1388,13 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 		goto out_queues;
 	}
 
-	dev->pathname = kzalloc(strlen(pathname) + 1, GFP_KERNEL);
+	len = strlen(pathname) + 1;
+	dev->pathname = kzalloc(len, GFP_KERNEL);
 	if (!dev->pathname) {
 		ret = -ENOMEM;
 		goto out_queues;
 	}
-	strlcpy(dev->pathname, pathname, strlen(pathname) + 1);
+	strlcpy(dev->pathname, pathname, len);
 
 	dev->clt_device_id	= ret;
 	dev->sess		= sess;
-- 
2.25.1

