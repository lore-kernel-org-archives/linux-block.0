Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 7/7] blk-mq-sched: allow setting of default IO scheduler
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-8-git-send-email-axboe@fb.com>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <3e4483e3-6018-5c6c-9fe2-128ed68c01f4@sandisk.com>
Date: Tue, 13 Dec 2016 11:13:48 +0100
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-8-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 09:13 PM, Jens Axboe wrote:
> +config DEFAULT_MQ_IOSCHED
> +	string
> +	default "mq-deadline" if DEFAULT_MQ_DEADLINE
> +	default "none" if DEFAULT_MQ_NONE
> +
>  endmenu
>
> +config MQ_IOSCHED_ONLY_SQ
> +	bool "Enable blk-mq IO scheduler only for single queue devices"
> +	default y
> +	help
> +	  Say Y here, if you only want to enable IO scheduling on block
> +	  devices that have a single queue registered.
> +
>  endif

Hello Jens,

Shouln't the MQ_IOSCHED_ONLY_SQ entry be placed before "endmenu" such 
that it is displayed in the I/O scheduler menu instead of the block menu?

Bart.
