Return-Path: <martin.petersen@oracle.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH v4 01/11] scsi: sd_zbc: Rearrange code
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20181012100850.23316-1-damien.lemoal@wdc.com>
	<20181012100850.23316-2-damien.lemoal@wdc.com>
Date: Tue, 16 Oct 2018 00:48:02 -0400
In-Reply-To: <20181012100850.23316-2-damien.lemoal@wdc.com> (Damien Le Moal's
	message of "Fri, 12 Oct 2018 19:08:40 +0900")
Message-ID: <yq18t2yv6nx.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Damien,

> Move the urswrz check out of sd_zbc_read_zones() and into
> sd_zbc_read_zoned_characteristics() where that value is obtained (read
> from the disk zoned characteristics VPD page). Since this function now
> does more than simply reading the VPD page, rename it to
> sd_zbc_check_zoned_characteristics().  Also fix the error message
> displayed when reading that VPD page fails.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
