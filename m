Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4353CEB64D7
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 00:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjF2AJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 20:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjF2AJh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 20:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD7C10CF
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 17:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687997326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SN/hlkEtT439556aUYMeyg5okVvO4F8jT/j56Sxlyzo=;
        b=YcCr6bN0jyKFFB+bbHZ3Brbog1ZSJ6SSXhKVP6F9fhPkIZkcKriN6cWlTsdGtrRn+OQAay
        Y0/X1whDWXCecwDLnrC/dREjHwqLoReh34VJoX0F2RXsCggUByCfFtdnBp3RfNvKPIVY3b
        NJ8Rs+hPnO70GWCzeHTk01DD1fas+AE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-Tnpd1YoXP66rKp5nRexz1w-1; Wed, 28 Jun 2023 20:08:41 -0400
X-MC-Unique: Tnpd1YoXP66rKp5nRexz1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3B908E4686;
        Thu, 29 Jun 2023 00:08:40 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12DC3111F3B0;
        Thu, 29 Jun 2023 00:08:35 +0000 (UTC)
Date:   Thu, 29 Jun 2023 08:08:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJzLf46lx4SiEfOA@ovpn-8-18.pek2.redhat.com>
References: <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
 <ZJuNKGy5dXPC6i+H@ovpn-8-21.pek2.redhat.com>
 <ZJxFGCziTP+0Yb2n@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJxFGCziTP+0Yb2n@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 28, 2023 at 08:35:04AM -0600, Keith Busch wrote:
> On Wed, Jun 28, 2023 at 09:30:16AM +0800, Ming Lei wrote:
> > That may not be enough:
> > 
> > - What if nvme_sysfs_delete() is called from sysfs before the 1st check in
> > nvme_reset_work()?
> > 
> > - What if one pending nvme_dev_disable()<-nvme_timeout() comes after
> > the added nvme_unquiesce_io_queues() returns?
> 
> Okay, the following will handle both:
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b027e5e3f4acb..c9224d39195e5 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2690,7 +2690,8 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (dev->ctrl.state != NVME_CTRL_RESETTING) {
>  		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
>  			 dev->ctrl.state);
> -		return;
> +		result = -ENODEV;
> +		goto out;
>  	}
>  
>  	/*
> @@ -2777,7 +2778,9 @@ static void nvme_reset_work(struct work_struct *work)
>  		 result);
>  	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>  	nvme_dev_disable(dev, true);
> +	nvme_sync_queues(&dev->ctrl);
>  	nvme_mark_namespaces_dead(&dev->ctrl);
> +	nvme_unquiesce_io_queues(&dev->ctrl);
>  	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
>  }

This one looks better, but reset may not be scheduled successfully because
of removal, such as, the removal comes exactly before changing state
to NVME_CTRL_RESETTING.

Thanks,
Ming

