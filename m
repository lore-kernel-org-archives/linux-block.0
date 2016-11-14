Return-Path: <BATV+c89273d3eea146e66f74+4831+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 14 Nov 2016 09:37:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCHSET] Add support for simplified async direct-io
Message-ID: <20161114173728.GA22167@infradead.org>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1479144519-15738-1-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 14, 2016 at 10:28:37AM -0700, Jens Axboe wrote:
> This is on top of for-4.10/dio, which has Christophs simplified sync
> O_DIRECT support and the IO poll bits.
> 
> The restriction on 4 inline vecs is removed on the sync support, we
> just allocate the bio_vec array if we have to. I realize this negates
> parts of the win of the patch for sync, but it's still a lot leaner
> than the old code. And it means we use the same path for any type
> of sync O_DIRECT, instead of potentially bouncing between the two.
> 
> Second patch is adding async support for the code base. Lightly
> tested. Performance results, from fio:

І'd much rather add a separate path pased on the same scheme.  And
because I prefer that so much I actually did it a while ago, although
it will need some minor updates for the current tree:

	http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/new-dio

I'll see if I can get it quickly updated..
