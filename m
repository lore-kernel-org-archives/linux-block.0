Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in
 setup_rw_floppy()
To: Kyungtae Kim <kt0755@gmail.com>
Cc: jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
 DaeRyong Jeong <threeearcat@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
 <46e927f8-268c-866c-75f7-d1406252759a@kernel.dk>
 <CAEAjamvAO-Y5-Zg3d3agk1pd84L=FMxB_173sTr4rRAVN9fmRA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5f679738-3106-78e0-dd16-2335c4f369aa@kernel.dk>
Date: Fri, 26 Oct 2018 08:57:27 -0600
MIME-Version: 1.0
In-Reply-To: <CAEAjamvAO-Y5-Zg3d3agk1pd84L=FMxB_173sTr4rRAVN9fmRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/26/18 8:51 AM, Kyungtae Kim wrote:
> Do you mean mail client?? Well, I'm currently using gmail.

Yes, email client. I've never sent patches with gmail, so can't
say if that works or not. OK, just checked

Documentation/process/email-clients.rst

and is states that:

"Gmail (Web GUI)
***************
 
Does not work for sending patches.

Gmail web client converts tabs to spaces automatically."

so I guess that won't work for you. You can use git send-email
with gmail smtp, that's what I do. Or read the above file to figure out
what will work the best for you.

-- 
Jens Axboe
