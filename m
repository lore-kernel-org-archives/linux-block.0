Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550D3EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 14:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjF1OfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 10:35:09 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:60772 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjF1OfI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 10:35:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39AEC61349
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 14:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13661C433C8;
        Wed, 28 Jun 2023 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687962907;
        bh=SoYEiMCAJ933BAt+0O/4yhFG8Ayk3K3QxicFuOWsNh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLBRsUBLAIVRs27Z82I6Ru7Mg3cULGPtveTXNmuqnAvYtRMH98wslkiNROvYc8jjt
         wfWKToVOhfzNx+5wd4rFwfCzBmpSZxnZr6K4yefzvARXP5ydl+EChRBeYFw8dds/d3
         TY+pI9/ELHb+onX15X19+uXZUssWrApsJ3eJ64316rqZBFWjQXNWdWN6YdfVqdKfjJ
         WG2ujISQJ5IMopRf95YyPLEcab97t8Wqql9MU/IHM/XLOP/JG6j/DRtmdDu46iZQPA
         2lChnWwdDLxNXsH/EiR+eG+FDKKWwtYOjwZ45HjoA/7gRcxaJ0Kp3cmsO11DRjeXvG
         gO7gLJn9+291Q==
Date:   Wed, 28 Jun 2023 08:35:04 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJxFGCziTP+0Yb2n@kbusch-mbp.dhcp.thefacebook.com>
References: <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
 <ZJuNKGy5dXPC6i+H@ovpn-8-21.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJuNKGy5dXPC6i+H@ovpn-8-21.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 28, 2023 at 09:30:16AM +0800, Ming Lei wrote:
> That may not be enough:
> 
> - What if nvme_sysfs_delete() is called from sysfs before the 1st check in
> nvme_reset_work()?
> 
> - What if one pending nvme_dev_disable()<-nvme_timeout() comes after
> the added nvme_unquiesce_io_queues() returns?

Okay, the following will handle both:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b027e5e3f4acb..c9224d39195e5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2690,7 +2690,8 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.state != NVME_CTRL_RESETTING) {
 		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
 			 dev->ctrl.state);
-		return;
+		result = -ENODEV;
+		goto out;
 	}
 
 	/*
@@ -2777,7 +2778,9 @@ static void nvme_reset_work(struct work_struct *work)
 		 result);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_dev_disable(dev, true);
+	nvme_sync_queues(&dev->ctrl);
 	nvme_mark_namespaces_dead(&dev->ctrl);
+	nvme_unquiesce_io_queues(&dev->ctrl);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 }
 
--
