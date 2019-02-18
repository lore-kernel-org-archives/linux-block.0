Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37106C10F02
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 07:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C21218D8
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 07:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfBRH0H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:26:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55843 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfBRH0G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 02:26:06 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gvdJG-00069U-27; Mon, 18 Feb 2019 08:25:50 +0100
Date:   Mon, 18 Feb 2019 08:25:49 +0100 (CET)
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
In-Reply-To: <20190218024922.GA27779@ming.t460p>
Message-ID: <alpine.DEB.2.21.1902180824070.1683@nanos.tec.linutronix.de>
References: <20190216171306.403545970@linutronix.de> <20190216172228.869750763@linutronix.de> <20190217134522.GH7296@ming.t460p> <alpine.DEB.2.21.1902172010060.1683@nanos.tec.linutronix.de> <20190218024922.GA27779@ming.t460p>
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

Ming,

On Mon, 18 Feb 2019, Ming Lei wrote:
> On Sun, Feb 17, 2019 at 08:17:05PM +0100, Thomas Gleixner wrote:
> > I don't see how that would break blk-mq. The unmanaged set is not used by
> > the blk-mq stuff, that's some driver internal voodoo. So blk-mq still gets
> > a perfectly spread and managed interrupt set for the queues.
> 
> >From the discussion above, the use case is for megaraid_sas. And one of the
> two interrupt sets(managed and non-managed) will be chosen according to
> workloads runtime.
> 
> Each interrupt set actually defines one blk-mq queue mapping, and the
> queue mapping needs to respect the rule I mentioned now. However,
> non-managed affinity can be changed to any way anytime by user-space.
> 
> Recently HPSA tried to add one module parameter to use non-managed
> IRQ[1].
> 
> Also NVMe RDMA uses non-managed interrupts, and at least one CPU hotplug
> issue is never fixed yet[2]. 
> 
> [1] https://marc.info/?t=154387665200001&r=1&w=2
> [2] https://www.spinics.net/lists/linux-block/msg24140.html

Interesting. I misread the description which megasas folks provided
then. I'll drop that patch and get the other lot merged. Thanks for your
work and help with that!

Thanks,

	tglx
