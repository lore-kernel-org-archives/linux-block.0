Return-Path: <hch@lst.de>
Date: Mon, 8 Jan 2018 16:34:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Keith Busch <keith.busch@intel.com>,
	Linux Block <linux-block@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Device Mapper <dm-devel@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Bart VanAssche <bart.vanassche@wdc.com>,
	James Smart <james.smart@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/5] nvme: Add more command status translation
Message-ID: <20180108153436.GA11632@lst.de>
References: <20180104224623.8944-1-keith.busch@intel.com> <20180104224623.8944-2-keith.busch@intel.com> <20180108095512.GC4673@lst.de> <2beb72a9-8502-fec8-8892-208cbb0967ac@suse.com> <20180108101937.GA5423@lst.de> <20180108152933.GA9920@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180108152933.GA9920@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 08, 2018 at 10:29:33AM -0500, Mike Snitzer wrote:
> No argument needed.  Definitely needs fixing.  Too many upper layers
> consider BLK_STS_NOSPC retryable (XFS, ext4, dm-thinp, etc).  Which
> NVME_SC_LBA_RANGE absolutely isn't.
> 
> When I backfilled NVME_SC_LBA_RANGE handling I categorized it as
> BLK_STS_TARGET.  Do you have a better suggestion for how
> NVME_SC_LBA_RANGE should be categorized?

It's basically a kernel bug as it tries to access lbas that do not
exist.  BLK_STS_TARGET should be fine.
