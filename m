Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: jdow <jdow@earthlink.net>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
Date: Sat, 30 Jun 2018 09:49:02 +0200
Message-ID: <4908196.8QWSOAbfO6@merkaba>
In-Reply-To: <af252a47-a22e-5f40-f412-e5dbfaa6858c@earthlink.net>
References: <20180627012421.80B8F24E094@nmr-admin> <b8c29f74-9ba1-a697-b1f8-1a116b317a54@gmail.com> <af252a47-a22e-5f40-f412-e5dbfaa6858c@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Whoa, my summary essay triggered digging even more accurately into that=20
matter. For some obscure reason I am even enjoying this. :)

jdow - 30.06.18, 05:56:
> On 20180629 18:31, Michael Schmitz wrote:> Joanne,
>=20
>  > Am 30.06.18 um 12:57 schrieb jdow:
>  >> On 20180629 17:44, Michael Schmitz wrote:
>  >>> struct PartitionBlock {
>  >>>=20
>  >>>            __be32  pb_ID;
>  >>>            __be32  pb_SummedLongs;
>  >>>            __s32   pb_ChkSum;
>  >>>            __u32   pb_HostID;
>  >>>            __be32  pb_Next;
>  >>>            __u32   pb_Flags;
>  >>>            __u32   pb_Reserved1[2];
>  >>>            __u32   pb_DevFlags;
>  >>>            __u8    pb_DriveName[32];
>  >>>            __u32   pb_Reserved2[15];
>  >>>            __be32  pb_Environment[17];
>  >>>            __u32   pb_EReserved[15];
>  >>>=20
>  >>> };
>  >>>=20
>  >>   pb_Environment =3D a struct DosEnvec and it is 20 ULONGs in size.
>  >>   I
>  >>=20
>  >> believe you are looking at some old include files.
>  >=20
>  > Without looking at ancient git history, I'd say between 1993 and
>  > 1996. >=20
>  >> These got added to the end of the DosEnvec structure:
>  >>      ULONG de_Baud;         /* Baud rate for serial handler */
>  >>      ULONG de_Control;         /* Control word for
>  >>      handler/filesystem */
>  >>      ULONG de_BootBlocks;     /* Number of blocks containing boot
>  >>      code */
>  >>>=20
>  >>> As far as I can guess from the code, pb_Environment[3] (number of
>  >>=20
>  >> heads)
>  >>=20
>  >>> and pb_Environment[5] (number of sectors per cylinder) are
>  >>> abitrarily
>  >>> chosen so the partition size can be expressed as a difference
>  >>> between
>  >>> pb_Environment[9] and pb_Environment[10] (low and high cylinder
>  >>> addresses), which places restrictions on both partition size and
>  >>> alignment that depend on where on the disk a partition is placed?
>  >>=20
>  >> If you do not teach the OS to ignore Cylinder Blocks type entries
>  >> and
>  >> use some math on heads and blocks per track the disk size is
>  >> relatively stuck modulo using large blocks.
>  >=20
>  > As long as AmigaOS and Linux agree on how to express start and end
>  > offset for the partitions, that's fine.
>  >=20
>  > But I read your other mail to mean that we're stuck to 2 TB disks
>  > for
>  > now. I don't follow that - we can have partitions of 2 TB each by
>  > maxing out rdb_CylBlocks as long as we use 512 bytes per block
>  > (since the product of cylinders and blocks per cylinder is limited
>  > to 32 bits) and using one cylinder per partition (32 bits
>  > available there as well)?
>  >=20
>  > But the rdb_CylBlocks limit also means we're safe with 64 bit
>  > sector_t in Linux. Best add a check in the parser to warn us if
>  > the product of head count and sectors per cylinder overflows 32
>  > bit though.
>  >=20
>  > Cheers,
>  >=20
>  >      Michael
>=20
> How long did it tale s to get to 10 TB disks from 2 TB disks. And a
> new SD Card spec allows for 128 TB disks. Block sizes get sort of
> ridiculous as you get past about 8k bytes or about 32 TB or about two
> years from now.
>=20
> Do you want to create disks that will fail on AmigaDOS? AmigaDOS, as
> far as I know, makes heavy use of Cylinder Blocks values. It
> calculating Cylinder Blocks overflows when creating the disk's RDBs
> the user MUST be informed it is unsafe to put on a real Amiga. (I'd

Joanne, if you are sure on this=E2=80=A6 I=C2=B4d say at least warn if not =
bail out=20
on Cylinder Blocks overflow.

But given what you say here, no partitioning tool on AmigaOS or AmigaOS=20
like operating system would create such an overflow.

Can you verify whether that is the case with the RDB that I attached to=20
the bug report?

Bug 43511 - Partitions: Amiga RDB partition on 2 TB disk way too big,=20
while OK in AmigaOS 4.1=20

https://bugzilla.kernel.org/show_bug.cgi?id=3D43511

https://bugzilla.kernel.org/attachment.cgi?id=3D73771

> also suggest teaching Linux to understand RDSL, which would be RDSK++
> sort of. Then use that if Cylinder Blocks overflows.) The value you
> will not be able to fill in the DosEnvec structure is: ULONG
> de_HighCyl;	     /* max cylinder. drive specific */
>
>=20
> So accessing larger disks once you hit 2 TB means you must increase
> the logical block size. And eventually that will waste HUGE amounts
> of files when small files are being stored.

As far as I am aware, AmigaOS 4.1 still only supports 512 byte sectors.
=20
> Any solution will require action on the part of the people developing
> AmigaDOS follow-ons. You might want to get them motivated, somehow,
> and proceed from there with a request to be informed of any RDB
> changes. I'd suggest to them that removing sensitivity to Cylinder
> Blocks sorts of values from the entire system probably would be
> painful but the simplest solution.

I think for this patch it is important to focus on the *current*=20
situation and make the best out of it.

I am really inclined to point some AmigaOS 4 developers to this=20
discussion and just looked for an archive. Unfortunately there does not=20
appear to be a working one. The one mentioned on

http://www.linux-m68k.org/mail.html

http://aire.ncl.ac.uk/Atari/Mailing-Lists/Linux-680x0-vger-List.index.html

does not send an answer within the HTTP / TCP timeout limit.

I also did not find any archive for linux-block mailing list.

And lore.kernel.org only seems to archive LKML itself which is patch and=20
the discussion we have here is not CC=C2=B4d to.

Any advice?

Thanks,
=2D-=20
Martin
