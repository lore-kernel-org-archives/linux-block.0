Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:34957
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933528AbcKNQzh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 11:55:37 -0500
Subject: Re: [PATCH] bsg: Add sparse annotations to bsg_request_fn()
To: Jens Axboe <axboe@fb.com>
References: <6dfb1793-ca6a-c3b6-b3fc-272e68ca6880@sandisk.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <b8f96aed-5cd5-26f0-5c14-4f1ace05dd51@sandisk.com>
Date: Mon, 14 Nov 2016 08:55:22 -0800
MIME-Version: 1.0
In-Reply-To: <6dfb1793-ca6a-c3b6-b3fc-272e68ca6880@sandisk.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/25/2016 07:54 PM, Bart Van Assche wrote:
> Avoid that sparse complains about unbalanced lock actions.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> ---
>  block/bsg-lib.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
> index 650f427..b2a61e3 100644
> --- a/block/bsg-lib.c
> +++ b/block/bsg-lib.c
> @@ -161,6 +161,8 @@ failjob_rls_job:
>   * Drivers/subsys should pass this to the queue init function.
>   */
>  void bsg_request_fn(struct request_queue *q)
> +	__releases(q->queue_lock)
> +	__acquires(q->queue_lock)
>  {
>  	struct device *dev = q->queuedata;
>  	struct request *req;
>

Hi Jens,

Do you agree with this patch? If so, can you queue it for kernel v4.10?

Thanks,

Bart.
