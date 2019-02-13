Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC97C282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 15:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D312222C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550071006;
	bh=8T698jJA+B1VS7dD3ss7MUKHpeHgLZ8j3f8asqnOGdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HsuTiG32UW9jWfkqr+pOlHmzc7mvse8UWuvZ3zrhmZo5au3tuO4WUlTTyt6QU3MQG
	 jJynbyJMf8hlc/GAAUoiEAyJZlcSzgFZyYSiYZ+urHhs2MLBVUr/E0gdUo92q4gB/r
	 QnYKDsDYAtcvocb9kC4EiFfYV2O/di1n09lHYq8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbfBMPQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390416AbfBMPQp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 10:16:45 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12624222B1;
        Wed, 13 Feb 2019 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550071004;
        bh=8T698jJA+B1VS7dD3ss7MUKHpeHgLZ8j3f8asqnOGdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCDxYi/O9bFnFcsjAv3aqhXArBwjiBPbh2pmj8ws6eMxr6GE36JNYuc5YXPTXc6u4
         mrf3n5YkPugO2YhLvSu+fSO8eAS0ZKINDoOKdyfl/NTeuwsnHw8FmVqgixQsBGwjuu
         8lNlhJE4JJTRUiGuG4tZPV8iTR3FMs3EtTAI7tzE=
Date:   Wed, 13 Feb 2019 09:16:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V3 5/5] genirq/affinity: Document .calc_sets as required
 in case of multiple sets
Message-ID: <20190213151642.GF96272@google.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213105041.13537-6-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 06:50:41PM +0800, Ming Lei wrote:
> Now NVMe has implemented the .calc_sets callback for caculating each
> set's vectors.

s/caculating/calculating/

> For other cases of multiple IRQ sets, pre-caculating each set's vectors
> before allocating IRQ vectors can't work because the whole vectors
> number is unknow at that time.

s/unknow/unknown/
Maybe spell check could be helpful?

> So document .calc_sets as required explicitly for multiple sets.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/pci/msi.c         | 16 ++++++++++------
>  include/linux/interrupt.h |  3 ++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 96978459e2a0..199d708b4099 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1036,10 +1036,12 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  		return -ERANGE;
>  
>  	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * vectors. The caller needs to handle that.
> +	 * If the caller requests multiple sets of IRQs where each set
> +	 * requires different affinity, it must also supply a ->calc_sets()
> +	 * callback to compute vectors for each set after whole vectors are
> +	 * allocated.

"compute vectors for each set after whole vectors are allocated"
doesn't read smoothly.  The caller is requesting "multiple sets of
IRQs".  So each set contains several IRQ vectors.  IIUC, the vectors
calc_sets() are computing are something other than IRQ vectors.

>  	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> +	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(dev->msi_enabled))
> @@ -1094,10 +1096,12 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  		return -ERANGE;
>  
>  	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * supported vectors. The caller needs to handle that.
> +	 * If the caller requests multiple sets of IRQs where each set
> +	 * requires different affinity, it must also supply a ->calc_sets()
> +	 * callback to compute vectors for each set after whole vectors are
> +	 * allocated.
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
