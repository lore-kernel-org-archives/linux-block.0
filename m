Return-Path: <hch@lst.de>
Date: Mon, 8 Jan 2018 10:58:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux Block <linux-block@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Device Mapper <dm-devel@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Bart VanAssche <bart.vanassche@wdc.com>,
	James Smart <james.smart@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/5] block: Provide blk_status_t decoding for retryable
	errors
Message-ID: <20180108095801.GE4673@lst.de>
References: <20180104224623.8944-1-keith.busch@intel.com> <20180104224623.8944-4-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180104224623.8944-4-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

> +static inline bool blk_retryable(blk_status_t error)

The naming isn't really useful - it is about the fact that it's
worth retrying on another path.  So please chose a better name,
and add a kerneldoc comment describing it.
