Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 13 Jul 2018 21:41:41 +0800
Message-ID: <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
To: Patrick Steinhardt <ps@pks.im>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 13, 2018 at 9:29 PM, Patrick Steinhardt <ps@pks.im> wrote:
> When power management for SCSI is enabled and if a device uses blk-mq,
> it is possible to trigger a `NULL` pointer exception when resuming that
> device. The NPE is triggered when trying to dereference the `request_fn`
> function pointer of the device's `request_queue`:
>
>     __blk_run_queue_uncond:470
>     __blk_run_queue:490
>     blk_post_runtime_resume:3889
>     sdev_runtime_resume:263
>     scsi_runtime_resume:275
>
> When the SCSI device is being allocated by `scsi_alloc_sdev`, the
> device's request queue will either be initialized via
> `scsi_mq_alloc_queue` or `scsi_old_alloc_queue`. But the `request_fn`
> member of the request queue is in fact only being set in
> `scsi_old_alloc_queue`, which will then later cause the mentioned NPE.
>
> Fix the issue by checking whether the `request_fn` is set in
> `__blk_run_queue_uncond`. In case it is unset, we'll silently return and
> not try to invoke the callback, thus fixing the NPE.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> Since at least v4.14, I am easily able to trigger above NPE by
> unplugging USB mass storage devices on my computer (Skylake, ASUS
> Z170I) with CONFIG_SCSI_MQ_DEFAULT=y. The attached patch fixes
> the issue, but keep in mind that this is my first patch, so the
> proposed fix may not be appropriate at all. Feedback would be
> highly appreciated.
>
>  block/blk-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index f84a9b7b6f5a..0a2041660cd9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -456,7 +456,7 @@ inline void __blk_run_queue_uncond(struct request_queue *q)
>         lockdep_assert_held(q->queue_lock);
>         WARN_ON_ONCE(q->mq_ops);
>
> -       if (unlikely(blk_queue_dead(q)))
> +       if (unlikely(!q->request_fn) || unlikely(blk_queue_dead(q)))
>                 return;
>

Now runtime PM is disabled for blk-mq/scsi_mq, not sure how this issue is
triggered on your machine.

Could you share the steps for reproducing this issue?

Thanks,
Ming Lei
