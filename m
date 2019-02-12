Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF6C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 11:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FCF2084E
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 11:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfBLLR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:17:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbfBLLR5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 06:17:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 040F95858E;
        Tue, 12 Feb 2019 11:17:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A171716929;
        Tue, 12 Feb 2019 11:17:46 +0000 (UTC)
Date:   Tue, 12 Feb 2019 19:17:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
Message-ID: <20190212111738.GE24251@ming.t460p>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-3-ming.lei@redhat.com>
 <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de>
 <20190211035358.GA8638@ming.t460p>
 <20190211143950.GA151039@google.com>
 <alpine.DEB.2.21.1902112322470.1654@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902112322470.1654@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 12 Feb 2019 11:17:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Thomas,

On Mon, Feb 11, 2019 at 11:38:07PM +0100, Thomas Gleixner wrote:
> Ming,
> 
> On Mon, 11 Feb 2019, Bjorn Helgaas wrote:
> 
> > On Mon, Feb 11, 2019 at 11:54:00AM +0800, Ming Lei wrote:
> > > On Sun, Feb 10, 2019 at 05:30:41PM +0100, Thomas Gleixner wrote:
> > > > On Fri, 25 Jan 2019, Ming Lei wrote:
> > > > 
> > > > > This patch introduces callback of .setup_affinity into 'struct
> > > > > irq_affinity', so that:
> > > > 
> > > > Please see Documentation/process/submitting-patches.rst. Search for 'This
> > > > patch' ....
> > > 
> > > Sorry for that, because I am not a native English speaker and it looks a bit
> > > difficult for me to understand the subtle difference.
> 
> Sorry I was a bit terse.
> 
> > I think Thomas is saying that instead of "This patch introduces
> > callback ...", you could say "Introduce callback of ...".
> > 
> > The changelog is *part* of the patch, so the context is obvious and
> > there's no need to include the words "This patch".
> > 
> > I make the same changes to patches I receive.  In fact, I would go
> > even further and say "Add callback .setup_affinity() ..." because "add"
> > means the same as "introduce" but is shorter and simpler.
> 
> Thanks for the explanation, Bjorn!
> 
> There is another point here. It's not only the 'This patch introduces ...'
> part. It's also good practice to structure the changelog so it provides
> context and reasoning first and then tells what the change is, e.g.:
> 
>    The current handling of multiple interrupt sets in the core interrupt
>    affinity logic, requires the driver to do .......  This is necessary
>    because ....
> 
>    This handling should be in the core code, but the core implementation
>    has no way to recompute the interrupt sets for a given number of
>    vectors.
> 
>    Add an optional callback to struct affd, which lets the driver recompute
>    the interrupt set before the interrupt affinity spreading takes place.
> 
> The first paragraph provides context, i.e. the status quo, The second
> paragraph provides reasoning what is missing and the last one tells what's
> done to solve it.
> 
> That's pretty much the same for all changelogs, even if you fix a bug. Just
> in the bug case, the second paragraph describes the details of the bug and
> the possible consequences.
> 
> You really need to look at the changelog as a stand alone information
> source. That's important when you look at a commit as an outsider or even
> if you look at your own patch 6 month down the road when you already paged
> out all the details.
> 
> Hope that clarifies it.

Your description about how to write changelog is really helpful and useful
for me, thanks!

Maybe you can add it into Documentation/SubmittingPatches, so that lots
of people can benefit from the guide.


Thanks,
Ming
