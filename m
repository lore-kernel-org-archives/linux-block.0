Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6300DC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2B22075C
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfC0Ibv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:31:51 -0400
Received: from verein.lst.de ([213.95.11.211]:40577 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfC0Ibv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 04:31:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1AF8968B05; Wed, 27 Mar 2019 09:31:43 +0100 (CET)
Date:   Wed, 27 Mar 2019 09:31:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
Message-ID: <20190327083142.GQ20525@lst.de>
References: <20190308174006.5032-1-keith.busch@intel.com> <20190308174006.5032-5-keith.busch@intel.com> <20190311184031.GA11707@lst.de> <20190311193753.GE10411@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311193753.GE10411@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 01:37:53PM -0600, Keith Busch wrote:
> > The only thing not purely block layer here is the enabled flag.
> > So if we had a per-hctx enabled flag we could lift this out of nvme,
> > and hopefully start reusing it in other drivers.
> 
> Okay, I may even be able to drop the new block exports if we do request
> termination in generic block layer. That's probably the right thing
> anyway since that layer is in a better position to check the necessary
> conditions that make tag iteration safe. Bart did point out that is
> generally not safe for drives to do, so it'd be good to safegaurd against
> incorrect usage.

Did you get a chance to look into this?
