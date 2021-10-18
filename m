Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC62C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6518060EC0
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJRMkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:40:04 -0400
Received: from verein.lst.de ([213.95.11.211]:33747 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhJRMkE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 08:40:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DCE4E68AFE; Mon, 18 Oct 2021 14:37:50 +0200 (CEST)
Date:   Mon, 18 Oct 2021 14:37:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: don't memset() the normal read/write command
Message-ID: <20211018123750.GA17785@lst.de>
References: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk> <20211013045822.GA24761@lst.de> <843b8695-9af7-ec33-da83-e711850223b1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843b8695-9af7-ec33-da83-e711850223b1@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 06:33:51AM -0600, Jens Axboe wrote:
> >>  	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
> >> +	cmnd->rw.rsvd2 = 0;
> > 
> > There should be no need to clear this reserved space.
> 
> Actually wasn't sure, sometimes hardware specs required reserved fields
> to get cleared. nvme does not? I'd be happy to drop it if not the case.

It only requires bits in otherwise unused fields to be the zeroed.

That being said, yes we're probably on the safe side by clearing
everything.
