Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3737C4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937F6233F6
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 16:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgLPQ1P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 11:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbgLPQ1P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 11:27:15 -0500
Date:   Wed, 16 Dec 2020 08:26:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608135994;
        bh=7zZcgrufRU4Ojp16Hwd3RabYlkJfiaRhagRHw0Tmmlk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jf/B9621ajmNSB1mvS7cPVsU3iiFFXYz+ZQOBE32zWbt5FShZqzDm3nCyLFrqzaud
         I1Wuhe7C/9RNimqz5TBNZjC/k4dEV8bLdTEXRtq6/HHiU3oosSmfKdpmkyvUuLKgAq
         Cl3i+qx1oCVNxdFBtLi7Dmjpl100XeCRkXw9F8HxK85wr0Lbmq9Y1aKVwjX9ssVSSC
         TCAmatWoG0c0P7Buf45ojC7DUjYf7up0VgtwIXloOzA2ND56ewkaNuVRpZLnaTXBeo
         5p+RLgSlwPxWHKgaIjfeK9okdfAe+2TJtyOnGYjwxMkwJbNtFuLvKhHfv9yHF5AOYK
         fZXO5N2ZdB0ew==
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, minwoo.im.dev@gmail.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V3] nvme: enable char device per namespace
Message-ID: <20201216162631.GA77639@dhcp-10-100-145-180.wdc.com>
References: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
 <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 16, 2020 at 09:01:51AM +0100, Javier González wrote:
> > On 15 Dec 2020, at 23.46, Keith Busch <kbusch@kernel.org> wrote:
> > ﻿On Tue, Dec 15, 2020 at 08:55:57PM +0100, javier@javigon.com wrote:
> >> +static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
> >> +{
> >> +    char cdisk_name[DISK_NAME_LEN];
> >> +    int ret;
> >> +
> >> +    device_initialize(&ns->cdev_device);
> >> +    ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt),
> >> +                     ns->head->instance);
> > 
> > Ah, I see now. We are making these generic handles for each path, but
> > the ns->head->instance is the same for all paths to a namespace, so it's
> > not unique for that. Further, that head->instance is allocated per
> > subsystem, so it's not unique from namespace heads seen in other
> > subsystems.
> > 
> > So, I think you need to allocate a new dev_t for each subsystem rather
> > than the global nvme_ns_base_chr_devt, and I guess we also need a new
> > nvme_ns instance field assigned from yet another ida?
> 
> Ok. I’ll look into it. 

The suggestion may be overkill as we don't need unique majors for each
controller right now (that may change if people need more than a
million generic handles, but I think we're a ways off from that reality).

The following on top of your patch makes it all work for me. Also, I
don't think we should abort adding the namespace if the generic handle
fails, so that's included here too:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c1aa4bccdeb2..cc9eaf4eba32 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -86,6 +86,8 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
+
+static DEFINE_IDA(nvme_gen_minor_ida);
 static dev_t nvme_ns_base_chr_devt;
 static struct class *nvme_class;
 static struct class *nvme_ns_class;
@@ -539,7 +541,8 @@ static void nvme_free_ns(struct kref *kref)
 
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
-
+	if (ns->minor)
+		ida_simple_remove(&nvme_gen_minor_ida, ns->minor - 1);
 	cdev_device_del(&ns->cdev, &ns->cdev_device);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
@@ -3932,9 +3935,13 @@ static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 	char cdisk_name[DISK_NAME_LEN];
 	int ret;
 
+	ret = ida_simple_get(&nvme_gen_minor_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	ns->minor = ret + 1;
 	device_initialize(&ns->cdev_device);
-	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt),
-				     ns->head->instance);
+	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt), ret);
 	ns->cdev_device.class = nvme_ns_class;
 	ns->cdev_device.parent = ctrl->device;
 	ns->cdev_device.groups = nvme_ns_char_id_attr_groups;
@@ -3945,15 +3952,22 @@ static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 
 	ret = dev_set_name(&ns->cdev_device, "%s", cdisk_name);
 	if (ret)
-		return ret;
+		goto put_ida;
 
 	cdev_init(&ns->cdev, &nvme_cdev_fops);
 	ns->cdev.owner = ctrl->ops->module;
 
 	ret = cdev_device_add(&ns->cdev, &ns->cdev_device);
 	if (ret)
-		kfree_const(ns->cdev_device.kobj.name);
+		goto free_kobj;
+
+	return ret;
 
+free_kobj:
+	kfree_const(ns->cdev_device.kobj.name);
+put_ida:
+	ida_simple_remove(&nvme_gen_minor_ida, ns->minor - 1);
+	ns->minor = 0;
 	return ret;
 }
 
@@ -4023,7 +4037,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
 
 	if (nvme_alloc_chardev_ns(ctrl, ns))
-		goto out_put_disk;
+		dev_warn(ctrl->device,
+			"failed to create generic handle for nsid:%d\n",
+			nsid);
 
 	kfree(id);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 168c7719cda4..ccfd49d2a030 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -435,6 +435,7 @@ struct nvme_ns {
 
 	struct device cdev_device;	/* char device */
 	struct cdev cdev;
+	int minor;
 
 	int lba_shift;
 	u16 ms;
--
