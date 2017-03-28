Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-stat: add a poll_size value to the request_queue
 struct
To: Stephen Bates <sbates@raithlin.com>, Sagi Grimberg <sagi@grimberg.me>
References: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
 <1490494692-2416-3-git-send-email-sbates@raithlin.com>
 <44296e0a-fb04-888b-aa00-a9b01709e1b8@grimberg.me>
 <25CE7F43-DD1B-42D6-A891-A3D916BD0877@raithlin.com>
 <88815dc6-04b2-0915-597d-1e335b6d2ba2@kernel.dk>
 <C52E2CE3-0F92-40EA-902F-A9B70B145F1A@raithlin.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 "osandov@osandov.com" <osandov@osandov.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fd49a447-153e-cad9-63ca-216ab6db7fb8@kernel.dk>
Date: Tue, 28 Mar 2017 14:38:33 -0600
MIME-Version: 1.0
In-Reply-To: <C52E2CE3-0F92-40EA-902F-A9B70B145F1A@raithlin.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 03/28/2017 01:58 PM, Stephen  Bates wrote:
>>>
>>> Thanks for the review Sagi. I’d be OK going with <=0 as the exact
>>> match would normally be for minimal IO sizes (where <= and = are the
>>> same thing). I will see what other feedback I get and aim to do a
>>> respin soon…
>>
>> No tunables for this, please. There's absolutely no reason why we should
>> need it.
> 
> Jens – by this you mean you want to only bucket IO that are exactly
> the minimum block size supported by the underlying block device? I was
> envisioning we might want to relax that in certain cases (e.g. bucket
> 4KB and below going to a 512B device).

Sorry, the above was a bit terse. I think a much better solution would
be to create a number of buckets (per data direction) and do stats on
all of them. The buckets would cover a reasonable range of request
sizes. Then when you poll for a given request, we can base our timed
number on the data direction AND size of it. You can get pretty far with
a few buckets:

512b
4k
8k
16k
32k
64k
128k

and you could even have your time estimation function turn these into
something sane. Or just use a composite of buckets, if you wish.

-- 
Jens Axboe
