Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5161DC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 08:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA8F2085A
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 08:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfCHISO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:18:14 -0500
Received: from verein.lst.de ([213.95.11.211]:52351 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfCHISO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 03:18:14 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0585868C4E; Fri,  8 Mar 2019 09:18:08 +0100 (CET)
Date:   Fri, 8 Mar 2019 09:18:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Christopher Lameter <cl@linux.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via
 page_frag_alloc
Message-ID: <20190308081807.GB12909@lst.de>
References: <a641feb8-ceb2-2dac-27aa-7b1df10f5ae5@suse.cz> <CACVXFVMX=WpTRBbDTSibfXkTZxckk3ootetbE+rkJtHhsZkRAw@mail.gmail.com> <20190226121209.GC11592@bombadil.infradead.org> <20190226123545.GA6163@ming.t460p> <20190226130230.GD11592@bombadil.infradead.org> <20190226134247.GA30942@ming.t460p> <20190226140440.GF11592@bombadil.infradead.org> <20190226161433.GH21626@magnolia> <20190226161912.GG11592@bombadil.infradead.org> <095ae112-f98e-9516-910a-43b49ea5bf0d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <095ae112-f98e-9516-910a-43b49ea5bf0d@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 27, 2019 at 08:07:31AM +0100, Vlastimil Babka wrote:
> > I don't know _what_ Ming Lei is saying.  I thought the problem was
> > with slab redzones, which need to be before and after each object,
> > but apparently the problem is with KASAN as well.
> 
> That's what I thought as well. But if we can solve it for caches created
> by kmem_cache_create(..., align, ...) then IMHO we could guarantee
> natural alignment for power-of-two kmalloc caches as well.

Yes, having a version of kmalloc that guarantees power of two alignment
would be extremely helpful and avoid a lot of pointless boilerplate code.
