Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <1539304018-11786-1-git-send-email-schmitzmic@gmail.com>
 <1539304018-11786-3-git-send-email-schmitzmic@gmail.com> <CAMuHMdVnmszjPUVDq-hgKAtvFKRMpGY74c+Bo_CHPeRtsZpo5w@mail.gmail.com>
 <f8b0bae2-862f-353b-d431-85449bd76c7a@gmail.com>
In-Reply-To: <f8b0bae2-862f-353b-d431-85449bd76c7a@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 13 Oct 2018 09:02:49 +0200
Message-ID: <CAMuHMdV8Xzd8LtEftwHqacCWNeLeiEAgzuA7J75CW=5EFEujTg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] block: add overflow checks for Amiga partition support
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	"Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Sat, Oct 13, 2018 at 4:23 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 12.10.2018 um 21:54 schrieb Geert Uytterhoeven:
> >  Thanks for being persistent!
> >
> > BTW, there's another possible overflow in "blk *= blksize", but that one
> > is very unlikely to happen, as most (all?) partitioners store partition
> > blocks close to the beginning of the disk.
>
> Thanks - we can at least change the type of blk to sector_t to limit the
> potential for multiplication overflow, but with RDB_ALLOCATION_LIMIT at
> 16, we would miss RDB partition blocks not at the very beginning of a
> disk anyway.

I thought so, too, but then realized that RDB_ALLOCATION_LIMIT applies to
the RDB block itself, not to the partition blocks.

> >> --- a/block/partitions/amiga.c
> >> +++ b/block/partitions/amiga.c
> >
> >> @@ -32,9 +40,12 @@ int amiga_partition(struct parsed_partitions *state)
> >>         unsigned char *data;
> >>         struct RigidDiskBlock *rdb;
> >>         struct PartitionBlock *pb;
> >> -       sector_t start_sect, nr_sects;
> >> +       u64 start_sect, nr_sects;
> >> +       sector_t end_sect;
> >> +       u32 cylblk;             /* rdb_CylBlocks = nr_heads*sect_per_track */
> >> +       u32 nr_hd, nr_sect, lo_cyl, hi_cyl;
> >>         int blk, part, res = 0;
> >> -       int blksize = 1;        /* Multiplier for disk block size */
> >> +       unsigned int blksize = 1;       /* Multiplier for disk block size */
> >>         int slot = 1;
> >>         char b[BDEVNAME_SIZE];
> >>
> >> @@ -99,19 +110,70 @@ int amiga_partition(struct parsed_partitions *state)
> >>                 if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
> >>                         continue;
> >>
> >> -               /* Tell Kernel about it */
> >> +               /* RDB gives us more than enough rope to hang ourselves with,
> >> +                * many times over (2^128 bytes if all fields max out).
> >> +                * Some careful checks are in order, so check for potential
> >> +                * overflows.
> >> +                * We are multiplying four 32 bit numbers to one sector_t!
> >> +                */
> >> +
> >> +               nr_hd   = be32_to_cpu(pb->pb_Environment[NR_HD]);
> >> +               nr_sect = be32_to_cpu(pb->pb_Environment[NR_SECT]);
> >> +
> >> +               /* CylBlocks is total number of blocks per cylinder */
> >> +               if (check_mul_overflow(nr_hd, nr_sect, &cylblk)) {
> >> +                       pr_err("Dev %s: heads*sects %u overflows u32, skipping partition!\n",
> >> +                               bdevname(state->bdev, b), cylblk);
> >> +                       continue;
> >> +               }
> >> +
> >> +               /* check for consistency with RDB defined CylBlocks */
> >> +               if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
> >> +                       pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
> >> +                               bdevname(state->bdev, b), cylblk,
> >> +                               be32_to_cpu(rdb->rdb_CylBlocks));
> >> +               }
> >> +
> >> +               /* RDB allows for variable logical block size -
> >> +                * normalize to 512 byte blocks and check result.
> >> +                */
> >> +
> >> +               if (check_mul_overflow(cylblk, blksize, &cylblk)) {
> >> +                       pr_err("Dev %s: partition %u bytes per cyl. overflows u32, skipping partition!\n",
> >> +                               bdevname(state->bdev, b), part);
> >
> > Unlike the comparison with 32-bit rdb_CylBlocks above, this is an
> > artificial limitation, right?
> > You can relax it by using 64-bit arithmetic, but that would complicate the
> > calculation of start_sect and nr_sects below, as they may overflow 64-bit.
>
> Correct - this allows me to skip the overflow check on the final result
> (see comment below). But making cylblk a 32 bit type for the purpose of
> this overflow check has tripped me up below.
>
> I'd still like to retain this check - it is highly unlikely to ever
> trigger with RDB blocks in current use, and should disks ever get so
> large as to require the total number of 512 byte blocks per cylinder to
> exceed the 32 bit limit, I'd certainly hope other partition table
> options get chosen.

Fair enough.

> >> +               if (check_add_overflow(start_sect, nr_sects, &end_sect)) {
> >> +                       pr_err("Dev %s: partition %u (%llu-%llu) needs LBD device support, skipping partition!\n",
> >> +                               bdevname(state->bdev, b), part,
> >> +                               start_sect, (u64) end_sect);
> >
> > The cast to u64 is not needed.
>
> It is, in case the kernel is compiled without LBD support (making
> end_sect a 32 bit sector_t). I haven't found a better way to check
> whether the partition exceeds what's possible to represent without LBD
> support.

You're right. I missed that end_sect was not converted to u64.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
