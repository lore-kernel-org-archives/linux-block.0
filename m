Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [WIP BRANCH] cgroups support in bfq-mq WIP branch
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <97eadcb9-5049-399a-e5a7-d4f8b821756b@kernel.dk>
Date: Thu, 2 Mar 2017 11:15:58 +0100
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>
Message-Id: <3410FACF-D8AF-41FA-B38B-9EFAE6B301F0@linaro.org>
References: <CBE2870C-EEB4-4C2E-A5A3-20C37E16B6AE@linaro.org> <97eadcb9-5049-399a-e5a7-d4f8b821756b@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 25 feb 2017, alle ore 19:52, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 02/25/2017 10:44 AM, Paolo Valente wrote:
>> Hi,
>> I've just completed cgroups support, and I'd like to highlight the
>> main blk-mq issue that I have found along the way.  I have pushed the
>> commit that completes the support for cgroups to the usual WIP branch
>> [1].  Before moving to this issue, I have preliminary question about
>> the scheduler name, since I'm about to start preparing the patch
>> series for submission.  So far, I have used bfq-mq as a temporary
>> name.  Are we fine with it, or should I change it, for example, to
>> just bfq?  Jens?
>=20
> Just call it 'bfq', that doesn't conflict with anything that's
> in the kernel already.
>=20

ok

>> I've found a sort of circular dependency in blk-mq, related to
>> scheduler initialization.  To describe both the issue and how I've
>> addressed it, I'm pasting the message of the new commit.
>=20
> Rebase your patches on top of Linus current master, some of them
> will need to change and some can be dropped.
>=20

Done, but the last deadlock issue shows up again :( To help you get
context, I'm going to reply to the email in which your sent the patch =
that
solved it.


> And disentangle it completely from the old bfq, I don't want to see
> nasty stuff like includes of .c files with prior defines modifying
> behavior of functions.
>=20

Of course.

> When that's done, get it posted for review asap. I would imagine
> we will go through a few postings and review cycles, and if we're
> targeting 4.12 with this, then we should get the ball rolling
> on that side.
>=20

I was about to to submit, but bumped into the above regression.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
