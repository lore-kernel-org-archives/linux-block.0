Return-Path: <martin.petersen@oracle.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>,
        Damien Le Moal <damien.lemoal@hgst.com>
Subject: Re: [PATCH v8 6/7] sd: Implement support for ZBC devices
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1476772835-18541-1-git-send-email-damien.lemoal@wdc.com>
	<1476772835-18541-7-git-send-email-damien.lemoal@wdc.com>
Date: Tue, 18 Oct 2016 20:47:14 -0400
In-Reply-To: <1476772835-18541-7-git-send-email-damien.lemoal@wdc.com> (Damien
	Le Moal's message of "Tue, 18 Oct 2016 15:40:34 +0900")
Message-ID: <yq1pomxf9m5.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

>>>>> "Damien" == Damien Le Moal <damien.lemoal@wdc.com> writes:

Damien> Implement ZBC support functions to setup zoned disks, both
Damien> host-managed and host-aware models. Only zoned disks that
Damien> satisfy the following conditions are supported:
Damien> 1) All zones are the same size, with the exception of an
Damien>    eventual last smaller runt zone.
Damien> 2) For host-managed disks, reads are unrestricted (reads are not
Damien>    failed due to zone or write pointer alignement constraints).
Damien> Zoned disks that do not satisfy these 2 conditions are setup
Damien> with a capacity of 0 to prevent their use.

Damien> The function sd_zbc_read_zones, called from sd_revalidate_disk,
Damien> checks that the device satisfies the above two constraints. This
Damien> function may also change the disk capacity previously set by
Damien> sd_read_capacity for devices reporting only the capacity of
Damien> conventional zones at the beginning of the LBA range
Damien> (i.e. devices reporting rc_basis set to 0).

Damien> The capacity message output was moved out of sd_read_capacity
Damien> into a new function sd_print_capacity to include this eventual
Damien> capacity change by sd_zbc_read_zones. This new function also
Damien> includes a call to sd_zbc_print_zones to display the number of
Damien> zones and zone size of the device.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
