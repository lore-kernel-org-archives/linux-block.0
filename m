Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: jdow <jdow@earthlink.net>, Martin Steigerwald <martin@lichtvoll.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
 <a0974de4-da1f-3991-8d44-4108a81a0014@earthlink.net>
 <1770345.glHoxEKBYS@merkaba>
 <6047aaa9-dfb4-46b5-48e2-67dbdf10bdb0@earthlink.net>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b7558aec-1a69-6004-adde-7ac77e304fe4@gmail.com>
Date: Sat, 30 Jun 2018 12:44:43 +1200
MIME-Version: 1.0
In-Reply-To: <6047aaa9-dfb4-46b5-48e2-67dbdf10bdb0@earthlink.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Joanne,


Am 30.06.18 um 11:24 schrieb jdow:
>
> On 20180629 14:45, Martin Steigerwald wrote:
> > Beware: Essay ahead which proofs it to the point that there is no
> > overflow in RDB before 96 bits maximum value of sectors:
>
> Time to go into more detail on RDBs. It isn't as simple as it started
> to appear.
>
> extract from hardblocks.h RDSK block definition
> ===8<---
>     ULONG   rdb_BlockBytes;    /* size of disk blocks */
> ...
>     ULONG   rdb_Cylinders;    /* number of drive cylinders */
>     ULONG   rdb_Sectors;    /* sectors per track */
>     ULONG   rdb_Heads;        /* number of drive heads */
>     ...
>     ULONG   rdb_LoCylinder;    /* low cylinder of partitionable disk
> area */
>     ULONG   rdb_HiCylinder;    /* high cylinder of partitionable data
> area */
>     ULONG   rdb_CylBlocks;    /* number of blocks available per
> cylinder */
> ===8<---
> This has the hard limit embodied within it, unfortunately.
>
> The first four values above give you hope for 2^128 bytes. The next
> three may trash some of it when all three are considered.
>
> Since a cylinder is sectors times heads we have 2^64 blocks capacity
> embodied in rdb_LoCylinder and rdb_HiCylinder. But, our hopes are
> deftly dashed by the last value rdb_CylBlocks which places a hard
> limit on the product of rdb_Heads and rdb_Sectors of 2^32. But, that
> still allows is a fairly large disk. 2^32-1 blocks per cylinder times
> block size, rdb_BlockBytes, of 2^32, although the larger block sizes
> are um er sort of putrid to use. Similar limitations exist within
> dos.h in the InfoData and DosEnvec structure, among other likely places.
>

As far as Linux is concerned, rdb_CylBlocks is used nowhere, neither in
the RDB parser nor in the AFFS filesystem driver. Only the partition
list is parsed.

Should we use rdb_LoCylinder*rdbCylBlocks and
rdb_HiCylinder*rdbCylBlocks in the RDB parser to verify the detected
partitions are valid according to the RDB's own specified limits? Or can
we absolutely rely on the partitioning tool getting that right?

Any similar surprises in the partition list data structures? The header
I have in Linux is largely non-descriptive there:

struct PartitionBlock {
        __be32  pb_ID;
        __be32  pb_SummedLongs;
        __s32   pb_ChkSum;
        __u32   pb_HostID;
        __be32  pb_Next;
        __u32   pb_Flags;
        __u32   pb_Reserved1[2];
        __u32   pb_DevFlags;
        __u8    pb_DriveName[32];
        __u32   pb_Reserved2[15];
        __be32  pb_Environment[17];
        __u32   pb_EReserved[15];
};

As far as I can guess from the code, pb_Environment[3] (number of heads)
and pb_Environment[5] (number of sectors per cylinder) are abitrarily
chosen so the partition size can be expressed as a difference between
pb_Environment[9] and pb_Environment[10] (low and high cylinder
addresses), which places restrictions on both partition size and
alignment that depend on where on the disk a partition is placed?

Cheers,

    Michael

> Approaches "exist" to allowing large partitions. Some of them are
> unattractive, probably all of them as a matter of fact.
> 1) For large disks move to GPT and be done with it.
> 2) "lie" and teach the filesystems to ignore rdb_CylBlocks and similar
> values elsewhere. Then the sky is the limit.
> 3) Invent a "PA64" 64 bit RDB entry and the other internal structures
> to make it work, InfoData64, DosEnvec64, and so on.
>
> Solution 2 might be the least disruptive way to do it. BUT, a whole
> host of utilities like "info" will have to be tweaked to handle
> "rdb_CylBlocks" becoming meaningless.
>
> So this is what happened with some simple includes mining while I am
> playing hooky from doing some real work.
>
> Good luck, gentlemen.
> {^_^}
