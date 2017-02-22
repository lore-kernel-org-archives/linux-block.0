Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <2fa1c161-2893-438a-45f9-adbf5284ee71@kernel.dk>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
 <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
 <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk> <CA+55aFwkdDmO0LPYv8g=VxCXuxF4_JRHdG7-tfF4QSRvQYJFKQ@mail.gmail.com>
 <6d5d4b2b-5343-09ff-72c3-4e9a7e591d68@kernel.dk> <CA+55aFxFtiAz2nnczcBQLPS6sMwgRnDq-j6U-s1yPS=mN2VgAQ@mail.gmail.com>
 <316818ab-64ff-89b7-79e4-05a7b3159a38@kernel.dk> <CA+55aFzK6j+jM8eHcMirbe2huV1RKEmqwrKTYH9YuXWBYZxsug@mail.gmail.com>
 <2fa1c161-2893-438a-45f9-adbf5284ee71@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Feb 2017 10:56:51 -0800
Message-ID: <CA+55aFx+FUWAY9zDyULbsy-Xqf9YhK3kOBskurMPSainYbSQcw@mail.gmail.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 22, 2017 at 10:52 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> It's that simple.
>
> No, it's not that simple at all. Fact is, some optimizations make sense
> for some workloads, and some do not.

Are you even listening?

I'm saying no user can ever give a sane answer to your question. The
question is insane and wrong.

I already said you can have a dynamic configuration (and maybe even an
automatic heuristic - like saying that a ramdisk gets NOOP by default,
real hardware does not).

But asking a user at kernel config time for a default is insane. If
*you* cannot answer it, then the user sure as hell cannot.

Other configuration questions have problems too, but at least the
question about "should I support ext4" is something a user (or distro)
can sanely answer. So your comparisons are pure bullshit.

                     Linus
