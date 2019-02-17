Return-Path: <SRS0=s4v/=QY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB6AC10F06
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 19:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0097721874
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 19:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfBQTRZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Feb 2019 14:17:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55483 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfBQTRY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Feb 2019 14:17:24 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gvRw1-0004hb-VG; Sun, 17 Feb 2019 20:17:06 +0100
Date:   Sun, 17 Feb 2019 20:17:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [patch v6 7/7] genirq/affinity: Add support for non-managed
 affinity sets
In-Reply-To: <20190217134522.GH7296@ming.t460p>
Message-ID: <alpine.DEB.2.21.1902172010060.1683@nanos.tec.linutronix.de>
References: <20190216171306.403545970@linutronix.de> <20190216172228.869750763@linutronix.de> <20190217134522.GH7296@ming.t460p>
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

On Sun, 17 Feb 2019, Ming Lei wrote:
> On Sat, Feb 16, 2019 at 06:13:13PM +0100, Thomas Gleixner wrote:
> > Some drivers need an extra set of interrupts which should not be marked
> > managed, but should get initial interrupt spreading.
> 
> Could you share the drivers and their use case?

You were Cc'ed on that old discussion:

 https://lkml.kernel.org/r/300d6fef733ca76ced581f8c6304bac6@mail.gmail.com

> > For both interrupt sets the interrupts are properly spread out, but the
> > second set is not marked managed.
> 
> Given drivers only care the managed vs non-managed interrupt numbers,
> just wondering why this case can't be covered by .pre_vectors &
> .post_vectors?

Well, yes, but post/pre are not subject to spreading and I really don't
want to go there.

> Also this kind of usage may break blk-mq easily, in which the following
> rule needs to be respected:
> 
> 1) all CPUs are required to spread among each interrupt set
> 
> 2) no any CPU is shared between two IRQs in same set.

I don't see how that would break blk-mq. The unmanaged set is not used by
the blk-mq stuff, that's some driver internal voodoo. So blk-mq still gets
a perfectly spread and managed interrupt set for the queues.

> >  	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
> > -		unsigned int this_vecs = affd->set_size[i];
> > +		bool managed = affd->unmanaged_sets & (1U << i) ? true : false;
> 
> The above check is inverted.

Doh. Stupid me.

Thanks,

	tglx
