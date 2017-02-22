Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
 <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
 <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk>
 <CA+55aFwkdDmO0LPYv8g=VxCXuxF4_JRHdG7-tfF4QSRvQYJFKQ@mail.gmail.com>
 <6d5d4b2b-5343-09ff-72c3-4e9a7e591d68@kernel.dk>
 <CA+55aFxFtiAz2nnczcBQLPS6sMwgRnDq-j6U-s1yPS=mN2VgAQ@mail.gmail.com>
 <316818ab-64ff-89b7-79e4-05a7b3159a38@kernel.dk>
 <CA+55aFzK6j+jM8eHcMirbe2huV1RKEmqwrKTYH9YuXWBYZxsug@mail.gmail.com>
 <2fa1c161-2893-438a-45f9-adbf5284ee71@kernel.dk>
 <CA+55aFx+FUWAY9zDyULbsy-Xqf9YhK3kOBskurMPSainYbSQcw@mail.gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9f6e0c1e-fe62-9898-d074-edc05310cebe@kernel.dk>
Date: Wed, 22 Feb 2017 11:58:58 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFx+FUWAY9zDyULbsy-Xqf9YhK3kOBskurMPSainYbSQcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/22/2017 11:56 AM, Linus Torvalds wrote:
> On Wed, Feb 22, 2017 at 10:52 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> It's that simple.
>>
>> No, it's not that simple at all. Fact is, some optimizations make sense
>> for some workloads, and some do not.
> 
> Are you even listening?
> 
> I'm saying no user can ever give a sane answer to your question. The
> question is insane and wrong.
> 
> I already said you can have a dynamic configuration (and maybe even an
> automatic heuristic - like saying that a ramdisk gets NOOP by default,
> real hardware does not).
> 
> But asking a user at kernel config time for a default is insane. If
> *you* cannot answer it, then the user sure as hell cannot.
> 
> Other configuration questions have problems too, but at least the
> question about "should I support ext4" is something a user (or distro)
> can sanely answer. So your comparisons are pure bullshit.

As per the previous email, this was my proposed solution:

OK, so here's what I'll do:

1) We'll kill the default scheduler choices. sq blk-mq will default to
   mq-deadline, mq blk-mq will default to "none" (at least for now, until
   the new scheduler is done).
2) The individual schedulers will be y/m/n selectable, just like any
   other driver.

Any further settings on that can be done at runtime, through sysfs.

-- 
Jens Axboe
