Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [RFC] block: check partition alignment
To: Stefan Haberland <sth@linux.vnet.ibm.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20161214164706.45543-1-sth@linux.vnet.ibm.com>
Cc: hoeppner@linux.vnet.ibm.com, sebott@linux.vnet.ibm.com
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <40f04360-5137-8504-fd2c-0861c7856a7a@wdc.com>
Date: Thu, 15 Dec 2016 09:29:15 +0900
MIME-Version: 1.0
In-Reply-To: <20161214164706.45543-1-sth@linux.vnet.ibm.com>
Return-Path: damien.lemoal@wdc.com
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

Stefan,

On 12/15/16 01:47, Stefan Haberland wrote:
> Partitions that are not aligned to the blocksize of a device may cause
> invalid I/O requests because the blocklayer cares only about alignment
> within the partition when building requests on partitions.
> =

> device
> |--------4096--------|--------4096--------|--------4096--------|
> partition offset 512byte
> |-512-|--------4096--------|--------4096--------|--------4096--------|
> =

> When reading/writing one 4k block of the partition this maps to
> reading/writing with an offset of 512 byte of the device leading to
> unaligned requests for the device which in turn may cause unexpected
> behavior of the device driver.
> =

> For DASD devices we have to translate the block number into a cylinder,
> head, record format. The unaligned requests lead to wrong calculation
> and therefore to misdirected I/O. In a "good" case this leads to I/O
> errors because the underlying hardware detects the wrong addressing.
> In a worst case scenario this might destroy data on the device.
> =

> To prevent partitions that are not aligned to the physical blocksize
> of a device check for the alignment in the blkpg_ioctl.
> =

> Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
> ---
>  block/ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/block/ioctl.c b/block/ioctl.c
> index 755119c..8b83afee 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -45,6 +45,9 @@ static int blkpg_ioctl(struct block_device *bdev, struc=
t blkpg_ioctl_arg __user
>  				    || pstart < 0 || plength < 0 || partno > 65535)
>  					return -EINVAL;
>  			}
> +			/* check if partition is aligned to blocksize */
> +			if (p.start % bdev_physical_block_size(bdev) !=3D 0)

sd.c ensures that the logical block size (sector size in sd.c) is a
power of 2 between 512 and 4096. So you can use:

if (p.start & (bdev_physical_block_size(bdev) - 1))

Or use div_u64_rem to avoid an error on 32 bits builds.

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
