Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 2/7] sd: provide a new ata trim provisioning mode
Date: Mon, 27 Mar 2017 22:40:24 +0000
Message-ID: <1490654409.7897.15.camel@sandisk.com>
References: <20170320204319.12628-1-hch@lst.de>
	 <20170320204319.12628-3-hch@lst.de>
In-Reply-To: <20170320204319.12628-3-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-03-20 at 16:43 -0400, Christoph Hellwig wrote:
> +	case SD_LBP_ATA_TRIM:
> +		max_blocks =3D 65535 * (512 / sizeof(__le64));
> +		if (sdkp->device->ata_trim_zeroes_data)
> +			q->limits.discard_zeroes_data =3D 1;
> +		break;

Do we need a comment here that explains where the numbers 65535 and
512 come from?

> +	u64 sector =3D blk_rq_pos(rq) >> (ilog2(sdp->sector_size) - 9);
> +	u32 nr_sectors =3D blk_rq_sectors(rq) >> (ilog2(sdp->sector_size) - 9);

Please consider using logical_to_sectors() instead of open-coding this
function.

Thanks,

Bart.=
