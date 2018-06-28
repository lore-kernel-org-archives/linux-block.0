Return-Path: <jdow@earthlink.net>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Michael Schmitz <schmitzmic@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, geert@linux-m68k.org-r,
 Martin Steigerwald <martin@lichtvoll.de>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <CAMuHMdUOGdF-bm8j59Om8JNV0mFqK0yixGifgLAjxGwOGLoyqQ@mail.gmail.com>
From: jdow <jdow@earthlink.net>
Message-ID: <da9795b2-991b-ded7-dfbc-f31472bafdb1@earthlink.net>
Date: Wed, 27 Jun 2018 20:45:18 -0700
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUOGdF-bm8j59Om8JNV0mFqK0yixGifgLAjxGwOGLoyqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Oops! It MUST be 64 bit or everything go boom.

{O.O}

On 20180627 06:30, Geert Uytterhoeven wrote:
> Hi Michael,
> 
> Thanks for your patch!
> 
> On Wed, Jun 27, 2018 at 4:47 AM <schmitzmic@gmail.com> wrote:
>>  From 5299e0e64dfb33ac3a1f3137b42178734ce20087 Mon Sep 17 00:00:00 2001
> 
> ??
> 
>> The Amiga RDB partition parser module uses int for partition sector
>> address and count, which will overflow for disks 2 TB and larger.
>>
>> Use sector_t as type for sector address and size (as expected by
>> put_partition) to allow using such disks without danger of data
>> corruption.
> 
> Note that sector_t is not guaranteed to be 64-bit:
> 
>      #ifdef CONFIG_LBDAF
>      typedef u64 sector_t;
>      typedef u64 blkcnt_t;
>      #else
>      typedef unsigned long sector_t;
>      typedef unsigned long blkcnt_t;
>      #endif
> 
> And it seems CONFIG_LBDAF can still be disabled on 32-bit...
> 
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
>>          unsigned char *data;
>>          struct RigidDiskBlock *rdb;
>>          struct PartitionBlock *pb;
>> -       int start_sect, nr_sects, blk, part, res = 0;
>> +       sector_t start_sect, nr_sects;
> 
> As sector_t can still be 32-bit, I think you should use an explicit u64 here.
> 
>> +       int blk, part, res = 0;
>>          int blksize = 1;        /* Multiplier for disk block size */
>>          int slot = 1;
>>          char b[BDEVNAME_SIZE];
>> @@ -111,6 +112,16 @@ int amiga_partition(struct parsed_partitions *state)
>>                               be32_to_cpu(pb->pb_Environment[3]) *
>>                               be32_to_cpu(pb->pb_Environment[5]) *
>>                               blksize;
> 
> Without adding any unsigned long long or ULL stuff to the calculations
> for start_sect and nr_sects above, the math will still be done using 32-bit
> arithmetic. Or am I missing something?
> 
>> +               if (start_sect > INT_MAX || nr_sects > INT_MAX
>> +                       || (start_sect + nr_sects) > INT_MAX) {
>> +                       pr_err("%s: Warning: RDB partition overflow!\n",
>> +                               bdevname(state->bdev, b));
>> +                       pr_err("%s: start 0x%llX size 0x%llX\n",
>> +                               bdevname(state->bdev, b), start_sect,
>> +                               nr_sects);
>> +                       pr_err("%s: partition incompatible with 32 bit OS\n",
>> +                               bdevname(state->bdev, b));
>> +               }
> 
> I don't know if the check above is really needed here.
> There's also int vs. unsigned int. But see below.
> 
>>                  put_partition(state,slot++,start_sect,nr_sects);
> 
> Given sector_t may be 32-bit, values may be truncated when calling
> put_partition(), so you need to check for that.
> 
> Interestingly, even partition parsers that do use u64 (efi, ldm) or loff_t
> (ibm) do not have such checks.
> 
> Perhaps put_partition() should take u64, and print a warning and ignore the
> partition if conversion to sector_t involves truncation?
> 
>>                  {
>>                          /* Be even more informative to aid mounting */
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
