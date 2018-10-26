Return-Path: <kt0755@gmail.com>
MIME-Version: 1.0
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
 <46e927f8-268c-866c-75f7-d1406252759a@kernel.dk>
In-Reply-To: <46e927f8-268c-866c-75f7-d1406252759a@kernel.dk>
From: Kyungtae Kim <kt0755@gmail.com>
Date: Fri, 26 Oct 2018 10:51:07 -0400
Message-ID: <CAEAjamvAO-Y5-Zg3d3agk1pd84L=FMxB_173sTr4rRAVN9fmRA@mail.gmail.com>
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in setup_rw_floppy()
To: Jens Axboe <axboe@kernel.dk>
Cc: jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
	DaeRyong Jeong <threeearcat@gmail.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Do you mean mail client?? Well, I'm currently using gmail.

On Fri, Oct 26, 2018 at 10:41 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/26/18 8:39 AM, Kyungtae Kim wrote:
>
> > diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> > index a8cfa01..41160a1 100644
> > --- a/drivers/block/floppy.c
> > +++ b/drivers/block/floppy.c
> > @@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *param,
> >                          */
> >                 return -EINVAL;
> >
> > +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
> > +               return -EINVAL;
> > +
> >         for (i = 0; i < 16; i++)
> >                 ptr->reply[i] = 0;
> >         ptr->resultcode = 0;
>
> Almost there, the tabs have been turned into spaces. This could be
> a mailer issue, what are you using to send out the patch?
>
> --
> Jens Axboe
>
