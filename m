Return-Path: <JBeulich@suse.com>
Message-Id: <5B98CAE202000078001E79CC@prv1-mh.provo.novell.com>
Date: Wed, 12 Sep 2018 02:14:26 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Roger Pau Monne" <roger.pau@citrix.com>,
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Cc: "zhong jiang" <zhongjiang@huawei.com>,
 "Jens Axboe" <axboe@kernel.dk>,
 "xen-devel" <xen-devel@lists.xenproject.org>,
 <linux-block@vger.kernel.org>,<linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] drivers/block/xen-blkback/common.h:
 use DIV_ROUND_UP instead of reimplementing its function
References: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

>>> On 12.09.18 at 07:45, <zhongjiang@huawei.com> wrote:
> --- a/drivers/block/xen-blkback/common.h
> +++ b/drivers/block/xen-blkback/common.h
> @@ -65,7 +65,7 @@
>  	(XEN_PAGES_PER_INDIRECT_FRAME / XEN_PAGES_PER_SEGMENT)
> =20
>  #define MAX_INDIRECT_PAGES \
> -	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_IND=
IRECT_FRAME)
> +		DIV_ROUND_UP(MAX_INDIRECT_SEGMENTS, SEGS_PER_INDIRECT_FRAME=
)
>  #define INDIRECT_PAGES(_segs) DIV_ROUND_UP(_segs, XEN_PAGES_PER_INDIRECT=
_FRAME)

My first reaction was to suggest

#define MAX_INDIRECT_PAGES INDIRECT_PAGES(MAX_INDIRECT_SEGMENTS)

but that wouldn't match what's there currently (note the two different
divisors). I can't really decide whether that's just unfortunate naming
of the two macros, or an actual bug.

Jan
