Return-Path: <SRS0=QdhR=RA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F266C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Feb 2019 20:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634D82084D
	for <linux-block@archiver.kernel.org>; Mon, 25 Feb 2019 20:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBYU0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:26:37 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:19127 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbfBYU0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Feb 2019 15:26:37 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 26 Feb 2019 06:56:34 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gyMpa-0005O6-Rn; Tue, 26 Feb 2019 07:26:30 +1100
Date:   Tue, 26 Feb 2019 07:26:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Christopher Lameter <cl@linux.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via page_frag_alloc
Message-ID: <20190225202630.GG23020@dastard>
References: <20190225040904.5557-1-ming.lei@redhat.com>
 <20190225043648.GE23020@dastard>
 <5ad2ef83-8b3a-0a15-d72e-72652b807aad@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad2ef83-8b3a-0a15-d72e-72652b807aad@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 25, 2019 at 02:15:59PM +0100, Vlastimil Babka wrote:
> On 2/25/19 5:36 AM, Dave Chinner wrote:
> > On Mon, Feb 25, 2019 at 12:09:04PM +0800, Ming Lei wrote:
> >> XFS uses kmalloc() to allocate sector sized IO buffer.
> > ....
> >> Use page_frag_alloc() to allocate the sector sized buffer, then the
> >> above issue can be fixed because offset_in_page of allocated buffer
> >> is always sector aligned.
> > 
> > Didn't we already reject this approach because page frags cannot be
> > reused and that pages allocated to the frag pool are pinned in
> > memory until all fragments allocated on the page have been freed?
> 
> I don't know if you did, but it's certainly true., Also I don't think
> there's any specified alignment guarantee for page_frag_alloc().

We did, and the alignment guarantee would have come from all
fragments having an aligned size.

> What about kmem_cache_create() with align parameter? That *should* be
> guaranteed regardless of whatever debugging is enabled - if not, I would
> consider it a bug.

Yup, that's pretty much what was decided. The sticking point was
whether is should be block layer infrastructure (because the actual
memory buffer alignment is a block/device driver requirement not
visible to the filesystem) or whether "sector size alignement is
good enough for everyone".

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
