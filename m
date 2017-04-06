Return-Path: <BATV+12db14f66c2b178d1d1f+4974+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 6 Apr 2017 07:47:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/6] RFC add blkdev tests v2
Message-ID: <20170406144741.GA27776@infradead.org>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
 <20170406135524.GA12230@infradead.org>
 <74f90aa0-bb3f-ba74-cdbc-d6e96be51376@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <74f90aa0-bb3f-ba74-cdbc-d6e96be51376@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 06, 2017 at 08:33:55AM -0600, Jens Axboe wrote:
> That is exactly what my recommendation was at lsfmm as well - fork
> xfstest, prune bits we don't need, and off we go. I'll get around to
> it soonish.

So you volunteer to do it?  I was -><- this close to offering it myself,
and than thought of all the other backlog I have on my plate :)
