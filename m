Return-Path: <jdow@earthlink.net>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
 <a0974de4-da1f-3991-8d44-4108a81a0014@earthlink.net>
 <1770345.glHoxEKBYS@merkaba>
From: jdow <jdow@earthlink.net>
Message-ID: <6047aaa9-dfb4-46b5-48e2-67dbdf10bdb0@earthlink.net>
Date: Fri, 29 Jun 2018 16:24:46 -0700
MIME-Version: 1.0
In-Reply-To: <1770345.glHoxEKBYS@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


On 20180629 14:45, Martin Steigerwald wrote:
 > Beware: Essay ahead which proofs it to the point that there is no
 > overflow in RDB before 96 bits maximum value of sectors:

Time to go into more detail on RDBs. It isn't as simple as it started to appear.

extract from hardblocks.h RDSK block definition
===8<---
     ULONG   rdb_BlockBytes;	/* size of disk blocks */
...
     ULONG   rdb_Cylinders;	/* number of drive cylinders */
     ULONG   rdb_Sectors;	/* sectors per track */
     ULONG   rdb_Heads;		/* number of drive heads */
     ...
     ULONG   rdb_LoCylinder;	/* low cylinder of partitionable disk area */
     ULONG   rdb_HiCylinder;	/* high cylinder of partitionable data area */
     ULONG   rdb_CylBlocks;	/* number of blocks available per cylinder */
===8<---
This has the hard limit embodied within it, unfortunately.

The first four values above give you hope for 2^128 bytes. The next three may 
trash some of it when all three are considered.

Since a cylinder is sectors times heads we have 2^64 blocks capacity embodied in 
rdb_LoCylinder and rdb_HiCylinder. But, our hopes are deftly dashed by the last 
value rdb_CylBlocks which places a hard limit on the product of rdb_Heads and 
rdb_Sectors of 2^32. But, that still allows is a fairly large disk. 2^32-1 
blocks per cylinder times block size, rdb_BlockBytes, of 2^32, although the 
larger block sizes are um er sort of putrid to use. Similar limitations exist 
within dos.h in the InfoData and DosEnvec structure, among other likely places.

Approaches "exist" to allowing large partitions. Some of them are unattractive, 
probably all of them as a matter of fact.
1) For large disks move to GPT and be done with it.
2) "lie" and teach the filesystems to ignore rdb_CylBlocks and similar values 
elsewhere. Then the sky is the limit.
3) Invent a "PA64" 64 bit RDB entry and the other internal structures to make it 
work, InfoData64, DosEnvec64, and so on.

Solution 2 might be the least disruptive way to do it. BUT, a whole host of 
utilities like "info" will have to be tweaked to handle "rdb_CylBlocks" becoming 
meaningless.

So this is what happened with some simple includes mining while I am playing 
hooky from doing some real work.

Good luck, gentlemen.
{^_^}
