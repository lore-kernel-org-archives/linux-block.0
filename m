Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] do_direct_IO: Use inode->i_blkbits to compute block count
 to be cleaned
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>, jack@suse.cz
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <25f09398-7750-19ce-8fa9-15e229aad498@kernel.dk>
Date: Mon, 9 Jan 2017 08:32:55 -0700
MIME-Version: 1.0
In-Reply-To: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/08/2017 07:47 AM, Chandan Rajendra wrote:
> The code currently uses sdio->blkbits to compute the number of blocks to
> be cleaned. However sdio->blkbits is derived from the logical block size
> of the underlying block device (Refer to the definition of
> do_blockdev_direct_IO()). Due to this, generic/299 test would rarely
> fail when executed on an ext4 filesystem with 64k as the block size and
> when using a virtio based disk (having 512 byte as the logical block
> size) inside a kvm guest.
> 
> This commit fixes the bug by using inode->i_blkbits to compute the
> number of blocks to be cleaned.

Thanks, added for 4.10.

-- 
Jens Axboe
