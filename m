Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C5DC10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 11:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396E220811
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 11:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AzHNBn3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfDYLeB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:34:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfDYLeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 07:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2P/OrI6qmGjUCFCbm+VB2UcrjfJxvO5JKLdQJTO3M7w=; b=AzHNBn3peLU6Lo27trPd6sx3t
        3E8gWwtce0okQhV+//69KaJ+mcOtBJb1D8fHcMxa4RWb4/sbSL2TLg6wt7pxkQXUzZbZpCI2PADBo
        k/3PaEKNpyWKqsHMVDo5y06JNeS6OAHRlQ99TZ9gt4LXXVakOwzOCYRt8DxB++uTa/Oziwfo22+9u
        DfuWoFh3KIAgwHURpPHv1NbZaalK5Rsbhtqp8KqMypqVLz3aCRjSVeXNHcRKw1P+aRkzH52Gc4+2N
        WLu6Ns80arNv+sJrHdidazBEg4Jzj4jWcTophB6LzkAGu9wvSeB9bITNBNRcyuW4S/qVzAMHlTRDC
        YC0Qfzefw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJcdb-0000Pj-6e; Thu, 25 Apr 2019 11:33:59 +0000
Date:   Thu, 25 Apr 2019 04:33:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     lsf-pc@lists.linux-foundation.org,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [LSF/MM TOPIC] guarantee natural alignment for kmalloc()?
Message-ID: <20190425113358.GI19031@bombadil.infradead.org>
References: <790b68b7-3689-0ff6-08ae-936728bc6458@suse.cz>
 <20190411132819.GB22763@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411132819.GB22763@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 11, 2019 at 06:28:19AM -0700, Matthew Wilcox wrote:
> On Thu, Apr 11, 2019 at 02:52:08PM +0200, Vlastimil Babka wrote:
> > In the session I hope to resolve the question whether this is indeed the
> > right thing to do for all kmalloc() users, without an explicit alignment
> > requests, and if it's worth the potentially worse
> > performance/fragmentation it would impose on a hypothetical new slab
> > implementation for which it wouldn't be optimal to split power-of-two
> > sized pages into power-of-two-sized objects (or whether there are any
> > other downsides).
> 
> I think this is exactly the kind of discussion that LSFMM is for!  It's
> really a whole-system question; is Linux better-off having the flexibility
> for allocators to return non-power-of-two aligned memory, or allowing
> consumers of the kmalloc API to assume that "sufficiently large" memory
> is naturally aligned.

This has been scheduled for only the MM track.  I think at least the
filesystem people should be involved in this discussion since it's for
their benefit.

Do we have an lsf-discuss mailing list this year?  Might be good to
coordinate arrivals / departures for taxi sharing purposes.
