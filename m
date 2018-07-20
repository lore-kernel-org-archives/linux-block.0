Return-Path: <keith.busch@linux.intel.com>
Date: Fri, 20 Jul 2018 08:50:12 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] scsi: set timed out out mq requests to complete
Message-ID: <20180720145011.GD4093@localhost.localdomain>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
 <20180720144146.GA22454@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180720144146.GA22454@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 20, 2018 at 07:41:46AM -0700, Christoph Hellwig wrote:
> Has this been tested?  Especially with the blk_abort_request corner
> case?

Yes, that's what Jianchao's modification to scsi_debug used.
