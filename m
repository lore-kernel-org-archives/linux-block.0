Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F40C43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 19:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C402082C
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 19:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Gcv611gB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfIETEv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:04:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45195 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfIETEu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Sep 2019 15:04:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id l1so3604913lji.12
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2019 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ghz8a5awHcNUYbavq32aknra433CHICy/d5w0t8s5fw=;
        b=Gcv611gBhSRdQVIlnOcqBamxu+FrYYsHytkFbMpfJVIa0MiWQDMPxs9ATkD5SOzpfD
         yZ4mk+7E6tgxNYyGA/foAKtDnpxhFSEPVzRzXo0FcfGfdZwu7/wEzUucld+luerLkDuv
         Jiaqu3mnRs0pL8F46lN12K5dPmbPmx//TZASOT45a1oT0VSP2M6O2Rp6brgKhPMlFCQW
         LJfDWXxtq2QMF+WDznqh++CGOGKyqNt3hbjE727jTFiAoeEB4ETtWalcZTT0qO45e7BX
         a/IMgZOSIfmheRPwV2khyQ38BksnYO/EyI8n7GdEzMiLMPMtKuySs+JmSDyxE8bZe+uE
         JIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ghz8a5awHcNUYbavq32aknra433CHICy/d5w0t8s5fw=;
        b=fuhGOlEUVy6bMnu5zQg34QL0Va1c5rJVk2/cUKuL7T771XPUfFBFolcLfzRYAa1Uxi
         NJHrwHNH170Fs8AFZWJJ7uqKh14uW18LzPd7lKyoYsozYe62JRrlVDWJmN0jUnZlnclo
         EUHqPCxosVKKBSZQLOb6ljkdEMgHwOIGPKdWw+DIOzq79gogF4gxOV02MKH9/FAYEonI
         NaPLvdDAV/vmyqUxWXG+jt70Vre3gka1iPVE+byZnTn6bd5t3t6vqCHTu1SVU2/9ADJD
         UexEbv7+Tktzgi3Sh2gi3ZEsWmeFEj+PcwosO/ZmQqkpfEdZ2cdgoh6bpt+HV2YGH6RD
         mdOg==
X-Gm-Message-State: APjAAAWD6OL43fgEMZKkZYFIBctUh6epJQ7zoCjOCBvAHyvPB20uo+2A
        q2qLFqic/B94emJ9bg75GCp90g==
X-Google-Smtp-Source: APXvYqyAHww6tttUo5oP2t/0Nab17bsEGc33iKLwrv5UrUPgwsodWfvvAm7il81nMHoeZaeAxBFGyQ==
X-Received: by 2002:a2e:42c9:: with SMTP id h70mr3120031ljf.88.1567710287452;
        Thu, 05 Sep 2019 12:04:47 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id 6sm599037ljr.63.2019.09.05.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 12:04:46 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 1/2] lightnvm: introduce pr_fmt for the prefix nvm
Date:   Thu,  5 Sep 2019 21:04:32 +0200
Message-Id: <20190905190433.8247-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190905190433.8247-1-mb@lightnvm.io>
References: <20190905190433.8247-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Minwoo Im <minwoo.im.dev@gmail.com>

all the pr_() family can have this prefix by pr_fmt.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c | 49 +++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 3cd03582a2ed..f88d4e57cff8 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -4,6 +4,8 @@
  * Initial release: Matias Bjorling <m@bjorling.me>
  */
 
+#define pr_fmt(fmt) "nvm: " fmt
+
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/sem.h>
@@ -74,7 +76,7 @@ static int nvm_reserve_luns(struct nvm_dev *dev, int lun_begin, int lun_end)
 
 	for (i = lun_begin; i <= lun_end; i++) {
 		if (test_and_set_bit(i, dev->lun_map)) {
-			pr_err("nvm: lun %d already allocated\n", i);
+			pr_err("lun %d already allocated\n", i);
 			goto err;
 		}
 	}
