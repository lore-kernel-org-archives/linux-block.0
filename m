Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
References: <20181107143745.11845-1-keith.busch@intel.com>
In-Reply-To: <20181107143745.11845-1-keith.busch@intel.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 7 Nov 2018 23:09:27 +0800
Message-ID: <CACVXFVO8pcZpK0MBud8oebdZWhKB0Gzr14MPbzMtoHBUkN4Rbg@mail.gmail.com>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 7, 2018 at 10:42 PM Keith Busch <keith.busch@intel.com> wrote:
>
> If the kernel allocates a bounce buffer for user read data, this memory
> needs to be cleared before copying it to the user, otherwise it may leak
> kernel memory to user space.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  block/bio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index d5368a445561..a50d59236b19 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1260,6 +1260,7 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
>                 if (ret)
>                         goto cleanup;
>         } else {
> +               zero_fill_bio(bio);
>                 iov_iter_advance(iter, bio->bi_iter.bi_size);
>         }

This way looks inefficient because zero fill should only be required
for short READ.

Thanks,
Ming Lei
