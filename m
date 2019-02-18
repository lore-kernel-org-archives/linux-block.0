Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF692C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 02:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDB3218C3
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 02:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfBRCtj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:49:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfBRCtj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Feb 2019 21:49:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 138AD7F769;
        Mon, 18 Feb 2019 02:49:39 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DE1860C76;
        Mon, 18 Feb 2019 02:49:27 +0000 (UTC)
Date:   Mon, 18 Feb 2019 10:49:23 +0800
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
Subject: Re: [patch v6 7/7] genirq/affinity: Add support for non-managed
 affinity sets
Message-ID: <20190218024922.GA27779@ming.t460p>
References: <20190216171306.403545970@linutronix.de>
 <20190216172228.869750763@linutronix.de>
 <20190217134522.GH7296@ming.t460p>
 <alpine.DEB.2.21.1902172010060.1683@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902172010060.1683@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 18 Feb 2019 02:49:39 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Thomas,

On Sun, Feb 17, 2019 at 08:17:05PM +0100, Thomas Gleixner wrote:
> On Sun, 17 Feb 2019, Ming Lei wrote:
> > On Sat, Feb 16, 2019 at 06:13:13PM +0100, Thomas Gleixner wrote:
> > > Some drivers need an extra set of interrupts which should not be marked
> > > managed, but should get initial interrupt spreading.
> > 
> > Could you share the drivers and their use case?
> 
> You were Cc'ed on that old discussion:
> 
>  https://lkml.kernel.org/r/300d6fef733ca76ced581f8c6304bac6@mail.gmail.com

Thanks for providing the link.

> 
> > > For both interrupt sets the interrupts are properly spread out, but the
> > > second set is not marked managed.
> > 
> > Given drivers only care the managed vs non-managed interrupt numbers,
> > just wondering why this case can't be covered by .pre_vectors &
> > .post_vectors?
> 
> Well, yes, but post/pre are not subject to spreading and I really don't
> want to go there.
> 
> > Also this kind of usage may break blk-mq easily, in which the following
> > rule needs to be respected:
> > 
> > 1) all CPUs are required to spread among each interrupt set
> > 
> > 2) no any CPU is shared between two IRQs in same set.
> 
> I don't see how that would break blk-mq. The unmanaged set is not used by
> the blk-mq stuff, that's some driver internal voodoo. So blk-mq still gets
> a perfectly spread and managed interrupt set for the queues.

From the discussion above, the use case is for megaraid_sas. And one of the
two interrupt sets(managed and non-managed) will be chosen according to
workloads runtime.

Each interrupt set actually defines one blk-mq queue mapping, and the
queue mapping needs to respect the rule I mentioned now. However,
non-managed affinity can be changed to any way anytime by user-space.

Recently HPSA tried to add one module parameter to use non-managed
IRQ[1].

Also NVMe RDMA uses non-managed interrupts, and at least one CPU hotplug
issue is never fixed yet[2]. 

[1] https://marc.info/?t=154387665200001&r=1&w=2
[2] https://www.spinics.net/lists/linux-block/msg24140.html


thanks,
Ming
