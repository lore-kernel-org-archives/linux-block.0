Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29766 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbdAYJXt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 04:23:49 -0500
Subject: Re: [PATCH 1/6] mmc: block: break out mmc_blk_rw_cmd_abort()
To: Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
 <20170124101757.19676-2-linus.walleij@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>
From: Mateusz Nowak <mateusz.nowak@linux.intel.com>
Message-ID: <54ba79f7-93f1-6a93-79eb-7a7ba0f0d623@linux.intel.com>
Date: Wed, 25 Jan 2017 10:23:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170124101757.19676-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

On 1/24/2017 11:17, Linus Walleij wrote:
> As a first step toward breaking apart the very complex function
> mmc_blk_issue_rw_rq() we break out the command abort code.
> This code assumes "ret" is != 0 and then repeatedly hammers
> blk_end_request() until the request to the block layer to end
> the request succeeds.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/block.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 7bd03381810d..14efe92a14ef 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1598,6 +1598,17 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
>  	return ret;
>  }
>
> +static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
> +{
> +	int ret = 1;
blk_end_request is returning bool, so maybe this variable should have 
matching type since it is only usage in this scope? And maybe it should 
have more meaningful name for this case?

> +
> +	if (mmc_card_removed(card))
> +		req->rq_flags |= RQF_QUIET;
> +	while (ret)
> +		ret = blk_end_request(req, -EIO,
> +				      blk_rq_cur_bytes(req));
> +}
> +
>  static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  {
>  	struct mmc_blk_data *md = mq->blkdata;
> @@ -1737,11 +1748,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>  	return 1;
>
>   cmd_abort:
> -	if (mmc_card_removed(card))
> -		req->rq_flags |= RQF_QUIET;
> -	while (ret)
> -		ret = blk_end_request(req, -EIO,
> -				blk_rq_cur_bytes(req));
> +	mmc_blk_rw_cmd_abort(card, req);
>
>   start_new_req:
>  	if (rqc) {
>

Regards,
Mateusz.
