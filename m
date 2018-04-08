Return-Path: <willy@infradead.org>
Date: Sun, 8 Apr 2018 12:08:25 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hare@suse.com" <hare@suse.com>,
	"martin@lichtvoll.de" <martin@lichtvoll.de>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Block layer use of __GFP flags
Message-ID: <20180408190825.GC5704@bombadil.infradead.org>
References: <20180408065425.GD16007@bombadil.infradead.org>
 <aea2f6bcae3fe2b88e020d6a258706af1ce1a58b.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aea2f6bcae3fe2b88e020d6a258706af1ce1a58b.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 08, 2018 at 04:40:59PM +0000, Bart Van Assche wrote:
> __GFP_KSWAPD_RECLAIM wasn't stripped off on purpose for non-atomic
> allocations. That was an oversight. 

OK, good.

> Do you perhaps want me to prepare a patch that makes blk_get_request() again
> respect the full gfp mask passed as third argument to blk_get_request()?

I think that would be a good idea.  If it's onerous to have extra arguments,
there are some bits in gfp_flags which could be used for your purposes.
