Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <316818ab-64ff-89b7-79e4-05a7b3159a38@kernel.dk>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
 <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
 <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk> <CA+55aFwkdDmO0LPYv8g=VxCXuxF4_JRHdG7-tfF4QSRvQYJFKQ@mail.gmail.com>
 <6d5d4b2b-5343-09ff-72c3-4e9a7e591d68@kernel.dk> <CA+55aFxFtiAz2nnczcBQLPS6sMwgRnDq-j6U-s1yPS=mN2VgAQ@mail.gmail.com>
 <316818ab-64ff-89b7-79e4-05a7b3159a38@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Feb 2017 10:45:08 -0800
Message-ID: <CA+55aFzK6j+jM8eHcMirbe2huV1RKEmqwrKTYH9YuXWBYZxsug@mail.gmail.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 22, 2017 at 10:41 AM, Jens Axboe <axboe@kernel.dk> wrote:
>
> The fact is that we have two different sets, until we can yank
> the old ones. So I can't just ask one question, since the sets
> aren't identical.

Bullshit.

I'm, saying: rip out the question ENTIRELY. For *both* cases.

If you cannot yourself give a good answer, then there's no f*cking way
any user can give a good answer. So asking the question is totally and
utterly pointless.

All it means is that different people will try different (in random
ways) configurations, and the end result is random crap.

So get rid of those questions. Pick a default, and live with it. And
if people complain about performance, fix the performance issue.

It's that simple.

                Linus
