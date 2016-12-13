Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 1/7] blk-mq: add blk_mq_start_stopped_hw_queue()
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-2-git-send-email-axboe@fb.com>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <9b29a574-80a4-be92-05cb-bf8b94536781@sandisk.com>
Date: Tue, 13 Dec 2016 09:48:52 +0100
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-2-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 09:13 PM, Jens Axboe wrote:
> We have a variant for all hardware queues, but not one for a single
> hardware queue.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
