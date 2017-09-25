Return-Path: <hch@lst.de>
Date: Mon, 25 Sep 2017 17:07:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170925150720.GA11055@lst.de>
References: <20170925134031.10548-1-hch@lst.de> <20170925134031.10548-9-hch@lst.de> <1fb2f077-151a-b02f-2bf5-329ef5951a68@suse.de> <20170925135007.GA9725@lst.de> <55a10165-ac3c-f808-b031-6d907c314c30@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55a10165-ac3c-f808-b031-6d907c314c30@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 04:05:17PM +0200, Hannes Reinecke wrote:
> On 09/25/2017 03:50 PM, Christoph Hellwig wrote:
> > On Mon, Sep 25, 2017 at 03:47:43PM +0200, Hannes Reinecke wrote:
> >> Can't we make the multipath support invisible to the host?
> >> IE check the shared namespaces before creating the device node, and just
> >> move them under the existing namespaces if one exists?
> > 
> > That was what my first version did, but various people talked me
> > out of it.  Unfortunately just multiplexing breaks a few things,
> > including the userspace passthrough ioctls.
> > 
> Care to give some specifics?
> How would userspace passthrough be affected?

Because specific commands will have to go to the right controller and
not just any avaiable controller.  If we only expose a single node
for multipath there is no way to chose the specific one.
