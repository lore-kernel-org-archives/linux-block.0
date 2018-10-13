Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: [PATCH v5 2/2] block: add overflow checks for Amiga partition
 support
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <1539304018-11786-1-git-send-email-schmitzmic@gmail.com>
 <1539304018-11786-3-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdVnmszjPUVDq-hgKAtvFKRMpGY74c+Bo_CHPeRtsZpo5w@mail.gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Linux/m68k <linux-m68k@vger.kernel.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <f8b0bae2-862f-353b-d431-85449bd76c7a@gmail.com>
Date: Sat, 13 Oct 2018 15:23:12 +1300
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVnmszjPUVDq-hgKAtvFKRMpGY74c+Bo_CHPeRtsZpo5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Geert,

Am 12.10.2018 um 21:54 schrieb Geert Uytterhoeven:
>  Thanks for being persistent!
>
> BTW, there's another possible overflow in "blk *= blksize", but that one
> is very unlikely to happen, as most (all?) partitioners store partition
> blocks close to the beginning of the disk.

Thanks - we can at least change the type of blk to sector_t to limit the 
potential for multiplication overflow, but with RDB_ALLOCATION_LIMIT at 
16, we would miss RDB partition blocks not at the very beginning of a 
disk anyway.

>
>> --- a/block/partitions/amiga.c
>> +++ b/block/partitions/amiga.c
>
>> @@ -32,9 +40,12 @@ int amiga_partition(struct parsed_partitions *state)
>>         unsigned char *data;
>>         struct RigidDiskBlock *rdb;
>>         struct PartitionBlock *pb;
>> -       sector_t start_sect, nr_sects;
>> +       u64 start_sect, nr_sects;
>> +       sector_t end_sect;
>> +       u32 cylblk;             /* rdb_CylBlocks = nr_heads*sect_per_track */
>> +       u32 nr_hd, nr_sect, lo_cyl, hi_cyl;
>>         int blk, part, res = 0;
>> -       int blksize = 1;        /* Multiplier for disk block size */
>> +       unsigned int blksize = 1;       /* Multiplier for disk block size */
>>         int slot = 1;
>>         char b[BDEVNAME_SIZE];
>>
>> @@ -99,19 +110,70 @@ int amiga_partition(struct parsed_partitions *state)
>>                 if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
>>                         continue;
>>
>> -               /* Tell Kernel about it */
>> +               /* RDB gives us more than enough rope to hang ourselves with,
>> +                * many times over (2^128 bytes if all fields max out).
>> +                * Some careful checks are in order, so check for potential
>> +                * overflows.
>> +                * We are multiplying four 32 bit numbers to one sector_t!
>> +                */
>> +
>> +               nr_hd   = be32_to_cpu(pb->pb_Environment[NR_HD]);
>> +               nr_sect = be32_to_cpu(pb->pb_Environment[NR_SECT]);
>> +
>> +               /* CylBlocks is total number of blocks per cylinder */
>> +               if (check_mul_overflow(nr_hd, nr_sect, &cylblk)) {
>> +                       pr_err("Dev %s: heads*sects %u overflows u32, skipping partition!\n",
>> +                               bdevname(state->bdev, b), cylblk);
>> +                       continue;
>> +               }
>> +
>> +               /* check for consistency with RDB defined CylBlocks */
>> +               if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
>> +                       pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
>> +                               bdevname(state->bdev, b), cylblk,
>> +                               be32_to_cpu(rdb->rdb_CylBlocks));
>> +               }
>> +
>> +               /* RDB allows for variable logical block size -
>> +                * normalize to 512 byte blocks and check result.
>> +                */
>> +
>> +               if (check_mul_overflow(cylblk, blksize, &cylblk)) {
>> +                       pr_err("Dev %s: partition %u bytes per cyl. overflows u32, skipping partition!\n",
>> +                               bdevname(state->bdev, b), part);
>
> Unlike the comparison with 32-bit rdb_CylBlocks above, this is an
> artificial limitation, right?
> You can relax it by using 64-bit arithmetic, but that would complicate the
> calculation of start_sect and nr_sects below, as they may overflow 64-bit.

Correct - this allows me to skip the overflow check on the final result 
(see comment below). But making cylblk a 32 bit type for the purpose of 
this overflow check has tripped me up below.

I'd still like to retain this check - it is highly unlikely to ever 
trigger with RDB blocks in current use, and should disks ever get so 
large as to require the total number of 512 byte blocks per cylinder to 
exceed the 32 bit limit, I'd certainly hope other partition table 
options get chosen.

>
>> +                       continue;
>> +               }
>> +
>> +               /* Calculate partition start and end. Limit of 32 bit on cylblk
>> +                * guarantees no overflow occurs if LBD support is enabled.
>> +                */
>> +
>> +               lo_cyl = be32_to_cpu(pb->pb_Environment[LO_CYL]);
>> +               start_sect = (u64) (lo_cyl * cylblk);
>
> As lo_cyl and cylblk are both u32, the multiplication will be done using
> 32-bit arithmetic, and may overflow.  Hence you should cast one of the
> multiplicands, instead of the result:
>
>     start_sect = ((u64)lo_cyl * cylblk);
>
>
>> +
>> +               hi_cyl = be32_to_cpu(pb->pb_Environment[HI_CYL]);
>> +               nr_sects = (u64) ((hi_cyl - lo_cyl + 1) * cylblk);
>
> Likewise.

Thanks, I'll fix those.

>
>>
>> -               nr_sects = ((sector_t) be32_to_cpu(pb->pb_Environment[10])
>> -                          + 1 - be32_to_cpu(pb->pb_Environment[9])) *
>> -                          be32_to_cpu(pb->pb_Environment[3]) *
>> -                          be32_to_cpu(pb->pb_Environment[5]) *
>> -                          blksize;
>>                 if (!nr_sects)
>>                         continue;
>> -               start_sect = (sector_t) be32_to_cpu(pb->pb_Environment[9]) *
>> -                            be32_to_cpu(pb->pb_Environment[3]) *
>> -                            be32_to_cpu(pb->pb_Environment[5]) *
>> -                            blksize;
>> +
>> +               /* Warn user if partition end overflows u32 (AmigaDOS limit) */
>> +
>> +               if ((start_sect + nr_sects) > UINT_MAX) {
>> +                       pr_warn("Dev %s: partition %u (%llu-%llu) needs 64 bit device support!\n",
>> +                               bdevname(state->bdev, b), part,
>> +                               start_sect, start_sect + nr_sects);
>> +               }
>> +
>> +               if (check_add_overflow(start_sect, nr_sects, &end_sect)) {
>> +                       pr_err("Dev %s: partition %u (%llu-%llu) needs LBD device support, skipping partition!\n",
>> +                               bdevname(state->bdev, b), part,
>> +                               start_sect, (u64) end_sect);
>
> The cast to u64 is not needed.

It is, in case the kernel is compiled without LBD support (making 
end_sect a 32 bit sector_t). I haven't found a better way to check 
whether the partition exceeds what's possible to represent without LBD 
support.
OTOH, no other partition parser does bother to check for that, so maybe 
it's overkill.

Thanks again,

	Michael

>
>> +                       continue;
>> +               }
>> +
>> +               /* Tell Kernel about it */
>> +
>>                 put_partition(state,slot++,start_sect,nr_sects);
>>                 {
>>                         /* Be even more informative to aid mounting */
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
