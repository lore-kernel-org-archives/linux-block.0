Return-Path: <prvs=1163f1b61b=axboe@fb.com>
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO
 scheduler
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-8-git-send-email-axboe@fb.com>
 <1482321550.2644.10.camel@sandisk.com>
CC: "osandov@fb.com" <osandov@fb.com>,
        "paolo.valente@linaro.org"
	<paolo.valente@linaro.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <705f3ab2-5829-1d30-20ea-dc167cca6582@fb.com>
Date: Wed, 21 Dec 2016 07:22:37 -0700
MIME-Version: 1.0
In-Reply-To: <1482321550.2644.10.camel@sandisk.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

On 12/21/2016 04:59 AM, Bart Van Assche wrote:
> Since this patch is the first patch that introduces a call to
> blk_queue_exit() from a module other than the block layer core,
> shouldn't this patch export the blk_queue_exit() function? An attempt
> to build mq-deadline as a module resulted in the following:
> 
> ERROR: "blk_queue_exit" [block/mq-deadline.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:91: __modpost] Error 1
> make: *** [Makefile:1198: modules] Error 2
> Execution failed: make all

Yes, it should. I'll make the export for now, I want to move that check
and free/drop into the generic code so that the schedulers don't have to
worry about it.

-- 
Jens Axboe
