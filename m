Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388414AbeGXSuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jul 2018 14:50:18 -0400
Date: Tue, 24 Jul 2018 10:42:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: data corruption with 'splt' workload to XFS on DM cache with its
 3 underlying devices being on same NVMe device
Message-ID: <20180724174241.GA828@infradead.org>
References: <20180723163357.GA29658@redhat.com>
 <e761830f-e3f7-3e88-1697-b4b150e84e5f@suse.de>
 <20180724130703.GA30804@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180724130703.GA30804@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 24, 2018 at 09:07:03AM -0400, Mike Snitzer wrote:
> True.  We only ever support mapping the partitions ontop of
> request-based multipath (via dm-linear volumes created by kpartx).
> 
> > So, have you tested that request-based multipathing works on a
> > partition _at all_? I'm not sure if partition mapping is done
> > correctly here; we never remap the start of the request (nor bio,
> > come to speak of it), so it looks as if we would be doing the wrong
> > things here.
> > 
> > Have you checked that partition remapping is done correctly?
> 
> It clearly doesn't work.  Not quite following why but...

blk_insert_cloned_request seems to be missing a call to
blk_partition_remap.  Given that no one but dm-multipath uses this
request clone insert helper, and people generally run multipath on
the whole device this is a code path that is almost never exercised.
