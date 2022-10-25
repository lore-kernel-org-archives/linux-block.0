Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D0FA373E
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 17:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiJYRn2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 13:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiJYRnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 13:43:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EABF17A970
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 10:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCD80B81E06
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 17:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A60C433C1;
        Tue, 25 Oct 2022 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666719802;
        bh=YNgbDZ+9Bj/bdArQbW/AFPuoyi2XdEQpN6TkyJvj/E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0AQvRajMGjv2hZP9KQNo1Cc2Pag0tNf6Nq83fD1rCZiG8fnieaEjPwGXpEVFTgCX
         ATHaBO1F9C9KNftS/fAk4gd+0/tlUoKN2cvNRXEUcPnXU1Dt+8Yd465Rbz0dmhRs+x
         S59MIshFFjAv12R1zDnH3sCdPSBPriR5PKqrXIWPfRa+4UQD5iwOj+1p3VZsXKeEQm
         PFDZ1r9V1Ym+EKa5sKY/COrq5GdCURL6jsgYGCANdlPceRmGGb6Mn9eSz3aKXa8m1I
         bquHQRotN7cnt+NmBXozMBJ6UWGsGy1b0nqBsF+A2bwJulyLSUXRfEwc/X3EdPqyNU
         9QOqr7Y5YqFRQ==
Date:   Tue, 25 Oct 2022 11:43:19 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 04/17] nvme: don't call nvme_kill_queues from
 nvme_remove_namespaces
Message-ID: <Y1ggN68V/mbAw1q2@kbusch-mbp.dhcp.thefacebook.com>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025144020.260458-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 07:40:07AM -0700, Christoph Hellwig wrote:
> @@ -4560,15 +4560,6 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	/* prevent racing with ns scanning */
>  	flush_work(&ctrl->scan_work);
>  
> -	/*
> -	 * The dead states indicates the controller was not gracefully
> -	 * disconnected. In that case, we won't be able to flush any data while
> -	 * removing the namespaces' disks; fail all the queues now to avoid
> -	 * potentially having to clean up the failed sync later.
> -	 */
> -	if (ctrl->state == NVME_CTRL_DEAD)
> -		nvme_kill_queues(ctrl);
> -
>  	/* this is a no-op when called from the controller reset handler */
>  	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
>  
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ec034d4dd9eff..f971e96ffd3f6 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3249,6 +3249,16 @@ static void nvme_remove(struct pci_dev *pdev)
>  
>  	flush_work(&dev->ctrl.reset_work);
>  	nvme_stop_ctrl(&dev->ctrl);
> +
> +	/*
> +	 * The dead states indicates the controller was not gracefully
> +	 * disconnected. In that case, we won't be able to flush any data while
> +	 * removing the namespaces' disks; fail all the queues now to avoid
> +	 * potentially having to clean up the failed sync later.
> +	 */
> +	if (dev->ctrl.state == NVME_CTRL_DEAD)
> +		nvme_kill_queues(&dev->ctrl);
> +
>  	nvme_remove_namespaces(&dev->ctrl);
>  	nvme_dev_disable(dev, true);
>  	nvme_remove_attrs(dev);
> -- 
> 2.30.2
> 

We still need the flush_work(scan_work) prior to killing the queues. It
looks like it could safely be moved to nvme_stop_ctrl(), which might
make it easier on everyone if it were there.
