Return-Path: <prvs=7864c2456=roger.pau@citrix.com>
Date: Wed, 12 Sep 2018 11:13:50 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Jan Beulich <JBeulich@suse.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe
	<axboe@kernel.dk>, xen-devel <xen-devel@lists.xenproject.org>, zhong jiang
	<zhongjiang@huawei.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] drivers/block/xen-blkback/common.h: use
 DIV_ROUND_UP instead of reimplementing its function
Message-ID: <20180912091350.6wuvt2jkvzg6wruo@mac.bytemobile.com>
References: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
 <5B98CAE202000078001E79CC@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5B98CAE202000078001E79CC@prv1-mh.provo.novell.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

Adding Julien how did the work to support XEN_PAGE_SIZE != PAGE_SIZE.

On Wed, Sep 12, 2018 at 02:14:26AM -0600, Jan Beulich wrote:
> >>> On 12.09.18 at 07:45, <zhongjiang@huawei.com> wrote:
> > --- a/drivers/block/xen-blkback/common.h
> > +++ b/drivers/block/xen-blkback/common.h
> > @@ -65,7 +65,7 @@
> >  	(XEN_PAGES_PER_INDIRECT_FRAME / XEN_PAGES_PER_SEGMENT)
> >  
> >  #define MAX_INDIRECT_PAGES \
> > -	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
> > +		DIV_ROUND_UP(MAX_INDIRECT_SEGMENTS, SEGS_PER_INDIRECT_FRAME)
> >  #define INDIRECT_PAGES(_segs) DIV_ROUND_UP(_segs, XEN_PAGES_PER_INDIRECT_FRAME)
> 
> My first reaction was to suggest
> 
> #define MAX_INDIRECT_PAGES INDIRECT_PAGES(MAX_INDIRECT_SEGMENTS)
> 
> but that wouldn't match what's there currently (note the two different
> divisors). I can't really decide whether that's just unfortunate naming
> of the two macros, or an actual bug.

I think there's indeed a bug here.

AFAICT, MAX_INDIRECT_PAGES should use XEN_PAGES_PER_INDIRECT_FRAME and
then it could be changed as Jan suggested.

Current MAX_INDIRECT_PAGES is misnamed and should instead be
MAX_INDIRECT_SEGS (which on x86 is exactly the same because PAGE_SIZE
== XEN_PAGE_SIZE).

Roger.
