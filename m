Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20171026125757.10200-12-linus.walleij@linaro.org>
References: <20171026125757.10200-1-linus.walleij@linaro.org> <20171026125757.10200-12-linus.walleij@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 27 Oct 2017 16:19:42 +0200
Message-ID: <CAPDyKFoxYOk+BgxHRukB7f=r04TY2EE2gqMhAHM0q3JomzifMA@mail.gmail.com>
Subject: Re: [PATCH 11/12 v4] mmc: block: issue requests in massive parallel
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 26 October 2017 at 14:57, Linus Walleij <linus.walleij@linaro.org> wrote:
> This makes a crucial change to the issueing mechanism for the
> MMC requests:
>
> Before commit "mmc: core: move the asynchronous post-processing"
> some parallelism on the read/write requests was achieved by
> speculatively postprocessing a request and re-preprocess and
> re-issue the request if something went wrong, which we discover
> later when checking for an error.
>
> This is kind of ugly. Instead we need a mechanism like here:
>
> We issue requests, and when they come back from the hardware,
> we know if they finished successfully or not. If the request
> was successful, we complete the asynchronous request and let a
> new request immediately start on the hardware. If, and only if,
> it returned an error from the hardware we go down the error
> path.
>
> This is achieved by splitting the work path from the hardware
> in two: a successful path ending up calling down to
> mmc_blk_rw_done() and completing quickly, and an errorpath
> calling down to mmc_blk_rw_done_error().
>
> This has a profound effect: we reintroduce the parallelism on
> the successful path as mmc_post_req() can now be called in
> while the next request is in transit (just like prior to
> commit "mmc: core: move the asynchronous post-processing")
> and blk_end_request() is called while the next request is
> already on the hardware.
>
> The latter has the profound effect of issuing a new request
> again so that we actually may have three requests
> in transit at the same time: one on the hardware, one being
> prepared (such as DMA flushing) and one being prepared for
> issuing next by the block layer. This shows up when we
> transit to multiqueue, where this can be exploited.

So this change should more or less restore the behavior we had before
this series. I would actually be interested to see a comparison in
throughput towards that, before moving on to the last patch12, which
converts to blkmq.

Also, if I get things right so far, you have manged to get rid off a
waitqueue but instead introduced a worker, so from context switching
point of view, it would be interesting to see how/if that affects
things.

I do some tests myself and let you know the results.

[...]

> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 209ebb8a7f3f..0f57e9fe66b6 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -735,15 +735,35 @@ void mmc_finalize_areq(struct work_struct *work)
>                 mmc_start_bkops(host->card, true);
>         }
>
> -       /* Successfully postprocess the old request at this point */
> -       mmc_post_req(host, areq->mrq, 0);
> -
> -       /* Call back with status, this will trigger retry etc if needed */
> -       if (areq->report_done_status)
> -               areq->report_done_status(areq, status);
> -
> -       /* This opens the gate for the next request to start on the host */
> -       complete(&areq->complete);
> +       /*
> +        * Here we postprocess the request differently depending on if
> +        * we go on the success path or error path. The success path will
> +        * immediately let new requests hit the host, whereas the error
> +        * path will hold off new requests until we have retried and
> +        * succeeded or failed the current asynchronous request.
> +        */
> +       if (status == MMC_BLK_SUCCESS) {
> +               /*
> +                * This immediately opens the gate for the next request
> +                * to start on the host while we perform post-processing
> +                * and report back to the block layer.
> +                */
> +               host->areq = NULL;
> +               complete(&areq->complete);
> +               mmc_post_req(host, areq->mrq, 0);
> +               if (areq->report_done_status)
> +                       areq->report_done_status(areq, MMC_BLK_SUCCESS);
> +       } else {
> +               mmc_post_req(host, areq->mrq, 0);
> +               /*
> +                * Call back with error status, this will trigger retry
> +                * etc if needed
> +                */
> +               if (areq->report_done_status)
> +                       areq->report_done_status(areq, status);

I was trying to wrap my head around what this really means from a
request preparation point of view.

Can't we end up here having a new request being prepared, but then
doing error handling and re-trying with the current one?

It's been a long week, so I should probably stop reviewing code by now. :-)

Anyway, it seems like this error path really needs to be properly
tested/triggered, especially to make sure so the above still plays
nicely.

Earlier experiences also tells me that doing a card hotplug in the
middle of transactions could trigger interesting errors, related to
this path.

> +               host->areq = NULL;
> +               complete(&areq->complete);
> +       }
>  }
>  EXPORT_SYMBOL(mmc_finalize_areq);
>
> --
> 2.13.6
>

Kind regards
Uffe
