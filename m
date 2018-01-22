Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq hangs easily with LLVM+clang test suite
To: David Zarzycki <dave@znu.io>, Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <83F7B94F-562A-44A5-92F9-939FE4FD5A99@znu.io>
 <1516555064.3434.5.camel@wdc.com>
 <964830FA-5F0F-49D3-8608-FBCAF7D60326@znu.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ecec8c7f-48b8-19f2-44ad-6d5ca67a62c4@kernel.dk>
Date: Mon, 22 Jan 2018 10:40:37 -0700
MIME-Version: 1.0
In-Reply-To: <964830FA-5F0F-49D3-8608-FBCAF7D60326@znu.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/21/18 10:39 AM, David Zarzycki wrote:
> Hi Bart,
> 
> I can do [1] and [2] but I won’t be able to provide the command output because the hang is almost total. No new commands can run because the scheduler is hung. For example, see this backtrace:
> 
> http://znu.io/IMG_0362.jpg
> 
> Is there another approach I can use?

Can you try and turn off CONFIG_WBT?

-- 
Jens Axboe
