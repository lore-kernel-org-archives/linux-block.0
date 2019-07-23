Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1178DC76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 18:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D535921841
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 18:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck/sNN5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391457AbfGWSn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:43:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40866 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfGWSn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 14:43:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so19567749pfp.7;
        Tue, 23 Jul 2019 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuBq2ea9RAnOcCp/a/6zA6IGtHEy600UrSm5Gali8kE=;
        b=Ck/sNN5zztaTkCVnWcWUKBEA3MUfxkhyrQh5pCzkvhVtoahE7756iKQbQ0Zevd0bOP
         jzHXscsR0DabCPswgdIRwLrp+dXX+MX2kO5PJNsy/pKJ+5yhodp5C/MSbwtWnzduWBpQ
         1usP+L0nOJUjKHywbQkjXODzweYYdDD1MrkFbrMk0Q1H+mlG1k/EDM+B9GkVsY+lW4Us
         ATIN2j1g1Zi32bKtelyPvrEYavE93gsmklSWtkMVNCEN3Tf3u88iZNkyXENmjJ7k64p+
         CqJ+vG2T0rr8BbAxg27p9+HFiMGYZTAzr7CN6f5fGgeaHHQxsT+YxpDDEW5+9/yQ4Qmq
         GI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuBq2ea9RAnOcCp/a/6zA6IGtHEy600UrSm5Gali8kE=;
        b=T2H+39ku+NLUu08cVVv7rFPD9UBcquePhnRKLCuoACnzgDLYztSYJnOt9CsAyk1xXz
         fGNrI/4TX0+HIJtG/w5v8dMYI8NOWbRfoH5NMQZHYYdw9HhiQByCVEB+sazaF0R05CNg
         /1ZytQFwdl0wnT6SVIWSZkSP8UoFbRKHrv7omfmVv+8ZeMyux61u4oA5N7WnELIBm1AE
         TyLovmLUHjIU7xV0kqk7IYeKzzvqVmnUkKBjrk/ByE9LUH2W1KVmFSns3tilk3ncBM/Y
         i56ThARNDVcT8yVFy/8GZftzduY7r3L6IytS0wz2f+uvVzbVuZtxqyLgPDEWMqgt0Ja1
         4Tgw==
X-Gm-Message-State: APjAAAWqRf8ApfRAocARJ0dvXfnzdauPo4aNfm+AmC/z2t6Vhck++T1v
        rSNRmYnvN3MZOScembewb7OBI+Ssw5Y=
X-Google-Smtp-Source: APXvYqwEftuarkE0r5rFmsqps1YVeYIPYpPuuOvaYE3jXVvqivdCUfbJK8yEAcpV9PkGNCW7DgWjTQ==
X-Received: by 2002:a63:f750:: with SMTP id f16mr47824276pgk.317.1563907407653;
        Tue, 23 Jul 2019 11:43:27 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id b190sm33891056pga.37.2019.07.23.11.43.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 11:43:26 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Klaus Birkelund Jensen <birkelund@gmail.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V3] lightnvm: introduce pr_fmt for the prefix nvm
Date:   Wed, 24 Jul 2019 03:43:19 +0900
Message-Id: <20190723184319.4427-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

all the pr_() family can have this prefix by pr_fmt.

Changes to V1:
  - Squashed multiple lines to make it short (Chaitanya)

Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Javier González <javier@javigon.com>
---
 drivers/lightnvm/core.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index a600934fdd9c..4c7b48f72e80 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -4,6 +4,7 @@
  * Initial release: Matias Bjorling <m@bjorling.me>
  */
 
+#define pr_fmt(fmt) "nvm: " fmt
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/sem.h>
@@ -74,7 +75,7 @@ static int nvm_reserve_luns(struct nvm_dev *dev, int lun_begin, int lun_end)
 
 	for (i = lun_begin; i <= lun_end; i++) {
 		if (test_and_set_bit(i, dev->lun_map)) {
-			pr_err("nvm: lun %d already allocated\n", i);
+			pr_err("lun %d already allocated\n", i);
 			goto err;
 		}
 	}
