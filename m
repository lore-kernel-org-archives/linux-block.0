Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] Revert "block: Add warning for bi_next not NULL in
 bio_endio()"
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>
References: <20180619172640.15246-1-bart.vanassche@wdc.com>
 <20180619181618.GA19298@kmo-pixel>
 <d843bf23df736e4fe557a960564a180ada187db5.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <712318c9-1554-8fe2-6bf2-8bda6fd6fe8f@kernel.dk>
Date: Tue, 19 Jun 2018 12:19:25 -0600
MIME-Version: 1.0
In-Reply-To: <d843bf23df736e4fe557a960564a180ada187db5.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/19/18 12:17 PM, Bart Van Assche wrote:
> On Tue, 2018-06-19 at 14:16 -0400, Kent Overstreet wrote:
>> I take it if we had a test for request based dm in blktests or somewhere that
>> probably would have caught this much easier :/
> 
> I'm working on porting the srp-test software to the blktests framework.

That's awesome, would be a great addition!

-- 
Jens Axboe
