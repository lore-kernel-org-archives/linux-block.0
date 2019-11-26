Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08CDC432C3
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 16:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE5A20722
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 16:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfKZQYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:24:16 -0500
Received: from verein.lst.de ([213.95.11.211]:41521 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfKZQYQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 11:24:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C885768C4E; Tue, 26 Nov 2019 17:24:12 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:24:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, John Meneghini <johnm@netapp.com>,
        Jen Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Message-ID: <20191126162412.GA7663@lst.de>
References: <20191126133650.72196-1-hare@suse.de> <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 27, 2019 at 01:05:46AM +0900, Keith Busch wrote:
> > +++ b/include/linux/blk_types.h
> > @@ -84,6 +84,7 @@ static inline bool blk_path_error(blk_status_t error)
> >  	case BLK_STS_NEXUS:
> >  	case BLK_STS_MEDIUM:
> >  	case BLK_STS_PROTECTION:
> > +	case BLK_STS_RESOURCE:
> >  		return false;
> >  	}
> 
> I agree we need to make this status a non-path error, but we at least
> need an Ack from Jens or have this patch go through linux-block if we're
> changing BLK_STS_RESOURCE to mean a non-path error.

most resource errors are per-path, so blindly changing this is wrong.

That's why I really just wanted to decode the nvme status codes inside
nvme instead of going through a block layer mapping, as that is just
bound to lose some information.
