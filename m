Return-Path: <jdow@earthlink.net>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Michael Schmitz <schmitzmic@gmail.com>,
 Martin Steigerwald <martin@lichtvoll.de>
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
From: jdow <jdow@earthlink.net>
Message-ID: <af252a47-a22e-5f40-f412-e5dbfaa6858c@earthlink.net>
Date: Fri, 29 Jun 2018 20:56:05 -0700
MIME-Version: 1.0
In-Reply-To: <b8c29f74-9ba1-a697-b1f8-1a116b317a54@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 20180629 18:31, Michael Schmitz wrote:> Joanne,
 >
 >
 > Am 30.06.18 um 12:57 schrieb jdow:
 >> On 20180629 17:44, Michael Schmitz wrote:
 >>
 >>> struct PartitionBlock {
 >>>            __be32  pb_ID;
 >>>            __be32  pb_SummedLongs;
 >>>            __s32   pb_ChkSum;
 >>>            __u32   pb_HostID;
 >>>            __be32  pb_Next;
 >>>            __u32   pb_Flags;
 >>>            __u32   pb_Reserved1[2];
 >>>            __u32   pb_DevFlags;
 >>>            __u8    pb_DriveName[32];
 >>>            __u32   pb_Reserved2[15];
 >>>            __be32  pb_Environment[17];
 >>>            __u32   pb_EReserved[15];
 >>> };
 >>   pb_Environment = a struct DosEnvec and it is 20 ULONGs in size. I
 >> believe you are looking at some old include files.
 >
 > Without looking at ancient git history, I'd say between 1993 and 1996.
 >
 >> These got added to the end of the DosEnvec structure:
 >>      ULONG de_Baud;         /* Baud rate for serial handler */
 >>      ULONG de_Control;         /* Control word for handler/filesystem */
 >>      ULONG de_BootBlocks;     /* Number of blocks containing boot code */
 >>
 >>> As far as I can guess from the code, pb_Environment[3] (number of
 >> heads)
 >>> and pb_Environment[5] (number of sectors per cylinder) are abitrarily
 >>> chosen so the partition size can be expressed as a difference between
 >>> pb_Environment[9] and pb_Environment[10] (low and high cylinder
 >>> addresses), which places restrictions on both partition size and
 >>> alignment that depend on where on the disk a partition is placed?
 >> If you do not teach the OS to ignore Cylinder Blocks type entries and
 >> use some math on heads and blocks per track the disk size is
 >> relatively stuck modulo using large blocks.
 >
 > As long as AmigaOS and Linux agree on how to express start and end
 > offset for the partitions, that's fine.
 >
 > But I read your other mail to mean that we're stuck to 2 TB disks for
 > now. I don't follow that - we can have partitions of 2 TB each by maxing
 > out rdb_CylBlocks as long as we use 512 bytes per block (since the
 > product of cylinders and blocks per cylinder is limited to 32 bits) and
 > using one cylinder per partition (32 bits available there as well)?
 >
 > But the rdb_CylBlocks limit also means we're safe with 64 bit sector_t
 > in Linux. Best add a check in the parser to warn us if the product of
 > head count and sectors per cylinder overflows 32 bit though.
 >
 > Cheers,
 >
 >      Michael
How long did it tale s to get to 10 TB disks from 2 TB disks. And a new SD Card 
spec allows for 128 TB disks. Block sizes get sort of ridiculous as you get past 
about 8k bytes or about 32 TB or about two years from now.

Do you want to create disks that will fail on AmigaDOS? AmigaDOS, as far as I 
know, makes heavy use of Cylinder Blocks values. It calculating Cylinder Blocks 
overflows when creating the disk's RDBs the user MUST be informed it is unsafe 
to put on a real Amiga. (I'd also suggest teaching Linux to understand RDSL, 
which would be RDSK++ sort of. Then use that if Cylinder Blocks overflows.) The 
value you will not be able to fill in the DosEnvec structure is:
	ULONG de_HighCyl;	     /* max cylinder. drive specific */

So accessing larger disks once you hit 2 TB means you must increase the logical 
block size. And eventually that will waste HUGE amounts of files when small 
files are being stored.

Any solution will require action on the part of the people developing AmigaDOS 
follow-ons. You might want to get them motivated, somehow, and proceed from 
there with a request to be informed of any RDB changes. I'd suggest to them that 
removing sensitivity to Cylinder Blocks sorts of values from the entire system 
probably would be painful but the simplest solution.

{^_^}
