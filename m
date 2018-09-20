Return-Path: <hch@lst.de>
Date: Thu, 20 Sep 2018 08:29:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
	xen-devel@lists.xen.org, linux-arm-kernel@lists.infradead.org
Subject: Re: clean up physical merging helpers
Message-ID: <20180920062946.GA12893@lst.de>
References: <20180904191431.20102-1-hch@lst.de> <20180915070300.GA10555@lst.de> <b8f3621a-f789-d737-649f-7b3645912888@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b8f3621a-f789-d737-649f-7b3645912888@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 15, 2018 at 08:47:13AM -0600, Jens Axboe wrote:
> >> this series moves various helpers related to merging based on physical
> >> addresses from the public headers into block/, moves the Xen special
> >> case from arch hooks into common code, cleans up the code a bit, and
> >> removes not nessecary includes from the block headers.
> > ---end quoted text---
> > 
> 
> It's a good cleanup, I like it. Would prefer if the arm/xen folks could
> ack the first bits,

Konread, can you look at the series (or delegate).

> and 13/13 should probably just to in differently.

I can't parse this setence.
