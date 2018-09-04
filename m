Return-Path: <hch@lst.de>
Date: Tue, 4 Sep 2018 20:46:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Dmitry Monakhov <dmonakhov@openvz.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.com>, linux-block@vger.kernel.org
Subject: Re: bvec_iter rewind API
Message-ID: <20180904184625.GA1782@lst.de>
References: <20180828233325.GA32495@kmo-pixel> <20180830112414.GA8186@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180830112414.GA8186@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 30, 2018 at 07:24:15PM +0800, Ming Lei wrote:
> I agree, and it isn't good to introduce extra update of .bi_done in fast path
> too, and it just makes things complicated in concept.
> 
> Maybe we can do the following way, and looks it works in scsi_debug/dix
> test.

Can you send that as a proper patch series?
