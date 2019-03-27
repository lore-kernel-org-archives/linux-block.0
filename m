Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98813C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 14:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB9A2075E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 14:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfC0OU6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:20:58 -0400
Received: from verein.lst.de ([213.95.11.211]:42047 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfC0OU6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 10:20:58 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 90F0268C4E; Wed, 27 Mar 2019 15:20:49 +0100 (CET)
Date:   Wed, 27 Mar 2019 15:20:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/15] block: add a rq_dma_dir helper
Message-ID: <20190327142049.GC26200@lst.de>
References: <20190321231037.25104-1-hch@lst.de> <20190321231037.25104-4-hch@lst.de> <80ffa084-e1fb-4c5c-da92-7d9486084cb6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ffa084-e1fb-4c5c-da92-7d9486084cb6@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 02:06:43PM +0100, Johannes Thumshirn wrote:
> On 22/03/2019 00:10, Christoph Hellwig wrote:
> > In a lot of places we want to know the DMA direction for a given
> > struct request.  Add a little helper to make it a littler easier.
> 
> You introuduce the helper here but you're using it in 8/15 for the 1st time.
> 
> Could you convert the possible users to use the new helper in this patch
> as well?

I'd rather not throw that into a nvme series.  Those are easily cleanups
for later.  Maybe we can even encourage people that would otherwise
do whitespace cleanups or incorrect refcount_t conversions to take care
of it :)
