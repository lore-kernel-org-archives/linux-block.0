Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1539190406.195557.4.camel@acm.org>
Subject: Re: [dm-devel] [PATCH 06/11] block: Introduce BLKGETZONESZ ioctl
From: Bart Van Assche <bvanassche@acm.org>
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org, "Martin K .
 Petersen" <martin.petersen@oracle.com>, dm-devel@redhat.com, Mike Snitzer
 <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matias Bjorling <matias.bjorling@wdc.com>
Date: Wed, 10 Oct 2018 09:53:26 -0700
In-Reply-To: <20181010015239.24930-7-damien.lemoal@wdc.com>
References: <20181010015239.24930-1-damien.lemoal@wdc.com>
	 <20181010015239.24930-7-damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-10-10 at 10:52 +-0900, Damien Le Moal wrote:
+AD4  +ACM-define BLKREPORTZONE	+AF8-IOWR(0x12, 130, struct blk+AF8-zone+AF8-report)
+AD4  +ACM-define BLKRESETZONE	+AF8-IOW(0x12, 131, struct blk+AF8-zone+AF8-range)
+AD4 +-+ACM-define BLKGETZONESZ	+AF8-IOW(0x12, 132, unsigned int)

>From Documentation/ioctl/botching-up-ioctls.txt, a collection of lessons learned
the hard way about ioctls:

 +ACo Only use fixed sized integers. To avoid conflicts with typedefs in userspace
   the kernel has special types like +AF8AXw-u32, +AF8AXw-s64. Use them.

Please follow that advice.

Thanks,

Bart.
