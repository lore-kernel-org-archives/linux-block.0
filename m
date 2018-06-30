Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: jdow <jdow@earthlink.net>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
Date: Sat, 30 Jun 2018 11:07:09 +0200
Message-ID: <2821568.nu49EmH9g5@merkaba>
In-Reply-To: <765b1a05-752b-7736-ac56-8235b432969c@earthlink.net>
References: <20180627012421.80B8F24E094@nmr-admin> <c02bbd73-d946-9d1b-7f10-03aacae1f1ee@gmail.com> <765b1a05-752b-7736-ac56-8235b432969c@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

jdow - 30.06.18, 08:47:
> Let's get everybody:
>=20
> On 20180629 22:26, Michael Schmitz wrote:
>  > Joanne,
>  >=20
>  > Am 30.06.18 um 15:56 schrieb jdow:
>  >>>>> As far as I can guess from the code, pb_Environment[3] (number
>  >>>>> of
>  >>>>=20
>  >>>> heads)
>  >>>>=20
>  >>>>> and pb_Environment[5] (number of sectors per cylinder) are
>  >>>>> abitrarily
>  >>>>> chosen so the partition size can be expressed as a difference
>  >>>>> between
>  >>>>> pb_Environment[9] and pb_Environment[10] (low and high cylinder
>  >>>>> addresses), which places restrictions on both partition size
>  >>>>> and
>  >>>>> alignment that depend on where on the disk a partition is
>  >>>>> placed?
>  >>>>=20
>  >>>> If you do not teach the OS to ignore Cylinder Blocks type
>  >>>> entries and
>  >>>> use some math on heads and blocks per track the disk size is
>  >>>> relatively stuck modulo using large blocks.
>  >>>=20
>  >>> As long as AmigaOS and Linux agree on how to express start and
>  >>> end
>  >>> offset for the partitions, that's fine.
>  >>>=20
>  >>> But I read your other mail to mean that we're stuck to 2 TB disks
>  >>> for
>  >>> now. I don't follow that - we can have partitions of 2 TB each by
>  >>=20
>  >> maxing
>  >>=20
>  >>> out rdb_CylBlocks as long as we use 512 bytes per block (since
>  >>> the
>  >>> product of cylinders and blocks per cylinder is limited to 32
>  >>> bits) and using one cylinder per partition (32 bits available
>  >>> there as well)?
>  >>>=20
>  >>> But the rdb_CylBlocks limit also means we're safe with 64 bit
>  >>> sector_t in Linux. Best add a check in the parser to warn us if
>  >>> the product of head count and sectors per cylinder overflows 32
>  >>> bit though.
>  >>>=20
>  >>> Cheers,
>  >>>=20
>  >>>        Michael
>  >>=20
>  >> How long did it tale s to get to 10 TB disks from 2 TB disks. And
>  >> a
>  >> new SD Card spec allows for 128 TB disks. Block sizes get sort of
>  >> ridiculous as you get past about 8k bytes or about 32 TB or about
>  >> two
>  >> years from now.
>  >=20
>  > I get that - I just don't get why 32 bits for cylinders plus 32
>  > bits for blocks per cylinder equals 2 TB (4G of 512 byte blocks).
>  > But I don't know what other limits exist that may restrict the
>  > total number of blocks to 32 bits.
>=20
> It overflows uint32_t cylinder blocks aka blocks per cylinder. Linux
> doesn't care. AmigaDOS surely does. If YOU make partitions really
> large for yourself that's OK. If Joe Amigoid does it the potential
> for an angry red turning to purple face is high.

Ok, let get this straight:

Do you think that is the responsibility of the RDB parser within the=20
Linux kernel to protect the user from anything whatever partitioning=20
tool has created?

If so, how would you make sure the Linux kernel knows about whatever any=20
partitioning tool used by Amiga users can come up with?=20

I=C2=B4d say: Don=C2=B4t bother. It is not the job of the RDB parser to imp=
ose=20
limits on what partitioning tools can create. If native OS tools don=C2=B4t=
=20
create such thing, you don=C2=B4t need to check for it. If someone managed =
to=20
create it with amiga-fdisk or parted, the tool needs to be fixed. *Not*=20
the kernel.

Anyway, that 2 TB disk that started all this *worked* on AmigaOS 4. And=20
I am pretty sure while I cannot proof it, that even a larger disk would=20
work. There is a limit for the boot partition on AmigaOS 4 Classic,=20
which uses AmigaOS 3.1 to bootstrap AmigaOS 4 on Classic Amiga computers=20
like an Amiga 1200 or Amiga 4000 with PowerPC extension card. But=20
according to

