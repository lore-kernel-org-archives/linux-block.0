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
 <b7558aec-1a69-6004-adde-7ac77e304fe4@gmail.com>
 <8d6f91bc-17f9-bed2-21f1-81bf18d49fc3@earthlink.net>
 <b8c29f74-9ba1-a697-b1f8-1a116b317a54@gmail.com>
 <af252a47-a22e-5f40-f412-e5dbfaa6858c@earthlink.net>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c02bbd73-d946-9d1b-7f10-03aacae1f1ee@gmail.com>
Date: Sat, 30 Jun 2018 17:26:19 +1200
MIME-Version: 1.0
In-Reply-To: <af252a47-a22e-5f40-f412-e5dbfaa6858c@earthlink.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Joanne,


Am 30.06.18 um 15:56 schrieb jdow:
>
> >>> As far as I can guess from the code, pb_Environment[3] (number of
> >> heads)
> >>> and pb_Environment[5] (number of sectors per cylinder) are abitrarily
> >>> chosen so the partition size can be expressed as a difference between
> >>> pb_Environment[9] and pb_Environment[10] (low and high cylinder
> >>> addresses), which places restrictions on both partition size and
> >>> alignment that depend on where on the disk a partition is placed?
> >> If you do not teach the OS to ignore Cylinder Blocks type entries and
> >> use some math on heads and blocks per track the disk size is
> >> relatively stuck modulo using large blocks.
> >
> > As long as AmigaOS and Linux agree on how to express start and end
> > offset for the partitions, that's fine.
> >
> > But I read your other mail to mean that we're stuck to 2 TB disks for
> > now. I don't follow that - we can have partitions of 2 TB each by
> maxing
> > out rdb_CylBlocks as long as we use 512 bytes per block (since the
> > product of cylinders and blocks per cylinder is limited to 32 bits) and
> > using one cylinder per partition (32 bits available there as well)?
> >
> > But the rdb_CylBlocks limit also means we're safe with 64 bit sector_t
> > in Linux. Best add a check in the parser to warn us if the product of
> > head count and sectors per cylinder overflows 32 bit though.
> >
> > Cheers,
> >
> >      Michael
> How long did it tale s to get to 10 TB disks from 2 TB disks. And a
> new SD Card spec allows for 128 TB disks. Block sizes get sort of
> ridiculous as you get past about 8k bytes or about 32 TB or about two
> years from now.

I get that - I just don't get why 32 bits for cylinders plus 32 bits for
blocks per cylinder equals 2 TB (4G of 512 byte blocks). But I don't
know what other limits exist that may restrict the total number of
blocks to 32 bits.

>
> Do you want to create disks that will fail on AmigaDOS? AmigaDOS, as
> far as I know, makes heavy use of Cylinder Blocks values. It
> calculating Cylinder Blocks overflows when creating the disk's RDBs
> the user MUST be informed it is 

I'm not at all planning to create disks for AmigaDOS. I just need to
know what combinations of cylinders, heads and sectors are possible to
encounter on disks that have been created with native tools. Well,
assuming sufficient amounts of braindamage in the corresponding Linux
tools, knowing the absolute outer limits of what these tools could do
would be nice as well, but someone using amiga-fdisk to create a RDSK
block for a 10 TB disk fully deserves any punishment that invites.

(Actually, I lied there. I do plan to create a RDSK block for a 2 TB
disk image where cylinder, head and sector counts all approach the 32
bit limit, just to see that my overflow checks work as intended. But
that's strictly for Linux testing).

> unsafe to put on a real Amiga. (I'd also suggest teaching Linux to
> understand RDSL, which would be RDSK++ sort of. Then use that if
> Cylinder Blocks overflows.) The value you will not be able to fill in
> the DosEnvec structure is:
>     ULONG de_HighCyl;         /* max cylinder. drive specific */

OK, so Cylinder Blocks overflowing is a red flag, and requires to abort
parsing the partition table right away? And HighCyl really means the
max. number of logical blocks, not cylinders (which would have
nr_heads*nr_sects many blocks)? That's probably the cause for my confusion.

>
> So accessing larger disks once you hit 2 TB means you must increase
> the logical block size. And eventually that will waste HUGE amounts of
> files when small files are being stored.
Just like small inodes wastes huge amounts of space for metadata. It's a
tradeoff, and AFFS on a RDSK format disk probably isn't the right choice
for huge disks. Never mind that - if someone _does_ go that way, we need
to make sure we can parse the RDSK information correctly. And if such a
disk causes the 64 bit sector_t in Linux to overflow, I'd like the
parser to spot that, too.

Thanks for your immense patience in explaining all these subtleties to me.

Cheers,

    Michael

>
> Any solution will require action on the part of the people developing
> AmigaDOS follow-ons. You might want to get them motivated, somehow,
> and proceed from there with a request to be informed of any RDB
> changes. I'd suggest to them that removing sensitivity to Cylinder
> Blocks sorts of values from the entire system probably would be
> painful but the simplest solution.
>
> {^_^}
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
