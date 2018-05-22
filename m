Return-Path: <hch@lst.de>
Date: Tue, 22 May 2018 17:19:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [RFC PATCH 1/3] blk-mq: Reference count request usage
Message-ID: <20180522151937.GA18664@lst.de>
References: <20180521231131.6685-1-keith.busch@intel.com> <20180521231131.6685-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521231131.6685-2-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 21, 2018 at 05:11:29PM -0600, Keith Busch wrote:
> This patch adds a struct kref to struct request so that request users
> can be sure they're operating on the same request without it changing
> while they're processing it. The request's tag won't be released for
> reuse until the last user is done with it.

Can you please use a raw refcount_t instead of the kref?  That avoids
a possible indirect call in the fast path, which have become really
painful with the spectre mitigrations, and also is easier to follow
to start with.

I also think this should be merged into patch 3, as it isn't very
useful on its own.
