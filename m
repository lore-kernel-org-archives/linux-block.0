Return-Path: <jdow@earthlink.net>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Martin Steigerwald <martin@lichtvoll.de>, schmitzmic@gmail.com
Cc: axboe@kernel.dk, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
 linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <2157764.1gpVE8K9i5@merkaba>
From: jdow <jdow@earthlink.net>
Message-ID: <0f756cf4-9af9-cb34-f832-5dd206e77a7f@earthlink.net>
Date: Wed, 27 Jun 2018 20:49:58 -0700
MIME-Version: 1.0
In-Reply-To: <2157764.1gpVE8K9i5@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Error NNNN: Conventional RDBs cannot define more than 4,294,967,296 blocks.
or
Error NNNN: Conventional RDB block count overflow.

That is a HARD limit. The documentation for error NNNN should suggest larger 
logical block (cluster, whatever) sizes as a way out. Of course, block size 
"could" go up to at least 65536 bytes (if the nonsense size 0 is reinterpreted). 
Then Bob's your uncle up to 281 TB. It should also include a dry notation that 
you are best off with a power of 2 block size larger than or equal to the disk's 
actual sector size, if you can learn that.

{^_^}
(Get everybody)

On 20180627 01:24, Martin Steigerwald wrote:
> Thanks a lot again for your patch.
> 
> schmitzmic@gmail.com - 27.06.18, 03:24:
>> +               if (start_sect > INT_MAX || nr_sects > INT_MAX
>> +                       || (start_sect + nr_sects) > INT_MAX) {
>> +                       pr_err("%s: Warning: RDB partition
>> overflow!\n", +                               bdevname(state->bdev,
> 
> I´d word this:
> 
> Warning: RDB partition 32-bit overflow
> 
> AmigaOS developers can do 64 bit math on a 32 bit operating system. Just
> like Linux can.
> 
>> b));
>> +                       pr_err("%s: start 0x%llX size 0x%llX\n",
>> +                               bdevname(state->bdev, b), start_sect,
>> +                               nr_sects);
>> +                       pr_err("%s: partition incompatible with 32 bit
>> OS\n", +                               bdevname(state->bdev, b));
>> +               }
> 
> And as stated in my other reply to the patch:
> 
> partition needs 64 bit disk device support in AmigaOS or AmigaOS like
> operating systems (NSD64, TD64 or SCSI direct)
> 
> see my other reply to the patch and my other mails in the
> "Re: moving affs + RDB partition support to staging?" thread as to why.
> And for references.
> 
> Thanks,
> 
