Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8961C4151A
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 15:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A930E222C9
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550070713;
	bh=PVtkD81tbRAZLjiGxDvVc3Wf2hPGiTK6qsudlBgygWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Si4dL5C8BRSGmEu6zl0Rex0kmnfmwU99ahbh2MhKUBnndkFGlNHxn2QcAm3AB3EKh
	 Nc95F5RBi2m4Q1E4vn+nh23ZPDUhOblOJkwtjYA4cFN9aC1W5apOWdNKkEEy2LYGnN
	 xSM2hW4IUJcCP1UADiLdZZMLdR6dF/kUG9jcpYR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbfBMPLw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:11:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbfBMPLw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 10:11:52 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA418222BA;
        Wed, 13 Feb 2019 15:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550070711;
        bh=PVtkD81tbRAZLjiGxDvVc3Wf2hPGiTK6qsudlBgygWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bfq7cyKe0yl9pmxWcrkOgfUClN4PHgpICht2ZTw/I3bTHEj+oY5H6LlQCELhk3VU4
         J9tDaA7MtgojPU2H7m93K2+RYJTboW8LHZU8f+OecNFcUmrrFJFtrzE9eZUsRZzyy7
         S0806FLLeU7LzQ3nQEn5Iuwf+4Hm+GpRyOjSezVM=
Date:   Wed, 13 Feb 2019 09:11:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V3 3/5] genirq/affinity: add new callback for caculating
 set vectors
Message-ID: <20190213151149.GD96272@google.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213105041.13537-4-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 06:50:39PM +0800, Ming Lei wrote:
> Currently pre-caculated set vectors are provided by driver for
> allocating & spread vectors. This way only works when drivers passes
> same 'max_vecs' and 'min_vecs' to pci_alloc_irq_vectors_affinity(),
> also requires driver to retry the allocating & spread.

s/pre-caculated/precalculated/
s/drivers/a driver/
s/also requires/which also requires the/

> As Bjorn and Keith mentioned, the current usage & interface for irq sets
> is a bit awkward because the retrying should have been avoided by providing
> one resonable 'min_vecs'. However, if 'min_vecs' isn't same with
> 'max_vecs', number of the allocated vectors is unknown before calling
> pci_alloc_irq_vectors_affinity(), then each set's vectors can't be
> pre-caculated.

s/resonable/reasonable/
s/isn't same with/isn't the same as/
s/number of/the number of/
s/pre-caculated/precalculated/
s/then each/and the/
s/irq/IRQ/

> Add a new callback of .calc_sets into 'struct irq_affinity' so that
> driver can caculate set vectors after IRQ vector is allocated and
> before spread IRQ vectors. Add 'priv' so that driver may retrieve
> its private data via the 'struct irq_affinity'.

s/caculate/calculate/

I *think* "set vectors" here has something to do with an affinity
cpumask?  "Set vectors" doesn't seem like quite the right terminology.

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/interrupt.h | 4 ++++
>  kernel/irq/affinity.c     | 8 ++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index a20150627a32..7a27f6ba1f2f 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -269,12 +269,16 @@ struct irq_affinity_notify {
>   *			the MSI(-X) vector space
>   * @nr_sets:		Length of passed in *sets array
>   * @set_vectors:	Number of affinitized sets
> + * @calc_sets:		Callback for caculating set vectors

Possible s/set vectors/<something else>/ ?

> + * @priv:		Private data of @calc_sets
>   */
>  struct irq_affinity {
>  	int	pre_vectors;
>  	int	post_vectors;
>  	int	nr_sets;
>  	int	set_vectors[IRQ_MAX_SETS];
> +	void	(*calc_sets)(struct irq_affinity *, int nvecs);
> +	void	*priv;
>  };
>  
>  /**
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index b868b9d3df7f..2341b1f005fa 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -267,7 +267,9 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
>  	 * Spread on present CPUs starting from affd->pre_vectors. If we
>  	 * have multiple sets, build each sets affinity mask separately.
>  	 */
> -	if (!affd->nr_sets) {
> +	if (affd->calc_sets) {
> +		affd->calc_sets(affd, nvecs);
> +	} else if (!affd->nr_sets) {
>  		affd->nr_sets = 1;
>  		affd->set_vectors[0] = affvecs;
>  	}
> @@ -316,7 +318,9 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>  	if (resv > minvec)
>  		return 0;
>  
> -	if (affd->nr_sets) {
> +	if (affd->calc_sets) {
> +		set_vecs = vecs;
> +	} else if (affd->nr_sets) {
>  		int i;
>  
>  		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
> -- 
> 2.9.5
> 