@@ -264,7 +266,7 @@ static int nvm_config_check_luns(struct nvm_geo *geo, int lun_begin,
 				 int lun_end)
 {
 	if (lun_begin > lun_end || lun_end >= geo->all_luns) {
-		pr_err("nvm: lun out of bound (%u:%u > %u)\n",
+		pr_err("lun out of bound (%u:%u > %u)\n",
 			lun_begin, lun_end, geo->all_luns - 1);
 		return -EINVAL;
 	}
@@ -297,7 +299,7 @@ static int __nvm_config_extended(struct nvm_dev *dev,
 	if (e->op == 0xFFFF) {
 		e->op = NVM_TARGET_DEFAULT_OP;
 	} else if (e->op < NVM_TARGET_MIN_OP || e->op > NVM_TARGET_MAX_OP) {
-		pr_err("nvm: invalid over provisioning value\n");
+		pr_err("invalid over provisioning value\n");
 		return -EINVAL;
 	}
 
@@ -334,23 +336,23 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		e = create->conf.e;
 		break;
 	default:
-		pr_err("nvm: config type not valid\n");
+		pr_err("config type not valid\n");
 		return -EINVAL;
 	}
 
 	tt = nvm_find_target_type(create->tgttype);
 	if (!tt) {
-		pr_err("nvm: target type %s not found\n", create->tgttype);
+		pr_err("target type %s not found\n", create->tgttype);
 		return -EINVAL;
 	}
 
 	if ((tt->flags & NVM_TGT_F_HOST_L2P) != (dev->geo.dom & NVM_RSP_L2P)) {
-		pr_err("nvm: device is incompatible with target L2P type.\n");
+		pr_err("device is incompatible with target L2P type.\n");
 		return -EINVAL;
 	}
 
 	if (nvm_target_exists(create->tgtname)) {
-		pr_err("nvm: target name already exists (%s)\n",
+		pr_err("target name already exists (%s)\n",
 							create->tgtname);
 		return -EINVAL;
 	}
@@ -367,7 +369,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 
 	tgt_dev = nvm_create_tgt_dev(dev, e.lun_begin, e.lun_end, e.op);
 	if (!tgt_dev) {
-		pr_err("nvm: could not create target device\n");
+		pr_err("could not create target device\n");
 		ret = -ENOMEM;
 		goto err_t;
 	}
@@ -686,7 +688,7 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
 	rqd->nr_ppas = nr_ppas;
 	rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
 	if (!rqd->ppa_list) {
-		pr_err("nvm: failed to allocate dma memory\n");
+		pr_err("failed to allocate dma memory\n");
 		return -ENOMEM;
 	}
 
@@ -1073,7 +1075,7 @@ int nvm_set_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 		return 0;
 
 	if (nr_ppas > NVM_MAX_VLBA) {
-		pr_err("nvm: unable to update all blocks atomically\n");
+		pr_err("unable to update all blocks atomically\n");
 		return -EINVAL;
 	}
 
@@ -1136,27 +1138,26 @@ static int nvm_init(struct nvm_dev *dev)
 	int ret = -EINVAL;
 
 	if (dev->ops->identity(dev)) {
-		pr_err("nvm: device could not be identified\n");
+		pr_err("device could not be identified\n");
 		goto err;
 	}
 
-	pr_debug("nvm: ver:%u.%u nvm_vendor:%x\n",
-				geo->major_ver_id, geo->minor_ver_id,
-				geo->vmnt);
+	pr_debug("ver:%u.%u nvm_vendor:%x\n", geo->major_ver_id,
+			geo->minor_ver_id, geo->vmnt);
 
 	ret = nvm_core_init(dev);
 	if (ret) {
-		pr_err("nvm: could not initialize core structures.\n");
+		pr_err("could not initialize core structures.\n");
 		goto err;
 	}
 
-	pr_info("nvm: registered %s [%u/%u/%u/%u/%u]\n",
+	pr_info("registered %s [%u/%u/%u/%u/%u]\n",
 			dev->name, dev->geo.ws_min, dev->geo.ws_opt,
 			dev->geo.num_chk, dev->geo.all_luns,
 			dev->geo.num_ch);
 	return 0;
 err:
-	pr_err("nvm: failed to initialize nvm\n");
+	pr_err("failed to initialize nvm\n");
 	return ret;
 }
 
@@ -1194,7 +1195,7 @@ int nvm_register(struct nvm_dev *dev)
 	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist",
 						  exp_pool_size);
 	if (!dev->dma_pool) {
-		pr_err("nvm: could not create dma pool\n");
+		pr_err("could not create dma pool\n");
 		kref_put(&dev->ref, nvm_free);
 		return -ENOMEM;
 	}
@@ -1239,7 +1240,7 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 	up_write(&nvm_lock);
 
 	if (!dev) {
-		pr_err("nvm: device not found\n");
+		pr_err("device not found\n");
 		return -EINVAL;
 	}
 
@@ -1313,7 +1314,7 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
 		i++;
 
 		if (i > 31) {
-			pr_err("nvm: max 31 devices can be reported.\n");
+			pr_err("max 31 devices can be reported.\n");
 			break;
 		}
 	}
@@ -1340,7 +1341,7 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 
 	if (create.conf.type == NVM_CONFIG_TYPE_EXTENDED &&
 	    create.conf.e.rsv != 0) {
-		pr_err("nvm: reserved config field in use\n");
+		pr_err("reserved config field in use\n");
 		return -EINVAL;
 	}
 
@@ -1356,7 +1357,7 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 			flags &= ~NVM_TARGET_FACTORY;
 
 		if (flags) {
-			pr_err("nvm: flag not supported\n");
+			pr_err("flag not supported\n");
 			return -EINVAL;
 		}
 	}
@@ -1374,7 +1375,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 	remove.tgtname[DISK_NAME_LEN - 1] = '\0';
 
 	if (remove.flags != 0) {
-		pr_err("nvm: no flags supported\n");
+		pr_err("no flags supported\n");
 		return -EINVAL;
 	}
 
@@ -1390,7 +1391,7 @@ static long nvm_ioctl_dev_init(struct file *file, void __user *arg)
 		return -EFAULT;
 
 	if (init.flags != 0) {
-		pr_err("nvm: no flags supported\n");
+		pr_err("no flags supported\n");
 		return -EINVAL;
 	}
 
-- 
2.19.1

