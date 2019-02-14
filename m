Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C77C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 08:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FBD222B6
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 08:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437627AbfBNIue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:50:34 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48930 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388475AbfBNIue (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 03:50:34 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guCik-00008u-BE; Thu, 14 Feb 2019 09:50:14 +0100
Date:   Thu, 14 Feb 2019 09:50:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Keith Busch <keith.busch@intel.com>
cc:     Bjorn Helgaas <helgaas@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
In-Reply-To: <20190213223711.GC8027@localhost.localdomain>
Message-ID: <alpine.DEB.2.21.1902140949280.1659@nanos.tec.linutronix.de>
References: <20190213105041.13537-1-ming.lei@redhat.com> <20190213105041.13537-2-ming.lei@redhat.com> <20190213150407.GB96272@google.com> <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de> <20190213213149.GB8027@localhost.localdomain>
 <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de> <20190213223711.GC8027@localhost.localdomain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Feb 2019, Keith Busch wrote:

Cc+ Huacai Chen

> On Wed, Feb 13, 2019 at 10:41:55PM +0100, Thomas Gleixner wrote:
> > Btw, while I have your attention. There popped up an issue recently related
> > to that affinity logic.
> > 
> > The current implementation fails when:
> > 
> >         /*
> >          * If there aren't any vectors left after applying the pre/post
> >          * vectors don't bother with assigning affinity.
> > 	 */
> > 	if (nvecs == affd->pre_vectors + affd->post_vectors)
> >     		return NULL;
> > 
> > Now the discussion arised, that in that case the affinity sets are not
> > allocated and filled in for the pre/post vectors, but somehow the
> > underlying device still works and later on triggers the warning in the
> > blk-mq code because the MSI entries do not have affinity information
> > attached.
> >
> > Sure, we could make that work, but there are several issues:
> > 
> >     1) irq_create_affinity_masks() has another reason to return NULL:
> >        memory allocation fails.
> > 
> >     2) Does it make sense at all.
> > 
> > Right now the PCI allocator ignores the NULL return and proceeds without
> > setting any affinities. As a consequence nothing is managed and everything
> > happens to work.
> > 
> > But that happens to work is more by chance than by design and the warning
> > is bogus if this is an expected mode of operation.
> > 
> > We should address these points in some way.
> 
> Ah, yes, that's a mistake in the nvme driver. It is assuming IO queues are
> always on managed interrupts, but that's not true if when only 1 vector
> could be allocated. This should be an appropriate fix to the warning:

Looks correct. Chen, can you please test that?

> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 022ea1ee63f8..f2ccebe1c926 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -506,7 +506,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  		 * affinity), so use the regular blk-mq cpu mapping
>  		 */
>  		map->queue_offset = qoff;
> -		if (i != HCTX_TYPE_POLL)
> +		if (i != HCTX_TYPE_POLL && dev->num_vecs > 1)
>  			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
>  		else
>  			blk_mq_map_queues(map);
> --
> 
