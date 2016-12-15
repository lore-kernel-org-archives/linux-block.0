Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [RFC] block: check partition alignment
To: Christoph Hellwig <hch@infradead.org>,
 Stefan Haberland <sth@linux.vnet.ibm.com>
References: <20161214164706.45543-1-sth@linux.vnet.ibm.com>
 <20161214170719.GA3599@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, hoeppner@linux.vnet.ibm.com,
 sebott@linux.vnet.ibm.com
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <5824c17b-a7d7-60a1-6bb7-287257aaf67a@wdc.com>
Date: Thu, 15 Dec 2016 10:33:47 +0900
MIME-Version: 1.0
In-Reply-To: <20161214170719.GA3599@infradead.org>
Return-Path: damien.lemoal@wdc.com
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>


Christoph,

On 12/15/16 02:07, Christoph Hellwig wrote:
>> To prevent partitions that are not aligned to the physical blocksize
>> of a device check for the alignment in the blkpg_ioctl.
> =

> We'd also need to reject this when reading partitions from disk, right?

Only for DASD devices, no ?

Logical block size aligned partitions are fine for regular block
devices. Not aligning on the physical block size is indeed very stupid,
but will not generate errors and an application can see that through
bdev_alignment_offset() and the sysfs alignment_offset file of the
partition.

> =

>> +			/* check if partition is aligned to blocksize */
>> +			if (p.start % bdev_physical_block_size(bdev) !=3D 0)
> =

> And this should be bdev_logical_block_size, as the logical block size
> is the only thing that matters for the OS - exposing the physical block
> size is just an optional hint to prevent users from doing stupid
> things (like creating unaligned partitions :))

For a regular block device, I agree. But in Stephan case, I think that
the check really needs to be against the physical block size, with the
added condition that the bdev is a DASD device (similarly to the zone
alignment check for zoned block devices).

So this should become something like:

if (p.start & (bdev_logical_block_size(bdev) - 1))
	return -EINVAL;
if (bdev_is_dasd(bdev) &&
    p.start & (bdev_physical_block_size(bdev) - 1))
	return -EINVAL;

I am not sure however how bdev_is_dasd can be implemented though.

Best regards.

-- =

Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
