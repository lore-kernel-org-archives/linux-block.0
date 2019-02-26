Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C56C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EFC2173C
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LjcTktzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfBZQTR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:19:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfBZQTQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 11:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2q/6sTclQ4HD43oxc6ZIBjMTrrqlUrCbHZqpallTMrs=; b=LjcTktzJGQ5AWHYQiVLJOCyfG
        07+YGizkMObPDSxyZ0+9BEJ5UtOtuL3muimUQ/JRZeUVxdrLER23VMYbCAsCXR3fWs6Ydp0bCE3TA
        kTZra2TTjuMUy5TKf+eDwvAoS/mETpq/fy49EIoFpPzsKlzctluwvsiRVvTNZpZ3Sd7Aq8k9u9EZb
        w17SUcSpJ2bMGRr4jPOknsPiMBVz0LEN/Gmp/4h8uDdlVAXxy5QV9krqbo6cicDfCD3r2gkzaKNmL
        v5PpbawwUQHhwngr3wFoZ+VBdiSFyu2ubwBXF3biemXEKkyOwm1tNLKGq/8bgNvT4Fq0P3gUwJ/yQ
        9isYXMbiQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyfRo-0007GC-9E; Tue, 26 Feb 2019 16:19:12 +0000
Date:   Tue, 26 Feb 2019 08:19:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Ming Lei <tom.leiming@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via page_frag_alloc
Message-ID: <20190226161912.GG11592@bombadil.infradead.org>
References: <20190226045826.GJ23020@dastard>
 <20190226093302.GA24879@ming.t460p>
 <a641feb8-ceb2-2dac-27aa-7b1df10f5ae5@suse.cz>
 <CACVXFVMX=WpTRBbDTSibfXkTZxckk3ootetbE+rkJtHhsZkRAw@mail.gmail.com>
 <20190226121209.GC11592@bombadil.infradead.org>
 <20190226123545.GA6163@ming.t460p>
 <20190226130230.GD11592@bombadil.infradead.org>
 <20190226134247.GA30942@ming.t460p>
 <20190226140440.GF11592@bombadil.infradead.org>
 <20190226161433.GH21626@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226161433.GH21626@magnolia>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 26, 2019 at 08:14:33AM -0800, Darrick J. Wong wrote:
> On Tue, Feb 26, 2019 at 06:04:40AM -0800, Matthew Wilcox wrote:
> > On Tue, Feb 26, 2019 at 09:42:48PM +0800, Ming Lei wrote:
> > > On Tue, Feb 26, 2019 at 05:02:30AM -0800, Matthew Wilcox wrote:
> > > > Wait, we're imposing a ridiculous amount of complexity on XFS for no
> > > > reason at all?  We should just change this to 512-byte alignment.  Tying
> > > > it to the blocksize of the device never made any sense.
> > > 
> > > OK, that is fine since we can fallback to buffered IO for loop in case of
> > > unaligned dio.
> > > 
> > > Then something like the following patch should work for all fs, could
> > > anyone comment on this approach?
> > 
> > That's not even close to what I meant.
> > 
> > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > index ec2fb6fe6d37..dee1fc47a7fc 100644
> > --- a/fs/direct-io.c
> > +++ b/fs/direct-io.c
> > @@ -1185,18 +1185,20 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
> 
> Wait a minute, are you all saying that /directio/ is broken on XFS too??
> XFS doesn't use blockdev_direct_IO anymore.
> 
> I thought we were talking about alignment of XFS metadata buffers
> (xfs_buf.c), which is a very different topic.
> 
> As I understand the problem, in non-debug mode the slab caches give
> xfs_buf chunks of memory that are aligned well enough to work, but in
> debug mode the slabs allocate slightly more bytes to carry debug
> information which pushes the returned address up slightly, thus breaking
> the alignment requirements.
> 
> So why can't we just move the debug info to the end of the object?  If
> our 512 byte allocation turns into a (512 + a few more) bytes we'll end
> up using 1024 bytes on the allocation regardless, so it shouldn't matter
> to put the debug info at offset 512.  If the reason is fear that kernel
> code will scribble off the end of the object, then return (*obj + 512).
> Maybe you all have already covered this, though?

I don't know _what_ Ming Lei is saying.  I thought the problem was
with slab redzones, which need to be before and after each object,
but apparently the problem is with KASAN as well.
