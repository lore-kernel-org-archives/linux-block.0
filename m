Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 10 Jan 2018 08:55:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>,
	David Disseldorp <ddiss@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 1/2] block: fail op_is_write() requests to read-only
 partitions
Message-ID: <20180110165528.GB3084@infradead.org>
References: <1515601118-23192-1-git-send-email-idryomov@gmail.com>
 <1515601118-23192-2-git-send-email-idryomov@gmail.com>
 <854c55f9-280b-de02-0be4-6ee8534802c8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <854c55f9-280b-de02-0be4-6ee8534802c8@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 10, 2018 at 09:34:02AM -0700, Jens Axboe wrote:
> It's yet another check that adds part lookup and rcu lock/unlock in that
> path. Can we combine some of them? Make this part of the remap?  This
> overhead impacts every IO, let's not bloat it more than absolutely
> necessary.

Yes, we should be able to integrate this with the partition remap.
