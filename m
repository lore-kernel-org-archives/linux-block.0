Return-Path: <hch@lst.de>
Date: Mon, 25 Sep 2017 15:50:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170925135007.GA9725@lst.de>
References: <20170925134031.10548-1-hch@lst.de> <20170925134031.10548-9-hch@lst.de> <1fb2f077-151a-b02f-2bf5-329ef5951a68@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1fb2f077-151a-b02f-2bf5-329ef5951a68@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 03:47:43PM +0200, Hannes Reinecke wrote:
> Can't we make the multipath support invisible to the host?
> IE check the shared namespaces before creating the device node, and just
> move them under the existing namespaces if one exists?

That was what my first version did, but various people talked me
out of it.  Unfortunately just multiplexing breaks a few things,
including the userspace passthrough ioctls.
