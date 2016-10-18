Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v8 2/7] blk-sysfs: Add 'chunk_sectors' to sysfs attributes
To: Jeff Moyer <jmoyer@redhat.com>
References: <1476772835-18541-1-git-send-email-damien.lemoal@wdc.com>
 <1476772835-18541-3-git-send-email-damien.lemoal@wdc.com>
 <x49funtvca2.fsf@segfault.boston.devel.redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, Shaun
 Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@hgst.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <d391589a-6e87-3679-7b38-cddbf0125801@wdc.com>
Date: Wed, 19 Oct 2016 08:17:21 +0900
MIME-Version: 1.0
In-Reply-To: <x49funtvca2.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>


Jeff,

On 10/19/16 01:43, Jeff Moyer wrote:
> Damien Le Moal <damien.lemoal@wdc.com> writes:
> =

>> diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/t=
esting/sysfs-block
>> index 75a5055..ee2d5cd 100644
>> --- a/Documentation/ABI/testing/sysfs-block
>> +++ b/Documentation/ABI/testing/sysfs-block
>> @@ -251,3 +251,16 @@ Description:
>>  		since drive-managed zoned block devices do not support
>>  		zone commands, they will be treated as regular block
>>  		devices and zoned will report "none".
>> +
>> +What:		/sys/block/<disk>/queue/chunk_sectors
>> +Date:		September 2016
>> +Contact:	Hannes Reinecke <hare@suse.com>
>> +Description:
>> +		chunk_sectors has different meaning depending on the type
>> +		of the disk. For a RAID device (dm-raid), chunk_sectors
>> +		indicates the size in 512B sectors of the RAID volume
>> +		stripe segment. For a zoned block device, either
>> +		host-aware or host-managed, chunk_sectors indicates the
>> +		size of 512B sectors of the zones of the device, with
>                      ^^
>                      in

Good catch. Thank you. Will fix this.

-- =

Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
