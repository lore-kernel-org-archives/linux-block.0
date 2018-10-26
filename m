Return-Path: <kt0755@gmail.com>
MIME-Version: 1.0
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
 <46e927f8-268c-866c-75f7-d1406252759a@kernel.dk> <CAEAjamvAO-Y5-Zg3d3agk1pd84L=FMxB_173sTr4rRAVN9fmRA@mail.gmail.com>
 <5f679738-3106-78e0-dd16-2335c4f369aa@kernel.dk>
In-Reply-To: <5f679738-3106-78e0-dd16-2335c4f369aa@kernel.dk>
From: Kyungtae Kim <kt0755@gmail.com>
Date: Fri, 26 Oct 2018 11:06:30 -0400
Message-ID: <CAEAjamtTcLHhFZ_k6DCyTGS8WntKBeqUBVvJWB7jkAZnd+eq5g@mail.gmail.com>
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in setup_rw_floppy()
To: Jens Axboe <axboe@kernel.dk>
Cc: jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
	DaeRyong Jeong <threeearcat@gmail.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Let me try to use git as email client.


Thanks,
Kyungtae Kim
On Fri, Oct 26, 2018 at 10:57 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/26/18 8:51 AM, Kyungtae Kim wrote:
> > Do you mean mail client?? Well, I'm currently using gmail.
>
> Yes, email client. I've never sent patches with gmail, so can't
> say if that works or not. OK, just checked
>
> Documentation/process/email-clients.rst
>
> and is states that:
>
> "Gmail (Web GUI)
> ***************
>
> Does not work for sending patches.
>
> Gmail web client converts tabs to spaces automatically."
>
> so I guess that won't work for you. You can use git send-email
> with gmail smtp, that's what I do. Or read the above file to figure out
> what will work the best for you.
>
> --
> Jens Axboe
>
