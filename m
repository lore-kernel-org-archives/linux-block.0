Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/2] blk-mq: Add a polling specific stats function
To: Stephen Bates <sbates@raithlin.com>
References: <1491413957-30885-1-git-send-email-sbates@raithlin.com>
 <1491413957-30885-3-git-send-email-sbates@raithlin.com>
 <370c8854-1735-b0e7-089f-4b04068ca4f1@kernel.dk>
 <2AD7D1E1-3906-4ABA-A301-E15DABAF443C@raithlin.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 "osandov@osandov.com" <osandov@osandov.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bb76465b-d708-f5df-e2ec-c99d052e9b27@kernel.dk>
Date: Fri, 7 Apr 2017 08:01:45 -0600
MIME-Version: 1.0
In-Reply-To: <2AD7D1E1-3906-4ABA-A301-E15DABAF443C@raithlin.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 04/07/2017 06:11 AM, Stephen  Bates wrote:
> On 2017-04-05, 7:14 PM, "Jens Axboe" <axboe@kernel.dk> wrote:
> 
>> Why not just have 8 buckets, and make it:
>>
>> 	bucket = ddir + ilog2(bytes) - 9;
>>
>> and cap it at MAX_BUCKET (8) and put all those above into the top
>> bucket.
> 
> Thanks. However, that equation does not differentiate between
> direction and size. Instead we can use
> 
> bucket = ddir + 2*(ilog2(bytes) - 9);

It would be cleaner to just embed the fact that we have 2 sets of
identical buckets, and return 

	bucket = ilog2(bytes) - 9;

and have poll_stat be indexed by:

	->poll_stat[ddir][bucket];

instead.

-- 
Jens Axboe
