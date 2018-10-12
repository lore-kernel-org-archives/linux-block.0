Return-Path: <prvs=816489328=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>, Mike Snitzer <snitzer@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH v3 02/11] scsi: sd_zbc: Reduce boot device scan and
 revalidate time
Date: Fri, 12 Oct 2018 07:48:52 +0000
Message-ID: 
 <BLUPR0401MB1636734D5CFE4AA338925BF6E7E20@BLUPR0401MB1636.namprd04.prod.outlook.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-3-damien.lemoal@wdc.com>
 <d851a895-0340-1d8a-9aa8-1abc902be337@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 2018/10/12 16:33, Hannes Reinecke wrote:=0A=
> On 10/12/18 4:30 AM, Damien Le Moal wrote:=0A=
>> Handling checks of ZBC device capacity using the max_lba field of the=0A=
>> REPORT ZONES command reply for disks with rc_basis =3D=3D 0 can be done=
=0A=
>> using the same report zones command reply used to check the "same"=0A=
>> field.=0A=
>>=0A=
>> Avoid executing a report zones command solely to check the disk capacity=
=0A=
>> by merging sd_zbc_check_capacity() into sd_zbc_check_zone_size() and=0A=
>> renaming that function to sd_zbc_check_zones(). This removes a costly=0A=
>> execution of a full report zones command and so reduces device scan=0A=
>> duration at boot time as well as the duration of disk revalidate calls.=
=0A=
>>=0A=
>> Furthermore, setting the partial report bit in the REPORT ZONES command=
=0A=
>> cdb can significantly reduce this command execution time as the device=
=0A=
>> does not have to count and report the total number of zones that could=
=0A=
>> be reported assuming a large enough reply buffer. A non-partial zone=0A=
>> report is necessary only for the first execution of report zones used to=
=0A=
>> check the same field value (to ensure that this value applies to all=0A=
>> zones of the disk). All other calls to sd_zbc_report_zones() can use a=
=0A=
>> partial report to reduce execution time.=0A=
>>=0A=
>> Using a 14 TB ZBC disk, these simple changes reduce device scan time at=
=0A=
>> boot from about 3.5s down to about 900ms. Disk revalidate times are also=
=0A=
>> reduced from about 450ms down to 230ms.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
>> ---=0A=
>>   drivers/scsi/sd_zbc.c | 94 ++++++++++++++++++-------------------------=
=0A=
>>   1 file changed, 40 insertions(+), 54 deletions(-)=0A=
>>=0A=
> Reviewed-by: Hannes Reinecke <hare@suse.com>=0A=
> =0A=
> ... and it'll be your fault if there are drives which do not support the =
=0A=
> 'partial' bit :)=0A=
=0A=
The partial bit definition is in the ZBC/ZAC specs and it is not optional. =
If a=0A=
drive does not support it, it would be out of specs :)=0A=
=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Hannes=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
