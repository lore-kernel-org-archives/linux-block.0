Return-Path: <linux-block-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:54232 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdFPAqq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2017 20:46:46 -0400
Cc: shawn.lin@rock-chips.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Avri Altman <Avri.Altman@sandisk.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/5] mmc: block: Move duplicate check
To: Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
 <20170615121259.8281-2-linus.walleij@linaro.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <25c4809f-c07b-5cfb-8b7a-00308ed8de1e@rock-chips.com>
Date: Fri, 16 Jun 2017 08:46:39 +0800
MIME-Version: 1.0
In-Reply-To: <20170615121259.8281-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

On 2017/6/15 20:12, Linus Walleij wrote:
> mmc_blk_ioctl() calls either mmc_blk_ioctl_cmd() or
> mmc_blk_ioctl_multi_cmd() and each of these make the same
> check. Factor it into a new helper function, call it on
> both branches of the switch() statement and save a chunk
> of duplicate code.
> 
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - We need to check the block device only if an actual
>    well-known ioctl() is coming in, on the path of the
>    switch() statments, only those branches that handle
>    actual ioctl()s. Create a new helper function to check
>    the block device and call that.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
>   drivers/mmc/core/block.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 1ce6012ce3c1..d1b824e65590 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -566,14 +566,6 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>   	int err = 0, ioc_err = 0;
>   	struct request *req;
>   
> -	/*
> -	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> -	 * whole block device, not on a partition.  This prevents overspray
> -	 * between sibling partitions.
> -	 */
> -	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
> -		return -EPERM;
> -
>   	idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
>   	if (IS_ERR(idata))
>   		return PTR_ERR(idata);
> @@ -626,14 +618,6 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>   	__u64 num_of_cmds;
>   	struct request *req;
>   
> -	/*
> -	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> -	 * whole block device, not on a partition.  This prevents overspray
> -	 * between sibling partitions.
> -	 */
> -	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
> -		return -EPERM;
> -
>   	if (copy_from_user(&num_of_cmds, &user->num_of_cmds,
>   			   sizeof(num_of_cmds)))
>   		return -EFAULT;
> @@ -697,14 +681,34 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>   	return ioc_err ? ioc_err : err;
>   }
>   
> +static int mmc_blk_check_blkdev(struct block_device *bdev)
> +{
> +	/*
> +	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> +	 * whole block device, not on a partition.  This prevents overspray
> +	 * between sibling partitions.
> +	 */
> +	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
> +		return -EPERM;
> +	return 0;
> +}
> +
>   static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
>   	unsigned int cmd, unsigned long arg)
>   {
> +	int ret;
> +
>   	switch (cmd) {
>   	case MMC_IOC_CMD:
> +		ret = mmc_blk_check_blkdev(bdev);
> +		if (ret)
> +			return ret;
>   		return mmc_blk_ioctl_cmd(bdev,
>   				(struct mmc_ioc_cmd __user *)arg);
>   	case MMC_IOC_MULTI_CMD:
> +		ret = mmc_blk_check_blkdev(bdev);
> +		if (ret)
> +			return ret;
>   		return mmc_blk_ioctl_multi_cmd(bdev,
>   				(struct mmc_ioc_multi_cmd __user *)arg);
>   	default:
> 
