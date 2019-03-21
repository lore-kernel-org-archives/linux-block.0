Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00DBC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 02:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDEE218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 02:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LJBelv/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCUCYF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:24:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfCUCYE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 22:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VeDSfNZVcKF/dmMd18yaoimKM6Z0qfa8XNDM5mZkkgM=; b=LJBelv/NWrJP+46sNa0Z0Cxvm
        Wfe6QsPQy3cLQeSqK18OOxmRL4ocKWa1kpssRKzWLWThOItpi0fQsmjWau7ObsaO14iFhD8LvPVDV
        3TNYfRczHJ52/nnWnMukdEvMXIEtu4gnUhE27YHTjnUzWgAbc3g91Np08MiV5f3DdJJg/7auDFG1u
        ut2WxSoDVNcb5g0jaANLgtFLRISck2fV34uP/kQae4h9lG4sjmEHpKQjLiJHWC3ujqf+9kYzJUvjH
        9uz5Uc+Y+3flPehLFAbvQnp4y0pAZQ6VCBal9pnL7jRGOgoLmT5RO/s8XVy+6rJZykRd5DvwXNAE+
        SLUxRCAkg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6nN5-0005Us-Vg; Thu, 21 Mar 2019 02:23:55 +0000
Date:   Wed, 20 Mar 2019 19:23:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christopher Lameter <cl@linux.com>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [RFC 0/2] guarantee natural alignment for kmalloc()
Message-ID: <20190321022355.GA19508@bombadil.infradead.org>
References: <20190319211108.15495-1-vbabka@suse.cz>
 <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com>
 <5d7fee9c-1a80-6ac9-ac1d-b1ce05ed27a8@suse.cz>
 <20190320185347.GZ19508@bombadil.infradead.org>
 <b5290e04-6f29-c237-78a7-511821183efe@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5290e04-6f29-c237-78a7-511821183efe@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 20, 2019 at 10:48:03PM +0100, Vlastimil Babka wrote:
> On 3/20/2019 7:53 PM, Matthew Wilcox wrote:
> > On Wed, Mar 20, 2019 at 09:48:47AM +0100, Vlastimil Babka wrote:
> >> Natural alignment to size is rather well defined, no? Would anyone ever
> >> assume a larger one, for what reason?
> >> It's now where some make assumptions (even unknowingly) for natural
> >> There are two 'odd' sizes 96 and 192, which will keep cacheline size
> >> alignment, would anyone really expect more than 64 bytes?
> > 
> > Presumably 96 will keep being aligned to 32 bytes, as aligning 96 to 64
> > just results in 128-byte allocations.
> 
> Well, looks like that's what happens. This is with SLAB, but the alignment
> calculations should be common: 
> 
> slabinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
> kmalloc-96          2611   4896    128   32    1 : tunables  120   60    8 : slabdata    153    153      0
> kmalloc-128         4798   5536    128   32    1 : tunables  120   60    8 : slabdata    173    173      0

Hmm.  On my laptop, I see:

kmalloc-96         28050  35364     96   42    1 : tunables    0    0    0 : slabdata    842    842      0

That'd take me from 842 * 4k pages to 1105 4k pages -- an extra megabyte of
memory.

This is running Debian's 4.19 kernel:

# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_CPU_PARTIAL=y


