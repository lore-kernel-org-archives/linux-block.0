Return-Path: <martin.petersen@oracle.com>
To: Greg Edwards <gedwards@ddn.com>
Cc: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 2/2] scsi: virtio_scsi: fix pi_bytes{out,in} on 4 KiB block size devices
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180725142259.20562-1-gedwards@ddn.com>
	<20180725142259.20562-3-gedwards@ddn.com>
Date: Wed, 25 Jul 2018 21:46:07 -0400
In-Reply-To: <20180725142259.20562-3-gedwards@ddn.com> (Greg Edwards's message
	of "Wed, 25 Jul 2018 10:22:59 -0400")
Message-ID: <yq1zhye22hs.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Greg,

> The current calculation for pi_bytes{out,in} assumes a 512 byte logical
> block size and a protection interval exponent of 0, i.e. 512 bytes data
> + 8 bytes PI.

The block layer always deals with units of 512 bytes. Regardless of the
underlying logical block size.

> When run on a 4 KiB logical block size device with a protection
> interval exponent of 0, i.e. 4096 bytes data + 8 bytes PI, the driver
> miscalculates the pi_bytes{out,in} by a factor of 8x (64 bytes).

> @@ -513,12 +513,12 @@ static void virtio_scsi_init_hdr_pi(struct virtio_device *vdev,
>  
>  	if (sc->sc_data_direction == DMA_TO_DEVICE)
>  		cmd_pi->pi_bytesout = cpu_to_virtio32(vdev,
> -							blk_rq_sectors(rq) *
> -							bi->tuple_size);
> +							bio_integrity_bytes(bi,
> +							blk_rq_sectors(rq)));

The formatting/alignment could be improved here. Otherwise OK.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
