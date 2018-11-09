Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/3] block: make sure discard/writesame bio is aligned
 with logical block size
To: Ming Lei <ming.lei@redhat.com>, Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-block@vger.kernel.org, stable@vger.kernel.org, snitzer@redhat.com,
 hch@lst.de, xni@redhat.com, mariusz.dabrowski@intel.com
References: <20181029125719.4998-1-ming.lei@redhat.com>
 <20181105034143.GE13699@ming.t460p>
 <CALjTZvbe_bJA8=rOa8k12XmorwGAed_2HcwBEhXKWqgyrXYK7Q@mail.gmail.com>
 <20181107005509.GA3531@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a6256e27-15ec-23f3-104f-a4f5429ffb37@kernel.dk>
Date: Fri, 9 Nov 2018 06:24:29 -0700
MIME-Version: 1.0
In-Reply-To: <20181107005509.GA3531@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/6/18 5:55 PM, Ming Lei wrote:
> On Tue, Nov 06, 2018 at 04:48:13PM +0000, Rui Salvaterra wrote:
>> On Mon, 5 Nov 2018 at 03:41, Ming Lei <ming.lei@redhat.com> wrote:
>>>
>>> V2 addresses Christoph's comment by introducing bio_allowed_max_sectors().
>>>
>>> Ping...
>>>
>>> Thanks,
>>> Ming
>>
>> Hi, Ming,
>>
>> Sorry for the delay. I tested your V2 against Linux 4.20-rc1 and
>> everything seems fine. FWIW, V2 is also
>>
>> Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
> 
> Rui, thanks for your test on V2.
> 
> Jens, what do you think about this patchset?

I waffled on this a bit... I generally don't like cleanup patches for
fixes that are going into the current series.  Those kinds of patches
should be as short and sweet as possible, and cleanup part usually ends
up being the problematic one, ironically enough. But it looks fine to
me, so I've put it in.

-- 
Jens Axboe
