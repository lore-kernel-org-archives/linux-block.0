Return-Path: <axboe@kernel.dk>
Subject: Re: [WIP BRANCH] cgroups support in bfq-mq WIP branch
To: Paolo Valente <paolo.valente@linaro.org>
References: <CBE2870C-EEB4-4C2E-A5A3-20C37E16B6AE@linaro.org>
 <97eadcb9-5049-399a-e5a7-d4f8b821756b@kernel.dk>
 <3410FACF-D8AF-41FA-B38B-9EFAE6B301F0@linaro.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fd6a9297-3987-d0ed-22ae-b490b8dc5496@kernel.dk>
Date: Thu, 2 Mar 2017 08:19:05 -0700
MIME-Version: 1.0
In-Reply-To: <3410FACF-D8AF-41FA-B38B-9EFAE6B301F0@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/02/2017 03:15 AM, Paolo Valente wrote:
> 
>> Il giorno 25 feb 2017, alle ore 19:52, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 02/25/2017 10:44 AM, Paolo Valente wrote:
>>> Hi,
>>> I've just completed cgroups support, and I'd like to highlight the
>>> main blk-mq issue that I have found along the way.  I have pushed the
>>> commit that completes the support for cgroups to the usual WIP branch
>>> [1].  Before moving to this issue, I have preliminary question about
>>> the scheduler name, since I'm about to start preparing the patch
>>> series for submission.  So far, I have used bfq-mq as a temporary
>>> name.  Are we fine with it, or should I change it, for example, to
>>> just bfq?  Jens?
>>
>> Just call it 'bfq', that doesn't conflict with anything that's
>> in the kernel already.
>>
> 
> ok
> 
>>> I've found a sort of circular dependency in blk-mq, related to
>>> scheduler initialization.  To describe both the issue and how I've
>>> addressed it, I'm pasting the message of the new commit.
>>
>> Rebase your patches on top of Linus current master, some of them
>> will need to change and some can be dropped.
>>
> 
> Done, but the last deadlock issue shows up again :( To help you get
> context, I'm going to reply to the email in which your sent the patch that
> solved it.

OK, I got that sent to you. When you have tested it, just add it as
a prep patch in your series. If it works for you, then let me know
and I'll add your Tested-by: to that patch and post it for more
thorough review.

-- 
Jens Axboe
