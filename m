Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E172BC433EF
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 07:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiAEHf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 02:35:27 -0500
Received: from verein.lst.de ([213.95.11.211]:52491 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238088AbiAEHfZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jan 2022 02:35:25 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 64DA468AFE; Wed,  5 Jan 2022 08:35:22 +0100 (CET)
Date:   Wed, 5 Jan 2022 08:35:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 3/3] nvme-pci: fix queue_rqs list splitting
Message-ID: <20220105073522.GB3524@lst.de>
References: <20211227164138.2488066-1-kbusch@kernel.org> <20211227164138.2488066-3-kbusch@kernel.org> <20211229174602.GC28058@lst.de> <20220104193807.GB2666557@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104193807.GB2666557@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 04, 2022 at 11:38:07AM -0800, Keith Busch wrote:
> On Wed, Dec 29, 2021 at 06:46:02PM +0100, Christoph Hellwig wrote:
> > I wonder if a restart label here would be a little cleaner, something
> > like:
> 
> On second thought, this requires another check that the *rqlist is not
> NULL before 'goto restart' since the safe iterator dereferences it. I'm
> not sure this is cleaner than the original anymore.

Ok, let's stick to the original then.
