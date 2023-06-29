Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847D2EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 15:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjF2PdI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjF2PdH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 11:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCC619BA
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 08:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0259961565
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 15:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E6AC433C8;
        Thu, 29 Jun 2023 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688052785;
        bh=JAOQciLQ0szOhPpPcsL2LZJ7ZBFQgl6kxwuoUxXKODw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCe+MAn+K850Kg45WNmU3Bb4ngVl2NX5lQ5woQGxW7qsby9lfLC4fm4u9lFDZyq7Z
         0zISOpACaScIwYsMgJTntiKsxBmYp10XY015S1m4dKrphi9J9qzYF2AqC2W6UCE36C
         gCOSlelBLzu8595D40tTTiGTWtZ4bsdYaGDCkWUBlTxtG1OW198Q5KDMqiz0lzXXzJ
         GjNWJaU3SMMDFaWGVNgpQ+0mZ0iYb0Z1svMd+095QkuA/FLGfMX19Fv9IBr12d10IF
         e0U8CXv4R9ph6KBD77dhE4B1CYO+DAOSIXD8o2djAc8l+kohL5fEJh3hUbaUHmunzg
         aOy2iDBpZQcqg==
Date:   Thu, 29 Jun 2023 09:33:02 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJ2kLiWoC+4hkSKG@kbusch-mbp>
References: <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
 <ZJuNKGy5dXPC6i+H@ovpn-8-21.pek2.redhat.com>
 <ZJxFGCziTP+0Yb2n@kbusch-mbp.dhcp.thefacebook.com>
 <ZJzLf46lx4SiEfOA@ovpn-8-18.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJzLf46lx4SiEfOA@ovpn-8-18.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 29, 2023 at 08:08:31AM +0800, Ming Lei wrote:
> On Wed, Jun 28, 2023 at 08:35:04AM -0600, Keith Busch wrote:
> > On Wed, Jun 28, 2023 at 09:30:16AM +0800, Ming Lei wrote:
> > > That may not be enough:
> > > 
> > > - What if nvme_sysfs_delete() is called from sysfs before the 1st check in
> > > nvme_reset_work()?
> > > 
> > > - What if one pending nvme_dev_disable()<-nvme_timeout() comes after
> > > the added nvme_unquiesce_io_queues() returns?
> > 
> > Okay, the following will handle both:
> > 
> > ---
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index b027e5e3f4acb..c9224d39195e5 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2690,7 +2690,8 @@ static void nvme_reset_work(struct work_struct *work)
> >  	if (dev->ctrl.state != NVME_CTRL_RESETTING) {
> >  		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
> >  			 dev->ctrl.state);
> > -		return;
> > +		result = -ENODEV;
> > +		goto out;
> >  	}
> >  
> >  	/*
> > @@ -2777,7 +2778,9 @@ static void nvme_reset_work(struct work_struct *work)
> >  		 result);
> >  	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
> >  	nvme_dev_disable(dev, true);
> > +	nvme_sync_queues(&dev->ctrl);
> >  	nvme_mark_namespaces_dead(&dev->ctrl);
> > +	nvme_unquiesce_io_queues(&dev->ctrl);
> >  	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
> >  }
> 
> This one looks better, but reset may not be scheduled successfully because
> of removal, such as, the removal comes exactly before changing state
> to NVME_CTRL_RESETTING.

For example, io timeout disables the controller, but can't schedule the
reset because someone requested driver unbinding between the disabling
and the reset_work queueing? I think this needs some error checks,
like below. Fortunately there are not many places in nvme-pci that needs
this.

I do think the unconditional unquiesce in nvme_remove_namespaces() you
proposed earlier looks good though, too.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c9224d39195e5..bf21bd08ee7ed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -108,6 +108,7 @@ MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
 struct nvme_dev;
 struct nvme_queue;
 
+static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
@@ -1298,9 +1299,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 */
 	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
-		nvme_dev_disable(dev, false);
-		nvme_reset_ctrl(&dev->ctrl);
-		return BLK_EH_DONE;
+		goto disable;
 	}
 
 	/*
@@ -1351,10 +1350,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		nvme_dev_disable(dev, false);
-		nvme_reset_ctrl(&dev->ctrl);
-
-		return BLK_EH_DONE;
+		goto disable;
 	}
 
 	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
@@ -1391,6 +1387,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 * as the device then is in a faulty state.
 	 */
 	return BLK_EH_RESET_TIMER;
+
+disable:
+	if (!nvme_disable_prepare_reset(dev, false) &&
+	    nvme_try_sched_reset(&dev->ctrl))
+		nvme_unquiesce_io_queues(&dev->ctrl);
+	return BLK_EH_DONE;
 }
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
@@ -3278,7 +3280,8 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
-		nvme_dev_disable(dev, false);
+		if (nvme_disable_prepare_reset(dev, false))
+			return PCI_ERS_RESULT_DISCONNECT;
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
@@ -3294,7 +3297,8 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
 
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
-	nvme_reset_ctrl(&dev->ctrl);
+	if (!nvme_try_sched_reset(&dev->ctrl))
+		nvme_unquiesce_io_queues(&dev->ctrl);
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
--