@@ -264,7 +265,7 @@ static int nvm_config_check_luns(struct nvm_geo *geo, int lun_begin,
 				 int lun_end)
 {
 	if (lun_begin > lun_end || lun_end >= geo->all_luns) {
-		pr_err("nvm: lun out of bound (%u:%u > %u)\n",
+		pr_err("lun out of bound (%u:%u > %u)\n",
 			lun_begin, lun_end, geo->all_luns - 1);
 		return -EINVAL;
 	}
@@ -297,7 +298,7 @@ static int __nvm_config_extended(struct nvm_dev *dev,
 	if (e->op == 0xFFFF) {
 		e->op = NVM_TARGET_DEFAULT_OP;
 	} else if (e->op < NVM_TARGET_MIN_OP || e->op > NVM_TARGET_MAX_OP) {
-		pr_err("nvm: invalid over provisioning value\n");
+		pr_err("invalid over provisioning value\n");
 		return -EINVAL;
 	}
 
@@ -334,23 +335,23 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
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
@@ -367,7 +368,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 
 	tgt_dev = nvm_create_tgt_dev(dev, e.lun_begin, e.lun_end, e.op);
 	if (!tgt_dev) {
-		pr_err("nvm: could not create target device\n");
+		pr_err("could not create target device\n");
 		ret = -ENOMEM;
 		goto err_t;
 	}
@@ -686,7 +687,7 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
 	rqd->nr_ppas = nr_ppas;
 	rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
 	if (!rqd->ppa_list) {
-		pr_err("nvm: failed to allocate dma memory\n");
+		pr_err("failed to allocate dma memory\n");
 		return -ENOMEM;
 	}
 
@@ -1048,7 +1049,7 @@ int nvm_set_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 		return 0;
 
 	if (nr_ppas > NVM_MAX_VLBA) {
-		pr_err("nvm: unable to update all blocks atomically\n");
+		pr_err("unable to update all blocks atomically\n");
 		return -EINVAL;
 	}
 
@@ -1111,27 +1112,26 @@ static int nvm_init(struct nvm_dev *dev)
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
 
@@ -1169,7 +1169,7 @@ int nvm_register(struct nvm_dev *dev)
 	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist",
 						  exp_pool_size);
 	if (!dev->dma_pool) {
-		pr_err("nvm: could not create dma pool\n");
+		pr_err("could not create dma pool\n");
 		kref_put(&dev->ref, nvm_free);
 		return -ENOMEM;
 	}
@@ -1214,7 +1214,7 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 	up_write(&nvm_lock);
 
 	if (!dev) {
-		pr_err("nvm: device not found\n");
+		pr_err("device not found\n");
 		return -EINVAL;
 	}
 
@@ -1288,7 +1288,7 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
 		i++;
 
 		if (i > 31) {
-			pr_err("nvm: max 31 devices can be reported.\n");
+			pr_err("max 31 devices can be reported.\n");
 			break;
 		}
 	}
@@ -1315,7 +1315,7 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 
 	if (create.conf.type == NVM_CONFIG_TYPE_EXTENDED &&
 	    create.conf.e.rsv != 0) {
-		pr_err("nvm: reserved config field in use\n");
+		pr_err("reserved config field in use\n");
 		return -EINVAL;
 	}
 
@@ -1331,7 +1331,7 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 			flags &= ~NVM_TARGET_FACTORY;
 
 		if (flags) {
-			pr_err("nvm: flag not supported\n");
+			pr_err("flag not supported\n");
 			return -EINVAL;
 		}
 	}
@@ -1349,7 +1349,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 	remove.tgtname[DISK_NAME_LEN - 1] = '\0';
 
 	if (remove.flags != 0) {
-		pr_err("nvm: no flags supported\n");
+		pr_err("no flags supported\n");
 		return -EINVAL;
 	}
 
@@ -1365,7 +1365,7 @@ static long nvm_ioctl_dev_init(struct file *file, void __user *arg)
 		return -EFAULT;
 
 	if (init.flags != 0) {
-		pr_err("nvm: no flags supported\n");
+		pr_err("no flags supported\n");
 		return -EINVAL;
 	}
 
-- 
2.17.1

