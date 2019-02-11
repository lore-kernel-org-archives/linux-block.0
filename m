Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CB2C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 04:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B070E2146F
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 04:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfBKEJ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 23:09:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfBKEJ0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 23:09:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD9BA7F6A8;
        Mon, 11 Feb 2019 04:09:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4D8F60A9D;
        Mon, 11 Feb 2019 04:09:17 +0000 (UTC)
Date:   Mon, 11 Feb 2019 12:09:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] nvme-pci: simplify nvme_setup_irqs() via
 .setup_affinity callback
Message-ID: <20190211040911.GC8638@ming.t460p>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-5-ming.lei@redhat.com>
 <alpine.DEB.2.21.1902101815260.8784@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902101815260.8784@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 11 Feb 2019 04:09:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Feb 10, 2019 at 07:49:12PM +0100, Thomas Gleixner wrote:
> On Fri, 25 Jan 2019, Ming Lei wrote:
> > +static int nvme_setup_affinity(const struct irq_affinity *affd,
> > +			       struct irq_affinity_desc *masks,
> > +			       unsigned int nmasks)
> > +{
> > +	struct nvme_dev *dev = affd->priv;
> > +	int affvecs = nmasks - affd->pre_vectors - affd->post_vectors;
> > +	int curvec, usedvecs;
> > +	int i;
> > +
> > +	nvme_calc_io_queues(dev, nmasks);
> 
> So this is the only NVME specific information. Everything else can be done
> in generic code. So what you really want is:
> 
> 	struct affd {
> 		...
> +		calc_sets(struct affd *, unsigned int nvecs);
> 		...
> 	}
> 
> And sets want to be actually inside of the affinity descriptor structure:
> 
>         unsigned int num_sets;
> 	unsigned int set_vectors[MAX_SETS];
> 
> We surely can define a sensible maximum of sets for now. If that ever turns
> out to be insufficient, then struct affd might become to large for the
> stack, but for now, using e.g. 8, there is no need to do so.
> 
> So then the logic in the generic code becomes exactly the same as what you
> added to nvme_setup_affinity():
> 
> 	if (affd->calc_sets) {
> 		affd->calc_sets(affd, nvecs);
> 	} else if (!affd->num_sets) {
> 		affd->num_sets = 1;
> 		affd->set_vectors[0] = affvecs;
> 	}
> 
> 	for (i = 0; i < affd->num_sets; i++) {
> 	    ....
> 	}
> 
> See?

OK, will do this way in V2, then we can avoid drivers to abuse
the callback.

Thanks,
Ming
