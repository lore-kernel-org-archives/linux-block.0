Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qg0-f67.google.com ([209.85.192.67]:36108 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbcEMNZY (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 13 May 2016 09:25:24 -0400
MIME-Version: 1.0
In-Reply-To: <1463074986-3070-2-git-send-email-jonathan.derrick@intel.com>
References: <1463074986-3070-1-git-send-email-jonathan.derrick@intel.com>
	<1463074986-3070-2-git-send-email-jonathan.derrick@intel.com>
Date: Fri, 13 May 2016 06:25:22 -0700
Message-ID: <CAA9_cmeaa6qGKeDfRXWm-BkNtw0hJrbc9kqsLfOEJ2ZE-Mubgw@mail.gmail.com>
Subject: Re: [RFC 1/2] block: allow other bd i_node flags when DAX is disabled
From: Dan Williams <dan.j.williams@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jeff Moyer <jmoyer@redhat.com>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 12, 2016 at 10:43 AM, Jon Derrick
<jonathan.derrick@intel.com> wrote:
> When DAX is not compiled into the kernel or the device does not support
> direct-access, the block device file's inode flags are fully cleared.
> This patch changes it to only clear the S_DAX flag when DAX is disabled.
>
> This reverts to i_flags behavior prior to
> bbab37ddc20bae4709bca8745c128c4f46fe63c5
>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  fs/block_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 20a2c02..d4fa725 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1208,7 +1208,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>                 if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops->direct_access)
>                         bdev->bd_inode->i_flags = S_DAX;
>                 else
> -                       bdev->bd_inode->i_flags = 0;
> +                       bdev->bd_inode->i_flags &= ~S_DAX;

Setting S_DAX is atomic, but the above change makes it a non-atomic
read-modify-write.  Do we need exclusion / locking in this path?
