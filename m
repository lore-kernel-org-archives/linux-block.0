Return-Path: <SRS0=s4v/=QY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35816C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D52A21B69
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 13:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfBQNj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:39:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfBQNj6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Feb 2019 08:39:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EEA8B21B;
        Sun, 17 Feb 2019 13:39:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7227D608C1;
        Sun, 17 Feb 2019 13:39:48 +0000 (UTC)
Date:   Sun, 17 Feb 2019 21:39:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch v6 6/7] PCI/MSI: Remove obsolete sanity checks for
 multiple interrupt sets
Message-ID: <20190217133942.GG7296@ming.t460p>
References: <20190216171306.403545970@linutronix.de>
 <20190216172228.778630549@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216172228.778630549@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 17 Feb 2019 13:39:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 16, 2019 at 06:13:12PM +0100, Thomas Gleixner wrote:
> Multiple interrupt sets for affinity spreading are now handled in the core
> code and the number of sets and their size is recalculated via a driver
> supplied callback.
> 
> That avoids the requirement to invoke pci_alloc_irq_vectors_affinity() with
> the arguments minvecs and maxvecs set to the same value and the callsite
> handling the ENOSPC situation.
> 
> Remove the now obsolete sanity checks and the related comments.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  drivers/pci/msi.c |   14 --------------
>  1 file changed, 14 deletions(-)
> 
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> -	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * vectors. The caller needs to handle that.
> -	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> -		return -EINVAL;
> -
>  	if (WARN_ON_ONCE(dev->msi_enabled))
>  		return -EINVAL;
>  
> @@ -1093,13 +1086,6 @@ static int __pci_enable_msix_range(struc
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> -	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * supported vectors. The caller needs to handle that.
> -	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> -		return -EINVAL;
> -
>  	if (WARN_ON_ONCE(dev->msix_enabled))
>  		return -EINVAL;
>  
> 
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
