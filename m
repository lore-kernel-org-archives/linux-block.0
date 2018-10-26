Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in
 setup_rw_floppy()
To: Kyungtae Kim <kt0755@gmail.com>
Cc: jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
 DaeRyong Jeong <threeearcat@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <46e927f8-268c-866c-75f7-d1406252759a@kernel.dk>
Date: Fri, 26 Oct 2018 08:41:23 -0600
MIME-Version: 1.0
In-Reply-To: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/26/18 8:39 AM, Kyungtae Kim wrote:

> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index a8cfa01..41160a1 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *param,
>                          */
>                 return -EINVAL;
> 
> +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
> +               return -EINVAL;
> +
>         for (i = 0; i < 16; i++)
>                 ptr->reply[i] = 0;
>         ptr->resultcode = 0;

Almost there, the tabs have been turned into spaces. This could be
a mailer issue, what are you using to send out the patch?

-- 
Jens Axboe
