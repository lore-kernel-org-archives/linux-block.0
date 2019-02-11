Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5F1C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 22:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875732080F
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 22:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfBKWiU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:38:20 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40953 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfBKWiU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 17:38:20 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtKDI-0004bD-2V; Mon, 11 Feb 2019 23:38:08 +0100
Date:   Mon, 11 Feb 2019 23:38:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
In-Reply-To: <20190211143950.GA151039@google.com>
Message-ID: <alpine.DEB.2.21.1902112322470.1654@nanos.tec.linutronix.de>
References: <20190125095347.17950-1-ming.lei@redhat.com> <20190125095347.17950-3-ming.lei@redhat.com> <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de> <20190211035358.GA8638@ming.t460p> <20190211143950.GA151039@google.com>
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

On Mon, 11 Feb 2019, Bjorn Helgaas wrote:

> On Mon, Feb 11, 2019 at 11:54:00AM +0800, Ming Lei wrote:
> > On Sun, Feb 10, 2019 at 05:30:41PM +0100, Thomas Gleixner wrote:
> > > On Fri, 25 Jan 2019, Ming Lei wrote:
> > > 
> > > > This patch introduces callback of .setup_affinity into 'struct
> > > > irq_affinity', so that:
> > > 
> > > Please see Documentation/process/submitting-patches.rst. Search for 'This
> > > patch' ....
> > 
> > Sorry for that, because I am not a native English speaker and it looks a bit
> > difficult for me to understand the subtle difference.

Sorry I was a bit terse.

> I think Thomas is saying that instead of "This patch introduces
> callback ...", you could say "Introduce callback of ...".
> 
> The changelog is *part* of the patch, so the context is obvious and
> there's no need to include the words "This patch".
> 
> I make the same changes to patches I receive.  In fact, I would go
> even further and say "Add callback .setup_affinity() ..." because "add"
> means the same as "introduce" but is shorter and simpler.

Thanks for the explanation, Bjorn!

There is another point here. It's not only the 'This patch introduces ...'
part. It's also good practice to structure the changelog so it provides
context and reasoning first and then tells what the change is, e.g.:

   The current handling of multiple interrupt sets in the core interrupt
   affinity logic, requires the driver to do .......  This is necessary
   because ....

   This handling should be in the core code, but the core implementation
   has no way to recompute the interrupt sets for a given number of
   vectors.

   Add an optional callback to struct affd, which lets the driver recompute
   the interrupt set before the interrupt affinity spreading takes place.

The first paragraph provides context, i.e. the status quo, The second
paragraph provides reasoning what is missing and the last one tells what's
done to solve it.

That's pretty much the same for all changelogs, even if you fix a bug. Just
in the bug case, the second paragraph describes the details of the bug and
the possible consequences.

You really need to look at the changelog as a stand alone information
source. That's important when you look at a commit as an outsider or even
if you look at your own patch 6 month down the road when you already paged
out all the details.

Hope that clarifies it.

Thanks,

	tglx
