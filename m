Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] blktest: remove instances of null_blk queue_mode=1
To: Omar Sandoval <osandov@osandov.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <dbede61b-13fb-5b5e-3827-fd4b831f9004@kernel.dk>
 <20181025210846.GA29982@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <db3fc4e9-9822-dfaa-27f7-ddaa445deff0@kernel.dk>
Date: Thu, 25 Oct 2018 15:11:22 -0600
MIME-Version: 1.0
In-Reply-To: <20181025210846.GA29982@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 3:08 PM, Omar Sandoval wrote:
> On Thu, Oct 25, 2018 at 03:03:30PM -0600, Jens Axboe wrote:
>> This is no longer supported in recent kernels, get rid of
>> any testing of queue_mode=1. queue_mode=1 tested the legacy
>> IO path, which is going away completely. As such, there's
>> no point in doing anymore testing with it.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Thanks, applied this squashed it with the one removing block/022.

Thanks Omar!

-- 
Jens Axboe
