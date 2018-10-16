Return-Path: <martin.petersen@oracle.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH v4 03/11] scsi: sd_zbc: Fix sd_zbc_check_zones() error checks
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20181012100850.23316-1-damien.lemoal@wdc.com>
	<20181012100850.23316-4-damien.lemoal@wdc.com>
Date: Tue, 16 Oct 2018 00:51:47 -0400
In-Reply-To: <20181012100850.23316-4-damien.lemoal@wdc.com> (Damien Le Moal's
	message of "Fri, 12 Oct 2018 19:08:42 +0900")
Message-ID: <yq1zhvetrx8.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Damien,

> The unsigned 32 bits overflow check for the zone size value is already
> done within sd_zbc_check_zones() with the test:
>
> } else if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {
>
> so there is no need to check again for an out of range value in
> sd_zbc_read_zones(). Simplify the code and fix sd_zbc_check_zones()
> error return to -EFBIG instead of -ENODEV if the zone size is too large.
> Change the return type of sd_zbc_check_zones() to an int for the error
> code and return the zone size (zone_blocks) through a u32 pointer to
> avoid overflowing the signed 32 return value.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
