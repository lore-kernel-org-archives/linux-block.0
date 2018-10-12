Return-Path: <hare@suse.de>
Subject: Re: [PATCH v3 02/11] scsi: sd_zbc: Reduce boot device scan and
 revalidate time
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, dm-devel@redhat.com,
 Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matias Bjorling <matias.bjorling@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-3-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d851a895-0340-1d8a-9aa8-1abc902be337@suse.de>
Date: Fri, 12 Oct 2018 09:33:23 +0200
MIME-Version: 1.0
In-Reply-To: <20181012023012.29923-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:30 AM, Damien Le Moal wrote:
> Handling checks of ZBC device capacity using the max_lba field of the
> REPORT ZONES command reply for disks with rc_basis == 0 can be done
> using the same report zones command reply used to check the "same"
> field.
> 
> Avoid executing a report zones command solely to check the disk capacity
> by merging sd_zbc_check_capacity() into sd_zbc_check_zone_size() and
> renaming that function to sd_zbc_check_zones(). This removes a costly
> execution of a full report zones command and so reduces device scan
> duration at boot time as well as the duration of disk revalidate calls.
> 
> Furthermore, setting the partial report bit in the REPORT ZONES command
> cdb can significantly reduce this command execution time as the device
> does not have to count and report the total number of zones that could
> be reported assuming a large enough reply buffer. A non-partial zone
> report is necessary only for the first execution of report zones used to
> check the same field value (to ensure that this value applies to all
> zones of the disk). All other calls to sd_zbc_report_zones() can use a
> partial report to reduce execution time.
> 
> Using a 14 TB ZBC disk, these simple changes reduce device scan time at
> boot from about 3.5s down to about 900ms. Disk revalidate times are also
> reduced from about 450ms down to 230ms.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/sd_zbc.c | 94 ++++++++++++++++++-------------------------
>   1 file changed, 40 insertions(+), 54 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

... and it'll be your fault if there are drives which do not support the 
'partial' bit :)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
