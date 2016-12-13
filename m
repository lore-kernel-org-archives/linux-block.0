Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 2/7] blk-mq: abstract out blk_mq_dispatch_rq_list() helper
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-3-git-send-email-axboe@fb.com>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <2405d895-721d-6ae4-4f9f-4b3353452efc@sandisk.com>
Date: Tue, 13 Dec 2016 09:51:58 +0100
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-3-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 09:13 PM, Jens Axboe wrote:
> +static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
> +{
> +	LIST_HEAD(rq_list);
> +	LIST_HEAD(driver_list);

Hello Jens,

driver_list is not used in this function so please consider removing 
that variable from blk_mq_process_rq_list(). Otherwise this patch looks 
fine to me.

Bart.
