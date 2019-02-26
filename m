Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D73C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 12:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F368720842
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 12:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kowBbUHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfBZMMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:12:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfBZMMN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 07:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rfvgT600SCeY1GxBCoS4srQI51Vh12EHfnz7EkKXv7Y=; b=kowBbUHOGJxpkdwvXHNEsYGuW
        zmnj+vAR9a+8vG/0eagusSoeqnhexBgPYYg9uEOul6XmofqsWxyE7ngmnzy2hYLPoOWAt07ELccjk
        g22/QKYOu/bktyRXamee+00gtj7LY6P+Sjz7sN+oOFGePNEKoU3fzvnNZ+BLbCnksRBxR94sQZJy4
        c9uTMM7TJsKEDwU2GKjrVLBGN0mlzg0xkL8QWX4hGlOxp7SjwKHh37KppzrdFl8AiSL0bTEzKp2vw
        N1w5Q3nkqU1PtAVm/RM+d5e8wgaaTnTlt1t3+aviHEA0u3ej6mrEVAsgljaxVY58ElIX2ZcZw1ewq
        PQojgJ7xg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gybaj-0006iH-KY; Tue, 26 Feb 2019 12:12:09 +0000
Date:   Tue, 26 Feb 2019 04:12:09 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
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
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via page_frag_alloc
Message-ID: <20190226121209.GC11592@bombadil.infradead.org>
References: <20190225043648.GE23020@dastard>
 <5ad2ef83-8b3a-0a15-d72e-72652b807aad@suse.cz>
 <20190225202630.GG23020@dastard>
 <20190226022249.GA17747@ming.t460p>
 <20190226030214.GI23020@dastard>
 <20190226032737.GA11592@bombadil.infradead.org>
 <20190226045826.GJ23020@dastard>
 <20190226093302.GA24879@ming.t460p>
 <a641feb8-ceb2-2dac-27aa-7b1df10f5ae5@suse.cz>
 <CACVXFVMX=WpTRBbDTSibfXkTZxckk3ootetbE+rkJtHhsZkRAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVMX=WpTRBbDTSibfXkTZxckk3ootetbE+rkJtHhsZkRAw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 26, 2019 at 07:12:49PM +0800, Ming Lei wrote:
> On Tue, Feb 26, 2019 at 6:07 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > On 2/26/19 10:33 AM, Ming Lei wrote:
> > > On Tue, Feb 26, 2019 at 03:58:26PM +1100, Dave Chinner wrote:
> > >> On Mon, Feb 25, 2019 at 07:27:37PM -0800, Matthew Wilcox wrote:
> > >>> On Tue, Feb 26, 2019 at 02:02:14PM +1100, Dave Chinner wrote:
> > >>>>> Or what is the exact size of sub-page IO in xfs most of time? For
> > >>>>
> > >>>> Determined by mkfs parameters. Any power of 2 between 512 bytes and
> > >>>> 64kB needs to be supported. e.g:
> > >>>>
> > >>>> # mkfs.xfs -s size=512 -b size=1k -i size=2k -n size=8k ....
> > >>>>
> > >>>> will have metadata that is sector sized (512 bytes), filesystem
> > >>>> block sized (1k), directory block sized (8k) and inode cluster sized
> > >>>> (32k), and will use all of them in large quantities.
> > >>>
> > >>> If XFS is going to use each of these in large quantities, then it doesn't
> > >>> seem unreasonable for XFS to create a slab for each type of metadata?
> > >>
> > >>
> > >> Well, that is the question, isn't it? How many other filesystems
> > >> will want to make similar "don't use entire pages just for 4k of
> > >> metadata" optimisations as 64k page size machines become more
> > >> common? There are others that have the same "use slab for sector
> > >> aligned IO" which will fall foul of the same problem that has been
> > >> reported for XFS....
> > >>
> > >> If nobody else cares/wants it, then it can be XFS only. But it's
> > >> only fair we address the "will it be useful to others" question
> > >> first.....
> > >
> > > This kind of slab cache should have been global, just like interface of
> > > kmalloc(size).
> > >
> > > However, the alignment requirement depends on block device's block size,
> > > then it becomes hard to implement as genera interface, for example:
> > >
> > >       block size: 512, 1024, 2048, 4096
> > >       slab size: 512*N, 0 < N < PAGE_SIZE/512
> > >
> > > For 4k page size, 28(7*4) slabs need to be created, and 64k page size
> > > needs to create 127*4 slabs.
> > >
> >
> > Where does the '*4' multiplier come from?
> 
> The buffer needs to be device block size aligned for dio, and now the block
> size can be 512, 1024, 2048 and 4096.

Why does the block size make a difference?  This requirement is due to
some storage devices having shoddy DMA controllers.  Are you saying there
are devices which can't even do 512-byte aligned I/O?