Hard drive setup for AmigaOS 4.1 Classic
http://blog.hyperion-entertainment.biz/?p=3D210

AmigaOS classic (i.e. < 4) would crash.

>  >> Do you want to create disks that will fail on AmigaDOS? AmigaDOS,
>  >> as
>  >> far as I know, makes heavy use of Cylinder Blocks values. It
>  >> calculating Cylinder Blocks overflows when creating the disk's
>  >> RDBs
>  >> the user MUST be informed it is
>  >=20
>  > I'm not at all planning to create disks for AmigaDOS. I just need
>  > to
>  > know what combinations of cylinders, heads and sectors are possible
>  > to encounter on disks that have been created with native tools.
>  > Well, assuming sufficient amounts of braindamage in the
>  > corresponding Linux tools, knowing the absolute outer limits of
>  > what these tools could do would be nice as well, but someone using
>  > amiga-fdisk to create a RDSK block for a 10 TB disk fully deserves
>  > any punishment that invites.
> Native AmigaDOS tools SHOULD NOT be able to create something that
> overflows CylinderBlocks values. However, if it can that creates an

There you have it.

Then *why* bother, Joanne?

> interesting test case to see what various tools, like the AmigaDOS
> "info" command, do when they they are run on such a disk. I don't
> have OS source to perform searches. And I am not setup to feed the
> system something obscene.
>=20
>  > (Actually, I lied there. I do plan to create a RDSK block for a 2
>  > TB
>  > disk image where cylinder, head and sector counts all approach the
>  > 32
>  > bit limit, just to see that my overflow checks work as intended.
>  > But
>  > that's strictly for Linux testing).
>  >=20
>  >> unsafe to put on a real Amiga. (I'd also suggest teaching Linux to
>  >> understand RDSL, which would be RDSK++ sort of. Then use that if
>  >> Cylinder Blocks overflows.) The value you will not be able to fill
>  >> in
>  >>=20
>  >> the DosEnvec structure is:
>  >>      ULONG de_HighCyl;         /* max cylinder. drive specific */
>  >=20
>  > OK, so Cylinder Blocks overflowing is a red flag, and requires to
>  > abort parsing the partition table right away? And HighCyl really
>  > means the max. number of logical blocks, not cylinders (which
>  > would have nr_heads*nr_sects many blocks)? That's probably the
>  > cause for my confusion.
> I think I picked the wrong value. In RDSK itself this value is what
> overflows: ULONG   rdb_CylBlocks;    /* number of blocks available
> per cylinder */ And I think that floats around the system in many
> places with different names. As mentioned the "info" command is one
> item to test. If no crashes are found then AmigaDOS may be clean up
> to obscene sizes. At the moment I do not remember what
> hdwrench.library does with that value other than pass it along as
> read. Nor am I sure what it generates as any suggested values. I
> don't at this time have a disk I can mount as a disk on WinUAE that
> is more than 2TB. And my Amigas speak SCSI so I have no disk for
> them, either, even if they still boot.
>  >> So accessing larger disks once you hit 2 TB means you must
>  >> increase
>  >> the logical block size. And eventually that will waste HUGE
>  >> amounts of files when small files are being stored.
>  >=20
>  > Just like small inodes wastes huge amounts of space for metadata.
>  > It's a tradeoff, and AFFS on a RDSK format disk probably isn't the
>  > right choice for huge disks. Never mind that - if someone _does_
>  > go that way, we need to make sure we can parse the RDSK
>  > information correctly. And if such a disk causes the 64 bit
>  > sector_t in Linux to overflow, I'd like the parser to spot that,
>  > too.
>  >=20
>  > Thanks for your immense patience in explaining all these subtleties
>  > to me.
[=E2=80=A6]
>  >      Michael
>=20
> And I'm rushing too much so I'm sorry I am making errors. This stuff
> is 25 years in the past since I last looked at it seriously.

I think its important to focus on what can overflow can happen within=20
calculations the RDB parser (and as a second step the AFFS file system)=20
in the kernel kernel in order to keep this discussion to a manageable=20
size. Be conservative about overflows, but otherwise accept. With a=20
warning if a calculated exceed 32 bit.

As for values in the RDB. If its there, accept it. Some tool has written=20
it there. We don=C2=B4t know whether it did this right or wrong. We don=C2=
=B4t=20
know what the developer of the tool thought when writing it, well except=20
for hdwrench.library I=C2=B4d say as far as you remember. :) And it is not=
=20
our job within the kernel to check that.

There is a ton of more or less legacy software out there on native OS=20
which does something to or with RDBs. I=C2=B4d say it is impossible to say=
=20
what RDB a user may come up with.

Thanks,
=2D-=20
Martin
