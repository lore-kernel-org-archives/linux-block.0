Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E24C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 13:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B245A20651
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 13:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dm/Icpah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfBZNCe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:02:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfBZNCd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 08:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iCmFmWiV3xb5AOVJB0XEU/x7knedJSI2kLqY2YUO43c=; b=Dm/IcpahO0ZOhqdZYsO+RF9de
        HcWTIk0ykKJwiCQ7ClRXTt33MZpvZJoBiDPktX7H6P3wZ9EX7UPTWEa50nDi8oiuAI/yvXUXWqYBO
        3fjWdTdySwFhkitqGJ/aJDr2WJQ58BtyHaJqEydY95E1cKqnddoPiM9ZhuzewlzohU1M5pwa9Bt5B
        G44IAyEGHk28DfhE/IfTiTb/YDRUCfaxPfITn/rb+RVNijE8duubfXeLZNga198lOoywJnnYxLWvK
        bVa//J7t3actOLmik7JsKmn2/VnIZ6f6eA+X40kB8DVFx+415kByOpzltDAoIp69vbtdt3RGrlTQf
        0Qlpp3tXA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gycNS-0005tY-Bt; Tue, 26 Feb 2019 13:02:30 +0000
Date:   Tue, 26 Feb 2019 05:02:30 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <20190226130230.GD11592@bombadil.infradead.org>
References: <20190225202630.GG23020@dastard>
 <20190226022249.GA17747@ming.t460p>
 <20190226030214.GI23020@dastard>
 <20190226032737.GA11592@bombadil.infradead.org>
 <20190226045826.GJ23020@dastard>
 <20190226093302.GA24879@ming.t460p>
 <a641feb8-ceb2-2dac-27aa-7b1df10f5ae5@suse.cz>
 <CACVXFVMX=WpTRBbDTSibfXkTZxckk3ootetbE+rkJtHhsZkRAw@mail.gmail.com>
 <20190226121209.GC11592@bombadil.infradead.org>
 <20190226123545.GA6163@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226123545.GA6163@ming.t460p>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 26, 2019 at 08:35:46PM +0800, Ming Lei wrote:
> On Tue, Feb 26, 2019 at 04:12:09AM -0800, Matthew Wilcox wrote:
> > On Tue, Feb 26, 2019 at 07:12:49PM +0800, Ming Lei wrote:
> > > The buffer needs to be device block size aligned for dio, and now the block
> > > size can be 512, 1024, 2048 and 4096.
> > 
> > Why does the block size make a difference?  This requirement is due to
> > some storage devices having shoddy DMA controllers.  Are you saying there
> > are devices which can't even do 512-byte aligned I/O?
> 
> Direct IO requires that, see do_blockdev_direct_IO().
> 
> This issue can be triggered when running xfs over loop/dio. We could
> fallback to buffered IO under this situation, but not sure it is the
> only case.

Wait, we're imposing a ridiculous amount of complexity on XFS for no
reason at all?  We should just change this to 512-byte alignment.  Tying
it to the blocksize of the device never made any sense.
