Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDC1C0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 14:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE56B21850
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 14:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfGCOfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:35:02 -0400
Received: from verein.lst.de ([213.95.11.211]:52187 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfGCOfC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jul 2019 10:35:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D7C368B05; Wed,  3 Jul 2019 16:35:00 +0200 (CEST)
Date:   Wed, 3 Jul 2019 16:34:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: create bio_try_merge_pc_page helper
 __bio_add_pc_page
Message-ID: <20190703143459.GA10149@lst.de>
References: <20190703130036.4105-1-hch@lst.de> <20190703130036.4105-3-hch@lst.de> <20190703133446.GE4026@x250.microfocus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703133446.GE4026@x250.microfocus.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 03, 2019 at 03:34:55PM +0200, Johannes Thumshirn wrote:
> On Wed, Jul 03, 2019 at 06:00:35AM -0700, Christoph Hellwig wrote:
> [snip]
> >  	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
> >  
> >  	if ((addr1 | mask) != (addr2 | mask))
> >  		return false;
> > -
> >  	if (bv->bv_len + len > queue_max_segment_size(q))
> >  		return false;
> > -
> > -	return true;
> > +	return __bio_try_merge_page(bio, page, len, offset, same_page);
> >  }
> 
> That's a lot of spurious whitespace changes here.

Really just an empty line going away outside the directly touched code.
I think it is more effective to boundle that here rather than having
an extra patch for that..
