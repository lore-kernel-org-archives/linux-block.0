Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 13 Jan 2017 08:01:05 -0700
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	osandov@osandov.com, bart.vanassche@sandisk.com
Subject: Re: [PATCH 05/10] blk-mq: export some helpers we need to the
 scheduling framework
Message-ID: <20170113150105.GB23338@kernel.dk>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-6-git-send-email-axboe@fb.com>
 <20170113081714.GC637@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170113081714.GC637@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 13 2017, Christoph Hellwig wrote:
> Do we really need to make any of the blk-mq scheduling modular?

I think so - I want to be able to turn it on and off. And since we
already have a framework for this (see reply in other patch), I don't
see a reason NOT to do this.

-- 
Jens Axboe
