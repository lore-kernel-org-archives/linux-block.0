Return-Path: <hch@lst.de>
Date: Mon, 18 Sep 2017 02:17:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme
	subsystems
Message-ID: <20170918001736.GA4441@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-11-hch@lst.de> <20170829145417.GA4428@localhost.localdomain> <20170829145559.GA32760@lst.de> <20170829154138.GB4428@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829154138.GB4428@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 29, 2017 at 11:41:38AM -0400, Keith Busch wrote:
> Speaking of timeouts, nvme_req_needs_retry will fail the command
> immediately rather than try the alternate path if it was cancelled due
> to timeout handling. Should we create a new construct for a command's
> total time separate from recovery timeout so we may try an alternate
> paths?

We probably need to anyway, see the discussion with James in the
other thread.
