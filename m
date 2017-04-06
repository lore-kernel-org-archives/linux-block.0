Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55477 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932632AbdDFH2A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 03:28:00 -0400
Date: Thu, 6 Apr 2017 09:27:55 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block@vger.kernel.org, nbd-general@lists.sourceforge.net,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        netdev@vger.kernel.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 4/4] mtd: nand: nandsim: convert to memalloc_noreclaim_*()
Message-ID: <20170406072754.GC5497@dhcp22.suse.cz>
References: <20170405074700.29871-1-vbabka@suse.cz>
 <20170405074700.29871-5-vbabka@suse.cz>
 <20170405113157.GM6035@dhcp22.suse.cz>
 <ee6649ed-b0e8-1c59-c193-d1688fdfe7f5@nod.at>
 <9b9d5bca-e125-e07b-b700-196cc800bbd7@suse.cz>
 <fe1c21a4-0bc6-529c-5446-382b01d4c99e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fe1c21a4-0bc6-529c-5446-382b01d4c99e@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu 06-04-17 09:33:44, Adrian Hunter wrote:
> On 05/04/17 14:39, Vlastimil Babka wrote:
> > On 04/05/2017 01:36 PM, Richard Weinberger wrote:
> >> Michal,
> >>
> >> Am 05.04.2017 um 13:31 schrieb Michal Hocko:
> >>> On Wed 05-04-17 09:47:00, Vlastimil Babka wrote:
> >>>> Nandsim has own functions set_memalloc() and clear_memalloc() for robust
> >>>> setting and clearing of PF_MEMALLOC. Replace them by the new generic helpers.
> >>>> No functional change.
> >>>
> >>> This one smells like an abuser. Why the hell should read/write path
> >>> touch memory reserves at all!
> >>
> >> Could be. Let's ask Adrian, AFAIK he wrote that code.
> >> Adrian, can you please clarify why nandsim needs to play with PF_MEMALLOC?
> > 
> > I was thinking about it and concluded that since the simulator can be
> > used as a block device where reclaimed pages go to, writing the data out
> > is a memalloc operation. Then reading can be called as part of r-m-w
> > cycle, so reading as well.
> 
> IIRC it was to avoid getting stuck with nandsim waiting on memory reclaim
> and memory reclaim waiting on nandsim.

I've got lost in the indirection. Could you describe how would reclaim
get stuck waiting on these paths please?

-- 
Michal Hocko
SUSE Labs
