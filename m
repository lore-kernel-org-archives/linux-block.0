Return-Path: <axboe@kernel.dk>
Subject: Re: [WIP BRANCH] cgroups support in bfq-mq WIP branch
To: Paolo Valente <paolo.valente@linaro.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>
References: <CBE2870C-EEB4-4C2E-A5A3-20C37E16B6AE@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <97eadcb9-5049-399a-e5a7-d4f8b821756b@kernel.dk>
Date: Sat, 25 Feb 2017 11:52:40 -0700
MIME-Version: 1.0
In-Reply-To: <CBE2870C-EEB4-4C2E-A5A3-20C37E16B6AE@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/25/2017 10:44 AM, Paolo Valente wrote:
> Hi,
> I've just completed cgroups support, and I'd like to highlight the
> main blk-mq issue that I have found along the way.  I have pushed the
> commit that completes the support for cgroups to the usual WIP branch
> [1].  Before moving to this issue, I have preliminary question about
> the scheduler name, since I'm about to start preparing the patch
> series for submission.  So far, I have used bfq-mq as a temporary
> name.  Are we fine with it, or should I change it, for example, to
> just bfq?  Jens?

Just call it 'bfq', that doesn't conflict with anything that's
in the kernel already.

> I've found a sort of circular dependency in blk-mq, related to
> scheduler initialization.  To describe both the issue and how I've
> addressed it, I'm pasting the message of the new commit.

Rebase your patches on top of Linus current master, some of them
will need to change and some can be dropped.

And disentangle it completely from the old bfq, I don't want to see
nasty stuff like includes of .c files with prior defines modifying
behavior of functions.

When that's done, get it posted for review asap. I would imagine
we will go through a few postings and review cycles, and if we're
targeting 4.12 with this, then we should get the ball rolling
on that side.

-- 
Jens Axboe
