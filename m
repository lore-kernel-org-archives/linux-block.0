Return-Path: <hch@lst.de>
Date: Mon, 14 May 2018 16:38:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@wdc.com, willy@infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: fix confusion around GFP_* flags and blk_get_request
Message-ID: <20180514143802.GA28197@lst.de>
References: <20180509075408.16388-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180509075408.16388-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Jens, any comments?

On Wed, May 09, 2018 at 09:54:02AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series sorts out the mess around how we use gfp flags in the
> block layer get_request interface.
> 
> Changes since RFC:
>   - don't switch to GFP_NOIO for allocations in blk_get_request.
>     blk_get_request is used by the multipath code in potentially dead lock
>     prone areas, so this will need a separate audit and maybe a flag.
---end quoted text---
