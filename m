Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Subject: Re: [PATCH v2] block: Move SECTOR_SIZE and SECTOR_SHIFT definitions into <linux/blkdev.h>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180221192240.27836-1-bart.vanassche@wdc.com>
Date: Wed, 21 Feb 2018 22:21:24 -0500
In-Reply-To: <20180221192240.27836-1-bart.vanassche@wdc.com> (Bart Van
	Assche's message of "Wed, 21 Feb 2018 11:22:40 -0800")
Message-ID: <yq1mv01emkr.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> It happens often while I'm preparing a patch for a block driver that
> I'm wondering: is a definition of SECTOR_SIZE and/or SECTOR_SHIFT
> available for this driver? Do I have to introduce definitions of these
> constants before I can use these constants? To avoid this confusion,
> move the existing definitions of SECTOR_SIZE and SECTOR_SHIFT into the
> <linux/blkdev.h> header file such that these become available for all
> block drivers. Make the SECTOR_SIZE definition in the uapi msdos_fs.h
> header file conditional to avoid that including that header file after
> <linux/blkdev.h> causes the compiler to complain about a SECTOR_SIZE
> redefinition.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
