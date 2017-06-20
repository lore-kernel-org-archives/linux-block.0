Return-Path: <BATV+36629bb5a09a6c0004be+5049+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 20 Jun 2017 05:56:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, adilger@dilger.ca,
	martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170620125620.GA26153@infradead.org>
References: <20170619185805.GC32047@infradead.org>
 <5259a1ba-1c5f-2d89-3b47-3a81cd0a3e4e@kernel.dk>
 <0c3c6a33-77c5-337e-66e0-49fe22d3cc4e@kernel.dk>
 <3e6f7b97-8372-b268-f55a-cc88812c1a68@kernel.dk>
 <20170620085739.GB31386@infradead.org>
 <6f1be22c-b172-3645-f0ab-8124188756df@kernel.dk>
 <20170620124355.GA6199@infradead.org>
 <6793e5b9-b324-727a-6227-69b5fe233bc4@kernel.dk>
 <20170620124738.GA16917@infradead.org>
 <6b1897c4-400b-faee-38d1-d677c054debc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6b1897c4-400b-faee-38d1-d677c054debc@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 20, 2017 at 06:51:34AM -0600, Jens Axboe wrote:
> That sounds fragile... Is it really worth it to avoid stealing three
> bits in the inode? Do we have buffer_heads attached everywhere, that
> sounds surprising to me.

I'm not concerned about saving a few bits - we'll use those elsewhere
anyway.  I'm concerned about settings on one file descriptor having
an effect on other fds that doesn't look intended.  It's not the
end of the world, as multiple writers to the same file should
better be aware of each other, but the semantics of setting these
on a per-inode level still stink.
