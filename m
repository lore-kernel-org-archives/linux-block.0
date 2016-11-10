Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH] block: clear all of bi_opf in bio_set_op_attrs
To: Christoph Hellwig <hch@lst.de>, <axboe@kernel.dk>
References: <1478716684-5085-1-git-send-email-hch@lst.de>
CC: <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <469312f1-e28c-0618-9df1-7c636b5c9e0d@sandisk.com>
Date: Thu, 10 Nov 2016 08:31:11 -0800
MIME-Version: 1.0
In-Reply-To: <1478716684-5085-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 11/09/2016 10:38 AM, Christoph Hellwig wrote:
> Since commit 87374179 ("block: add a proper block layer data direction
> encoding") we only OR the new op and flags into bi_opf in bio_set_op_attrs
> instead of clearing the old value.  I've not seen any breakage with the
> new behavior, but it seems dangerous.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blk_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 562ac46..67434fd 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -208,7 +208,7 @@ enum req_flag_bits {
>
>  /* obsolete, don't use in new code */
>  #define bio_set_op_attrs(bio, op, op_flags) \
> -	((bio)->bi_opf |= (op | op_flags))
> +	((bio)->bi_opf = op | op_flags)
>
>  static inline bool op_is_write(unsigned int op)
>  {

Hello Christoph,

Have you verified whether or not this change affects the behavior of the 
bcache driver? From commit ad0d9e76a412:

@@ -114,7 +114,7 @@ void bch_data_verify(struct cached_dev *dc, struct 
bio *bio)
         check = bio_clone(bio, GFP_NOIO);
         if (!check)
                 return;
-       check->bi_rw |= READ_SYNC;
+       bio_set_op_attrs(check, REQ_OP_READ, READ_SYNC);

         if (bio_alloc_pages(check, GFP_NOIO))
                 goto out_put;

Additionally, since bio_set_op_attrs is a macro please surround 'op' and 
'op_flags' with parentheses or change this macro into an inline function.

Thanks,

Bart.
