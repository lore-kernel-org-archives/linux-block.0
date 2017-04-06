Return-Path: <BATV+12db14f66c2b178d1d1f+4974+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 6 Apr 2017 11:22:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
	Eric Sandeen <sandeen@sandeen.net>,
	Christoph Hellwig <hch@infradead.org>,
	Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/6] RFC add blkdev tests v2
Message-ID: <20170406182252.GA31688@infradead.org>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
 <20170406135524.GA12230@infradead.org>
 <74f90aa0-bb3f-ba74-cdbc-d6e96be51376@kernel.dk>
 <20170406144741.GA27776@infradead.org>
 <bb45e36c-93af-9565-1dc0-a4850aec393c@kernel.dk>
 <20170406152000.GF3768@linux-x5ow.site>
 <b7b785ef-21a6-19f6-07c6-5dcc3053f274@sandeen.net>
 <20170406181555.GA8215@linux-x5ow.site>
 <b58871ff-2b34-acce-318c-479dccf4d596@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b58871ff-2b34-acce-318c-479dccf4d596@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 06, 2017 at 12:19:46PM -0600, Jens Axboe wrote:
> We share that goal. The block related tests will have _fewer_ dependencies.
> And it'll also be Linux only, so we don't have to worry about cross platform.

xfstests effectively has been Linux-only for many years.  We've just
been to lazy to remove the remaining IRIX bits..
