Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE34AC38A2D
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 18:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiJYSxa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiJYSxa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 14:53:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFB6A487A
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 11:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 476C3B81E84
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 18:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642C3C433D6;
        Tue, 25 Oct 2022 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666724007;
        bh=qXItz4lSkGiD7gbYePH9XLDF1DbJ3bgBrxUqFEb6QAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fziRdPhqJQ06KZ0kiP0MS1nP+VvYfrrK3tA+Jq9uxyTDyN6KptCBDwXFa/vBhIx7N
         bz63Yugw2OmcNyfwl+eyNtbg0uRxL/ExRdmdjSBh94+rijLiKUNJfllsshoAozYDGZ
         QIiRuupR3aMV+He1t7suNLfcfBaVgLCtYAtaF1NizClR//7NprqUrWQbBwHDcRtHV2
         QWk0cgAkYCpPtxHSLfXO2JMPR1U3Cfxm/L9QRBhnloszp61LKgvyd1Oa85aHf+6Cef
         8W6oADV6X8dBz1gH06UFNrK5+VfJAnQ2LwpMdIm3TwgLZ42LZiS3vNru5k0fqCGw+c
         ovkOZyQEf5GpQ==
Date:   Tue, 25 Oct 2022 12:53:23 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 10/17] nvme-pci: mark the namespaces dead earlier in
 nvme_remove
Message-ID: <Y1gwo69pYet8hzt1@kbusch-mbp.dhcp.thefacebook.com>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025144020.260458-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 07:40:13AM -0700, Christoph Hellwig wrote:
> When we have a non-present controller there is no reason to wait in
> marking the namespaces dead, so do it ASAP.  Also remove the superflous
> call to nvme_start_queues as nvme_dev_disable already did that for us.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8ab54857cfd50..bef98f6e1396c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3244,25 +3244,19 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>  	pci_set_drvdata(pdev, NULL);
>  
> +	/*
> +	 * Mark the namespaces dead as we can't flush the data, and disable the
> +	 * controller ASAP as we can't shut it down properly if it was surprise
> +	 * removed.
> +	 */
>  	if (!pci_device_is_present(pdev)) {
>  		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
> +		nvme_mark_namespaces_dead(&dev->ctrl);
>  		nvme_dev_disable(dev, true);
>  	}

Ah, this changes what I mentioned about 4. Flushing the scan_work prior
to nvme_mark_namespaces_dead() still looks the right thing to do, but I
think you have to do both after nvme_dev_disable().
