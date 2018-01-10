Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/4] block: remove REQ_ATOM_POLL_SLEPT
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "osandov@fb.com" <osandov@fb.com>
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
 <1515544167-10751-2-git-send-email-axboe@kernel.dk>
 <1515608737.2745.11.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e7924d15-6160-ed15-039c-ed2bfee417e4@kernel.dk>
Date: Wed, 10 Jan 2018 11:32:43 -0700
MIME-Version: 1.0
In-Reply-To: <1515608737.2745.11.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/10/18 11:25 AM, Bart Van Assche wrote:
> On Tue, 2018-01-09 at 17:29 -0700, Jens Axboe wrote:
>> We don't need this to be an atomic flag, it can be a regular
>> flag. We either end up on the same CPU for the polling, in which
>> case the state is sane, or we did the sleep which would imply
>> the needed barrier to ensure we see the right state.
> 
> Please consider updating rqf_name[] in blk-mq-debugfs.c.

Good catch - I'll do that, and also add a small prep patch that syncs
with the current situation, looks like we're missing the timeout
and zone locked flags.

-- 
Jens Axboe
