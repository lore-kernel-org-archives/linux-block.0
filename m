Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <20160701024328.GA9765@vader>
References: <CACT4Y+Y5rj9cnOrY6LY7NRa6OvVzLcDdg=ns7TA9Wnd3R02+wQ@mail.gmail.com>
 <20160701024328.GA9765@vader>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 1 Jul 2016 10:31:29 +0200
Message-ID: <CACT4Y+bY1dgAnAAa2_v3UBy+n7raRRJe1P8c7_DXZh+LR=ms3Q@mail.gmail.com>
Subject: Re: block: GPF in get_task_ioprio
To: Omar Sandoval <osandov@osandov.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>,
	Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 1, 2016 at 4:43 AM, Omar Sandoval <osandov@osandov.com> wrote:
> On Thu, Jun 30, 2016 at 10:50:44AM +0200, Dmitry Vyukov wrote:
>> Hello,
>>
>> The following program triggers GPF in get_task_ioprio if run in a parallel loop:
>
> Dmitry,
>
> Could you please try the below?
>
> diff --git a/block/ioprio.c b/block/ioprio.c
> index cc7800e9eb44..01b8116298a1 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -150,8 +150,10 @@ static int get_task_ioprio(struct task_struct *p)
>         if (ret)
>                 goto out;
>         ret = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, IOPRIO_NORM);
> +       task_lock(p);
>         if (p->io_context)
>                 ret = p->io_context->ioprio;
> +       task_unlock(p);
>  out:
>         return ret;
>  }
>
> I'm having a hard time reproducing it but I can see how it could happen;
> I think `p->io_context` is getting freed in exit_io_context() in between
> the `if (p->io_context)` and `ret = p->io_context->ioprio`.


I see that you were able to reproduce it. So I am not testing it.
