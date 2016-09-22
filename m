Return-Path: <prvs=8073c3c87f=jbacik@fb.com>
Subject: Re: [PATCH 0/2]: Add option for async ->queue_rq
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <6f65d509-622e-6e65-dccd-ced0a37422ee@fb.com>
Date: Thu, 22 Sep 2016 14:01:48 -0400
MIME-Version: 1.0
In-Reply-To: <1474555980-2787-1-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/22/2016 10:52 AM, Jens Axboe wrote:
> Two patches that add the ability for a driver to flag itself
> as wanting the ->queue_rq() invoked in a manner that allows
> it to block. We'll need that for the nbd conversion, to avoid
> having to add workqueue offload. We can use this in the current
> loop mq path as well.
>
>

You can add my

Tested-by: Josef Bacik <jbacik@fb.com>

to these.  Thanks,

Josef
