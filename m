Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Sun, 21 Aug 2016 09:58:44 -0800
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Ming Lei <ming.lei@canonical.com>
Cc: Eric Wheeler <bcache@lists.ewheeler.net>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Sebastian Roesner <sroesner-kernelorg@roesner-online.de>,
	"4.3+" <stable@vger.kernel.org>, Shaohua Li <shli@fb.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] block: make sure big bio is splitted into at most 256
 bvecs
Message-ID: <20160821175844.byt3lejy7mu5sohc@kmo-pixel>
References: <1471273882-3938-1-git-send-email-ming.lei@canonical.com>
 <20160815182328.GA13886@infradead.org>
 <20160815191253.cxbjui3mymrkpkz6@kmo-pixel>
 <alpine.LRH.2.11.1608181733110.10662@mail.ewheeler.net>
 <CACVXFVMDod01eDYxvd8_LXmXaNusz2gsQRywdNgi=Z+nJzzjTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVMDod01eDYxvd8_LXmXaNusz2gsQRywdNgi=Z+nJzzjTA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Aug 21, 2016 at 05:31:33PM +0800, Ming Lei wrote:
> This patch is definitely correct, and I don't see dealing with 'no_merge'
> should be removed.
> 
> In this case, the bio is still possible to merge with others because
> it doesn't violate any limit of the queue because it just can't be held in
> 256 bvecs, that means it is correct to clear no_merge for this situation.
> 
> Also I don't think it is complicated or ugly to deal with the flag.

It's extra unnecessary code. All other things being equal, less code is always
better than more code. It works just fine without it, what's the justification
for adding the flag?

Don't be so dismissive of other maintainer's concerns, we've got to deal with
this code too. Especially when I and Christoph are agreeing on something - how
often does that happen?
