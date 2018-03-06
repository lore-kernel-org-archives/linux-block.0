Return-Path: <ming.lei@redhat.com>
Date: Tue, 6 Mar 2018 11:33:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@kernel.org" <shli@kernel.org>,
	"kkc6196@fb.com" <kkc6196@fb.com>,
	"zhangweiping@didichuxing.com" <zhangweiping@didichuxing.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: null_blk: fix 'Invalid parameters' failure when
 loading module
Message-ID: <20180306033335.GC32123@ming.t460p>
References: <20180303022436.11444-1-ming.lei@redhat.com>
 <1520265426.2826.2.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520265426.2826.2.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 05, 2018 at 03:57:07PM +0000, Bart Van Assche wrote:
> On Sat, 2018-03-03 at 10:24 +0800, Ming Lei wrote:
> >  struct nullb_page {
> >  	struct page *page;
> > -	unsigned long bitmap;
> > +	unsigned long bitmap[DIV_ROUND_UP(MAP_SZ, sizeof(unsigned long) * 8)];
> >  };
> 
> Could DECLARE_BITMAP() have been used here?

Indeed, will do it in V2.

Thanks,
Ming
