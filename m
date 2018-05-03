Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/6] bcache: count backing device I/O error for writeback
 I/O
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20180502144659.118628-1-colyli@suse.de>
 <20180502144659.118628-4-colyli@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <301629da-cd9f-6472-f5b6-061bce2dd6f6@suse.de>
Date: Thu, 3 May 2018 07:53:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180502144659.118628-4-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/02/2018 04:46 PM, Coly Li wrote:
> Commit c7b7bd07404c5 ("bcache: add io_disable to struct cached_dev")
> counts backing device I/O requets and set dc->io_disable to true if error
> counters exceeds dc->io_error_limit. But it only counts I/O errors for
> regular I/O request, neglects errors of write back I/Os when backing device
> is offline.
> 
> This patch counts the errors of writeback I/Os, in dirty_endio() if
> bio->bi_status is  not 0, it means error happens when writing dirty keys
> to backing device, then bch_count_backing_io_errors() is called.
> 
> By this fix, even there is no reqular I/O request coming, if writeback I/O
> errors exceed dc->io_error_limit, the bcache device may still be stopped
> for the broken backing device.
> 
> Fixes: c7b7bd07404c5 ("bcache: add io_disable to struct cached_dev")
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/writeback.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
> index 4a9547cdcdc5..ad45ebe1a74b 100644
> --- a/drivers/md/bcache/writeback.c
> +++ b/drivers/md/bcache/writeback.c
> @@ -244,8 +244,10 @@ static void dirty_endio(struct bio *bio)
>   	struct keybuf_key *w = bio->bi_private;
>   	struct dirty_io *io = w->private;
>   
> -	if (bio->bi_status)
> +	if (bio->bi_status) {
>   		SET_KEY_DIRTY(&w->key, false);
> +		bch_count_backing_io_errors(io->dc, bio);
> +	}
>   
>   	closure_put(&io->cl);
>   }
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
