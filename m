Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] elevator: fix truncation of icq_cache_name
To: Eric Biggers <ebiggers3@gmail.com>, linux-block@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
References: <20170603033551.17261-1-ebiggers3@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <193a1c8b-f2bc-5075-3cf5-3efb103faab2@kernel.dk>
Date: Tue, 6 Jun 2017 11:21:25 -0600
MIME-Version: 1.0
In-Reply-To: <20170603033551.17261-1-ebiggers3@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/02/2017 09:35 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> gcc 7.1 reports the following warning:
> 
>     block/elevator.c: In function ‘elv_register’:
>     block/elevator.c:898:5: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
>          "%s_io_cq", e->elevator_name);
>          ^~~~~~~~~~
>     block/elevator.c:897:3: note: ‘snprintf’ output between 7 and 22 bytes into a destination of size 21
>        snprintf(e->icq_cache_name, sizeof(e->icq_cache_name),
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          "%s_io_cq", e->elevator_name);
>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The bug is that the name of the icq_cache is 6 characters longer than
> the elevator name, but only ELV_NAME_MAX + 5 characters were reserved
> for it --- so in the case of a maximum-length elevator name, the 'q'
> character in "_io_cq" would be truncated by snprintf().  Fix it by
> reserving ELV_NAME_MAX + 6 characters instead.

Added, thanks.

-- 
Jens Axboe
