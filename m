Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A37C433F5
	for <linux-block@archiver.kernel.org>; Thu, 30 Dec 2021 07:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhL3Hxx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:53:53 -0500
Received: from verein.lst.de ([213.95.11.211]:39568 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhL3Hxx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Dec 2021 02:53:53 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 715A768AFE; Thu, 30 Dec 2021 08:53:48 +0100 (CET)
Date:   Thu, 30 Dec 2021 08:53:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 3/3] nvme-pci: fix queue_rqs list splitting
Message-ID: <20211230075348.GA5073@lst.de>
References: <20211227164138.2488066-1-kbusch@kernel.org> <20211227164138.2488066-3-kbusch@kernel.org> <20211229174602.GC28058@lst.de> <20211229210446.GC2493133@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229210446.GC2493133@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 29, 2021 at 01:04:46PM -0800, Keith Busch wrote:
> On Wed, Dec 29, 2021 at 06:46:02PM +0100, Christoph Hellwig wrote:
> > > +			rq_list_move(rqlist, &requeue_list, req, prev, next);
> > > +
> > > +			req = prev;
> > > +			if (!req)
> > > +				continue;
> > 
> > Shouldn't this be a break?
> 
> The condition just means we're at the beginning of the rqlist. There may
> be more requests to consider, so we have to continue.
> 
> Or are you saying any failed prep should just abandon the batched
> sequence? If so, we would need to concat the return list with the rest
> of rqlist before breaking.

No, I misunderstood the check,
