Return-Path: <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 1/3] mmc: sdio: Don't use abort-able claim host method
 from SDIO IRQ thread
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <1494506343-28572-1-git-send-email-ulf.hansson@linaro.org>
 <1494506343-28572-2-git-send-email-ulf.hansson@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
 linux-block@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <6b359de4-4503-ca19-0e1d-84b909b21786@intel.com>
Date: Fri, 12 May 2017 10:42:05 +0300
MIME-Version: 1.0
In-Reply-To: <1494506343-28572-2-git-send-email-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 11/05/17 15:39, Ulf Hansson wrote:
> In a step to simplify the use of the lock, mmc_claim|release_host(), let's
> change the SDIO IRQ thread to move away from using the abort-able claim
> host method.
> 
> In the SDIO IRQ thread case, we can instead check the numbers of SDIO IRQs
> that are currently claimed via host->sdio_irqs, as this field is protected
> from updates unless the host is claimed. When host->sdio_irqs has become
> zero, it means the SDIO func driver(s) has released the SDIO IRQ, then we
> can bail out and stop running the SDIO IRQ thread.

Does that work?  It looks a like kthread_stop() will wait on the thread,
which is waiting to claim the host, which is claimed by the caller of
sdio_card_irq_put() which called kthread_stop() i.e. deadlock.

> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 10 ++++++----
>  include/linux/mmc/host.h    |  1 -
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 6d4b720..95f7a09 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -137,9 +137,13 @@ static int sdio_irq_thread(void *_host)
>  		 * holding of the host lock does not cover too much work
>  		 * that doesn't require that lock to be held.
>  		 */
> -		ret = __mmc_claim_host(host, &host->sdio_irq_thread_abort);
> -		if (ret)
> +		mmc_claim_host(host);
> +		if (!host->sdio_irqs) {
> +			ret = 1;
> +			mmc_release_host(host);
>  			break;
> +		}
> +
>  		ret = process_sdio_pending_irqs(host);
>  		host->sdio_irq_pending = false;
>  		mmc_release_host(host);
> @@ -195,7 +199,6 @@ static int sdio_card_irq_get(struct mmc_card *card)
>  
>  	if (!host->sdio_irqs++) {
>  		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD)) {
> -			atomic_set(&host->sdio_irq_thread_abort, 0);
>  			host->sdio_irq_thread =
>  				kthread_run(sdio_irq_thread, host,
>  					    "ksdioirqd/%s", mmc_hostname(host));
> @@ -223,7 +226,6 @@ static int sdio_card_irq_put(struct mmc_card *card)
>  
>  	if (!--host->sdio_irqs) {
>  		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD)) {
> -			atomic_set(&host->sdio_irq_thread_abort, 1);
>  			kthread_stop(host->sdio_irq_thread);
>  		} else if (host->caps & MMC_CAP_SDIO_IRQ) {
>  			host->ops->enable_sdio_irq(host, 0);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 21385ac..8a4131f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -359,7 +359,6 @@ struct mmc_host {
>  	unsigned int		sdio_irqs;
>  	struct task_struct	*sdio_irq_thread;
>  	bool			sdio_irq_pending;
> -	atomic_t		sdio_irq_thread_abort;
>  
>  	mmc_pm_flag_t		pm_flags;	/* requested pm features */
>  
> 
