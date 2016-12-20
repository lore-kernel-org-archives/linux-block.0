Return-Path: <prvs=1162d78414=axboe@fb.com>
Subject: Re: [PATCH 3/8] block: move rq_ioc() to blk.h
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-4-git-send-email-axboe@fb.com>
 <5A31E864-F10C-4CB4-B780-BB16524E3590@linaro.org>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Linux-Kernal
	<linux-kernel@vger.kernel.org>, <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f9d3a21d-0ffc-4b54-6e27-48d8befab1b5@fb.com>
Date: Tue, 20 Dec 2016 08:46:49 -0700
MIME-Version: 1.0
In-Reply-To: <5A31E864-F10C-4CB4-B780-BB16524E3590@linaro.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 12/20/2016 03:12 AM, Paolo Valente wrote:
> 
>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> We want to use it outside of blk-core.c.
>>
> 
> Hi Jens,
> no hooks equivalent to elevator_init_icq_fn and elevator_exit_icq_fn
> are invoked.  In particular, the second hook let bfq (as with cfq)
> know when it could finally exit the queue associated with the icq.
> I'm trying to figure out how to make it without these hooks/signals,
> but at no avail so far ...

Yep, those need to be added.

-- 
Jens Axboe
