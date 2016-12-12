Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH resend] block_dev: don't test bdev->bd_contains when it is
 not stable.
To: NeilBrown <neilb@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>
References: <87mvgo9vgy.fsf@notabene.neil.brown.name>
 <87d1gy0z2r.fsf@notabene.neil.brown.name>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e53e9442-9e9f-f938-9cef-3185f26c99b2@kernel.dk>
Date: Mon, 12 Dec 2016 08:20:18 -0700
MIME-Version: 1.0
In-Reply-To: <87d1gy0z2r.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/11/2016 05:29 PM, NeilBrown wrote:
> 
> bdev->bd_contains is not stable before calling __blkdev_get().
> When __blkdev_get() is called on a parition with ->bd_openers == 0
> it sets
>   bdev->bd_contains = bdev;
> which is not correct for a partition.
> After a call to __blkdev_get() succeeds, ->bd_openers will be > 0
> and then ->bd_contains is stable.
> 
> When FMODE_EXCL is used, blkdev_get() calls
>    bd_start_claiming() ->  bd_prepare_to_claim() -> bd_may_claim()
> 
> This call happens before __blkdev_get() is called, so ->bd_contains
> is not stable.  So bd_may_claim() cannot safely use ->bd_contains.
> It currently tries to use it, and this can lead to a BUG_ON().
> 
> This happens when a whole device is open with a bd_holder (in use by
> dm in my particular example) and two threads race to open a partition
> for the first time, one opening with O_EXCL and one without.
> 
> The thread that doesn't use O_EXCL gets through blkdev_get() to
> __blkdev_get(), gains the ->bd_mutex, and sets bdev->bd_contains = bdev;
> 
> Immediately thereafter the other thread, using FMODE_EXCL, calls
> bd_start_claiming from blkdev_get().  This should fail because the
> whole device has a holder, but because bdev->bd_contains == bdev
> bd_may_claim() incorrectly reports success.
> 
> This thread continues and blocks on bd_mutex.
> The first thread then sets bdev->bd_contains correctly and drops the mutex.
> The thread using FMODE_EXCL then continues and when it calls bd_may_claim()
> again in:
> 			BUG_ON(!bd_may_claim(bdev, whole, holder));
> The BUG_ON fires.
> 
> Fix this by removing the dependency on ->bd_contains in
> bd_may_claim().  As bd_may_claim() have direct access to the whole
> device, it can simply test if the target bdev is the whole device.
> 
> Fixes: 6b4517a7913a ("block: implement bd_claiming and claiming block")
> Cc: stable@vger.kernel.org (v2.6.35+)
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> 
> 
> No reply after 2 weeks, and this didn't appear in -next, so I'm adding a
> couple more addresses - hopefully someone can take it.
> Thanks,
> NeilBrown
> 
> 
>  fs/block_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 05b553368bb4..9166b9f63d33 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -832,7 +832,7 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
>  		return true;	 /* already a holder */
>  	else if (bdev->bd_holder != NULL)
>  		return false; 	 /* held by someone else */
> -	else if (bdev->bd_contains == bdev)
> +	else if (whole == bdev)
>  		return true;  	 /* is a whole device which isn't held */
>  
>  	else if (whole->bd_holder == bd_may_claim)
> 

Looks good to me, Neil. I'll get it applied, thanks.

-- 
Jens Axboe
