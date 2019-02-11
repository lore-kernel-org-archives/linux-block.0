Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A549C282CC
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 03:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449592146F
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 03:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfBKD60 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:58:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfBKD6Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 22:58:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9739888317;
        Mon, 11 Feb 2019 03:58:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7030B611D1;
        Mon, 11 Feb 2019 03:58:17 +0000 (UTC)
Date:   Mon, 11 Feb 2019 11:58:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] nvme-pci: simplify nvme_setup_irqs() via
 .setup_affinity callback
Message-ID: <20190211035810.GB8638@ming.t460p>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-5-ming.lei@redhat.com>
 <alpine.DEB.2.21.1902101731370.8784@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902101731370.8784@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 11 Feb 2019 03:58:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Feb 10, 2019 at 05:39:20PM +0100, Thomas Gleixner wrote:
> On Fri, 25 Jan 2019, Ming Lei wrote:
> 
> > Use the callback of .setup_affinity() to re-caculate number
> > of queues, and build irqs affinity with help of irq_build_affinity().
> > 
> > Then nvme_setup_irqs() gets simplified a lot.
> 
> I'm pretty sure you can achieve the same by reworking the core code without
> that callback.

Could you share the idea a bit? As I mentioned, the re-distribution
needs driver's knowledge.

>  
> > +	/* Fill out vectors at the beginning that don't need affinity */
> > +	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
> > +		cpumask_copy(&masks[curvec].mask, cpu_possible_mask);
> 
> cpu_possible_mask is wrong.  Why are you deliberately trying to make this
> special? There is absolutely no reason to do so.

It is just for avoiding to export 'irq_default_affinity'.

> 
> These interrupts are not managed and therefore the initial affinity has to
> be irq_default_affinity. Setting them to cpu_possible_mask can and probably
> will evade a well thought out default affinity mask, which was set to
> isolate a set of cores from general purpose interrupts.
> 
> This is exactly the thing which happens with driver special stuff and which
> needs to be avoided. There is nothing special about this NVME setup and
> yes, I can see why the current core code is a bit tedious to work with, but
> that does not justify that extra driver magic by any means.

OK, thanks for your explanation.

Thanks,
Ming
