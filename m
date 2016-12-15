Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
From: Bart Van Assche <bart.vanassche@gmail.com>
Subject: Re: [PATCH 2/7] blk-mq: make mq_ops a const pointer
To: Jens Axboe <axboe@fb.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1481779568-10642-1-git-send-email-axboe@fb.com>
 <1481779568-10642-3-git-send-email-axboe@fb.com>
Cc: paolo.valente@linaro.org, osandov@fb.com
Message-ID: <98bea114-b9e5-90c4-b309-5960dc08bddf@acm.org>
Date: Thu, 15 Dec 2016 17:23:03 +0100
MIME-Version: 1.0
In-Reply-To: <1481779568-10642-3-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/15/2016 06:26 AM, Jens Axboe wrote:
> We never change it, make that clear.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
