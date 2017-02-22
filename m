Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <6d5d4b2b-5343-09ff-72c3-4e9a7e591d68@kernel.dk>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
 <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
 <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk> <CA+55aFwkdDmO0LPYv8g=VxCXuxF4_JRHdG7-tfF4QSRvQYJFKQ@mail.gmail.com>
 <6d5d4b2b-5343-09ff-72c3-4e9a7e591d68@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Feb 2017 10:26:54 -0800
Message-ID: <CA+55aFxFtiAz2nnczcBQLPS6sMwgRnDq-j6U-s1yPS=mN2VgAQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 22, 2017 at 10:14 AM, Jens Axboe <axboe@kernel.dk> wrote:
>
> What do you mean by "the regular IO scheduler"? These are different
> schedulers.

Not to the user they aren't.

If the user already answered once about the IO schedulers, we damn
well shouldn't ask again abotu another small implementaiton detail.

How hard is this to understand? You're asking users stupid things.

It's not just about the wording. It's a fundamental issue.  These
questions are about internal implementation details. They make no
sense to a user. They don't even make sense to a kernel developer, for
chrissake!

Don't make the kconfig mess worse. This "we can't make good defaults
in the kernel, so ask users about random things that they cannot
possibly answer" model is not an acceptable model.

If the new schedulers aren't better than NOOP, they shouldn't exist.
And if you want people to be able to test, they should be dynamic.

And dammit, IF YOU DON'T EVEN KNOW, WHY THE HELL ARE YOU ASKING THE POOR USER?

It's really that simple.

             Linus
