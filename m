Return-Path: <hch@lst.de>
Date: Tue, 17 Apr 2018 17:18:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Hannes Reinecke <hare@suse.com>,
	Shaun Tancheff <shaun@tancheff.com>, stable@vger.kernel.org
Subject: Re: [PATCH] block: Avoid executing a report or reset zones while a
	queue is frozen
Message-ID: <20180417151857.GA25646@lst.de>
References: <20180417010034.28676-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180417010034.28676-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 16, 2018 at 06:00:34PM -0700, Bart Van Assche wrote:
> This patch on itself does not change the behavior of either ioctl.
> However, this patch is necessary to avoid that these ioctls fail
> with -EIO if sd_revalidate_disk() is called while these ioctls are
> in progress because the current zoned block command code temporarily
> clears data that is needed by these ioctls. See also commit
> 3ed05a987e0f ("blk-zoned: implement ioctls").

Hmm.  I think we need to avoid clearing that data and update it using
RCU instead.  Calling blk_queue_enter before submitting bios is
something that would make zone reporting very different from any
other block layer user.
