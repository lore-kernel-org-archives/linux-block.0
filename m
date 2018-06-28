Return-Path: <jdow@earthlink.net>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Martin Steigerwald <martin@lichtvoll.de>, schmitzmic@gmail.com
Cc: axboe@kernel.dk, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
 linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <2906102.Jp2gmY2ce1@merkaba>
From: jdow <jdow@earthlink.net>
Message-ID: <b6484aef-1dcc-ca21-3a03-01a4e3dbe3bc@earthlink.net>
Date: Wed, 27 Jun 2018 20:23:07 -0700
MIME-Version: 1.0
In-Reply-To: <2906102.Jp2gmY2ce1@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Three issues exist here in two different places.

As far as a 32 TG disk is concerned RDBs can describe it and mount it safely - 
sort of - modulo the following issues. They are not a problem, I believe, with 
Amiga OSs new enough to understand RDBs. I cannot prove that. They are not 
sufficient, apparently, for Linux, which is why an __int64 equivalent is needed 
rather than a int equivalent.

As far as 4GB is concerned you are limited at 2 GB by int fseek( int ). This is 
not an RDB issue. Take it up with the filesystems. Linux seems to "think" 
differently than AmigaDOS.

As far as going over 4GB disk size you are limited within the OS by anything 
that deals with byte rather than block calculations for position on disk 
calculations. I think everything speaks properly within the OS to handle at 
least up to 8.7 GB partition sizes. For AmigaDOS we're probably OK up to 32 TB 
(with 8k block size). It some Joe somewhere needs 512 byte block size some other 
partition format is needed. RDBs will not handle it without changes which MAY 
cause RDB interpretation issues. (Change block headers and the spirit of RDBs 
can be preserved safely. But - why? GPT exists, is tested, works nicely. One 
must be careful with it to make sure it supports required features. Note that a 
loadable filesystem is nice. It can make a NEARLY impossible to kill home for 
malware. But it does allow patching in newer filesystems with some backwards 
compatibility. Does GPT have a way to support this? Does AmigaDOS support a 
clean way to clean a disk of a corrupted filesystem image?)

The changes to READING the RDBs for Linux are "obvious", __int64 or equivalent. 
That change is sane and clean. (Be careful writing RDBs mkfs-(amigafs). But 
that's a given. We're adults here.) Changes to make Amigas handle 64 bit 
filesystems are "easy". They just won't necessarily be safe past 4 G blocks. I 
suspect if file sizes are kept under 2GiB a compatibility layer can even keep 
the OS thinking it is on a disk it understands and to it safely.

Linux apparently needs the change. It is not an RDB change; it is an RDB parser 
change. Changing RDB, however, needs care. And at least to my perceptions this 
discussion wandered around the Linux RDB parser and actual RDB changes. These 
need separate discussions as to compatibility issues with any AmigaOS that may 
have a chance of even "tasting" the disk let alone "chewing" on the disk.

On the RDB changes issue, I would recommend disappointing an Amigoid (as utterly 
death defying as that may be) by his not being able to mount a disk rather than 
angering that same Amigoid by damaging or losing his data. That's simply life 
preservation on the part of the designers.

{^_^}

On 20180627 01:13, Martin Steigerwald wrote:
> schmitzmic@gmail.com - 27.06.18, 03:24:
>>  From 5299e0e64dfb33ac3a1f3137b42178734ce20087 Mon Sep 17 00:00:00 2001
>>
>> The Amiga RDB partition parser module uses int for partition sector
>> address and count, which will overflow for disks 2 TB and larger.
>>
>> Use sector_t as type for sector address and size (as expected by
>> put_partition) to allow using such disks without danger of data
>> corruption.
>>
>> This bug was reported originally in 2012 by Martin Steigerwald
>> <Martin@lichtvoll.de>, and the fix was created by the RDB author,
>> Joanne Dow <jdow@earthlink.net>. The patch had been discussed and
>> reviewed on linux-m68k at that time but never officially submitted.
>>
>> Following a stern warning by Joanne, a warning is printed if any
>> partition is found to overflow the old 32 bit calculations, on the
>> grounds that such a partition would be misparses on legacy 32 bit
>> systems (other than Linux).
>>
>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
>> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
>> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
>> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
>> ---
>>   block/partitions/amiga.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
>> index 5609366..42c3f38 100644
>> --- a/block/partitions/amiga.c
>> +++ b/block/partitions/amiga.c
>> @@ -32,7 +32,8 @@ int amiga_partition(struct parsed_partitions *state)
>> unsigned char *data;
>>   	struct RigidDiskBlock *rdb;
>>   	struct PartitionBlock *pb;
>> -	int start_sect, nr_sects, blk, part, res = 0;
>> +	sector_t start_sect, nr_sects;
>> +	int blk, part, res = 0;
>>   	int blksize = 1;	/* Multiplier for disk block size */
>>   	int slot = 1;
>>   	char b[BDEVNAME_SIZE];
>> @@ -111,6 +112,16 @@ int amiga_partition(struct parsed_partitions
>> *state) be32_to_cpu(pb->pb_Environment[3]) *
>>   			     be32_to_cpu(pb->pb_Environment[5]) *
>>   			     blksize;
>> +		if (start_sect > INT_MAX || nr_sects > INT_MAX
>> +			|| (start_sect + nr_sects) > INT_MAX) {
>> +			pr_err("%s: Warning: RDB partition overflow!\n",
>> +				bdevname(state->bdev, b));
>> +			pr_err("%s: start 0x%llX size 0x%llX\n",
>> +				bdevname(state->bdev, b), start_sect,
>> +				nr_sects);
>> +			pr_err("%s: partition incompatible with 32 bit OS\n",
>> +				bdevname(state->bdev, b));
>> +		}
> 
> I do think the wording of that warning is inaccurate, as outlined in my
> other mails in thread "Re: moving affs + RDB partition support to
> staging?" just a few minutes ago (see there for a more complete
> reasoning). I´d word it like this:
> 
> partition needs 64 bit disk device support in AmigaOS or AmigaOS like
> operating systems (NSD64, TD64 or SCSI direct)
> 
> I think I would not include any more details, and let Amiga people
> research what they need and since when it is included officially on
> their own. As there are at least three variants out there: AmigaOS,
> MorphOS, AROS.
> 
> AmigaOS 4 at least can handle disks of 2 TB size or more. I do not think
> the wording "RDB overflow" is right either.
> 
> http://wiki.amigaos.net/wiki/RDB
> 
> Filesystem size limits are a different matter.
> 
> http://www.amigawiki.de/doku.php?id=de:system:filesystems_limits
> 
>>   		put_partition(state,slot++,start_sect,nr_sects);
>>   		{
>>   			/* Be even more informative to aid mounting */
> 
> Thanks,
> 
