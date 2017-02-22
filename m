Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <9f6e0c1e-fe62-9898-d074-edc05310cebe@kernel.dk>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
 <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
 <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk> <CA+55aFwkdDmO0LPYv8g=VxCXuxF4_JRHdG7-tfF4QSRvQYJFKQ@mail.gmail.com>
 <6d5d4b2b-5343-09ff-72c3-4e9a7e591d68@kernel.dk> <CA+55aFxFtiAz2nnczcBQLPS6sMwgRnDq-j6U-s1yPS=mN2VgAQ@mail.gmail.com>
 <316818ab-64ff-89b7-79e4-05a7b3159a38@kernel.dk> <CA+55aFzK6j+jM8eHcMirbe2huV1RKEmqwrKTYH9YuXWBYZxsug@mail.gmail.com>
 <2fa1c161-2893-438a-45f9-adbf5284ee71@kernel.dk> <CA+55aFx+FUWAY9zDyULbsy-Xqf9YhK3kOBskurMPSainYbSQcw@mail.gmail.com>
 <9f6e0c1e-fe62-9898-d074-edc05310cebe@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Feb 2017 11:04:35 -0800
Message-ID: <CA+55aFzokxXsAJSnJb5n6k0haNW5_7SpVmq9EZ0ZXfAVpAmSow@mail.gmail.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 22, 2017 at 10:58 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 02/22/2017 11:56 AM, Linus Torvalds wrote:
>
> OK, so here's what I'll do:
>
> 1) We'll kill the default scheduler choices. sq blk-mq will default to
>    mq-deadline, mq blk-mq will default to "none" (at least for now, until
>    the new scheduler is done).
> 2) The individual schedulers will be y/m/n selectable, just like any
>    other driver.

Yes. That makes sense as options. I can (or, perhaps even more
importantly, a distro can) answer those kinds of questions.

                   Linus
