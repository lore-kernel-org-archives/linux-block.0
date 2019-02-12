Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29475C282CA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 23:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4C7222C9
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 23:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550014949;
	bh=+ljDVPXUImG1Z+vSoOkg9hae4sm9zQLd0klZvq3ppo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PuRpbRwo9q1juCe9PbJYzoSx4A8B6tRKBpxnKW2C4Irdk+Bx8qzXINaBPFDXarEnF
	 Ho7ay781ctGUX1fENEfgE89D4KENyGJam1QMp/iXtM/0QyxJsiuDHKd1OFc6KrCYsh
	 FzOmOK7dJb6g+I91VvORiZrFFS9BZdOICzG2jS8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbfBLXm1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732343AbfBLXm1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 18:42:27 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B012084E;
        Tue, 12 Feb 2019 23:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550014946;
        bh=+ljDVPXUImG1Z+vSoOkg9hae4sm9zQLd0klZvq3ppo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UnGd2/YVAge9uRcZZCgcz5V08Kl8zL+g1nV66TA1iBWAbXqrxEUyoGnk0oM6JDPiV
         ueWRe0fctmjmpYtNdzULLonc0fgP/UThgAwDYwLMRcyWLTMIG2DTnP3jEGB7Nk4mvp
         ak3CFx0o/u68xiGHuNw0MPxHwswS4uwwR+Smoq9E=
Date:   Tue, 12 Feb 2019 17:42:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2 4/4] genirq/affinity: Document .calc_sets as required
 in case of multiple sets
Message-ID: <20190212234224.GA96272@google.com>
References: <20190212130439.14501-1-ming.lei@redhat.com>
 <20190212130439.14501-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212130439.14501-5-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 12, 2019 at 09:04:39PM +0800, Ming Lei wrote:
> Now NVMe has implemented the .calc_sets callback for caculating each
> set's vectors.
> 
> For other cases of multiple irq sets, it isn't a good way to pre-caculate
> each set's vectors before allocating IRQ vectors because NVMe's same issue
> exists too.

s/irq/IRQ/ so it's consistent in the paragraph.

> Document .calc_sets as required explicitly for multiple sets.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Note minor comments below.

> ---
>  drivers/pci/msi.c         | 4 ++--
>  include/linux/interrupt.h | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4c0b47867258..9f91fa713141 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1039,7 +1039,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	 * If the caller is passing in sets, we can't support a range of
>  	 * vectors. The caller needs to handle that.

Looks like this comment needs to be tweaked, maybe along the lines of:

  If the caller requests multiple sets of IRQs where each set requires
  different affinity, it must also supply a ->calc_sets() callback to
  compute the affinity cpumask for each set.

(I'm not 100% clear on how calc_sets() works, so I might not have
described this exactly right.)

>  	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> +	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(dev->msi_enabled))
> @@ -1097,7 +1097,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  	 * If the caller is passing in sets, we can't support a range of
>  	 * supported vectors. The caller needs to handle that.

Similar comment update here?

>  	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> +	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(dev->msix_enabled))
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 7a27f6ba1f2f..a053f7fb0ff1 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -269,7 +269,8 @@ struct irq_affinity_notify {
>   *			the MSI(-X) vector space
>   * @nr_sets:		Length of passed in *sets array
>   * @set_vectors:	Number of affinitized sets
> - * @calc_sets:		Callback for caculating set vectors
> + * @calc_sets:		Callback for caculating set vectors, required for
> + * 			multiple irq sets.
>   * @priv:		Private data of @calc_sets
>   */
>  struct irq_affinity {
> -- 
> 2.9.5
> 
