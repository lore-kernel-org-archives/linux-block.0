Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 17/17] null_blk: remove legacy IO path
To: Johannes Thumshirn <jthumshirn@suse.de>,
 Dongli Zhang <dongli.zhang@oracle.com>
Cc: linux-block@vger.kernel.org
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-18-axboe@kernel.dk>
 <b60e8ad5-3af7-766a-c3c2-b35b0d5fd779@oracle.com>
 <477afa55-24b3-b0ac-0f69-0ebe74beb11c@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0f67146e-6db3-56d7-5500-7a3d31b2ed91@kernel.dk>
Date: Fri, 12 Oct 2018 08:18:24 -0600
MIME-Version: 1.0
In-Reply-To: <477afa55-24b3-b0ac-0f69-0ebe74beb11c@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 2:51 AM, Johannes Thumshirn wrote:
> On 12/10/18 08:56, Dongli Zhang wrote:
>> Hi Jens,
>>
>> Will the legacy path be fully deprecated?
>>
>> In addition to performance measurement, null_blk is a very good tutorial for
>> beginners to understand how to implement a legacy path based block driver from
>> scratch. Unless legacy path is not used any longer, why not keep it in the code
>> as a tutorial?
> 
> But when there is no tutorial on how to write drivers for the legacy
> path no one will write drivers for the legacy path and will be upset
> when we remove it.

Plus the legacy path is going away right now, that's the whole point of
this series of patches. Once this is done, I'm killing all that code.

The whole point of legacy is that it's, well, legacy. Nobody should
be writing that style of driver anymore. null_blk has a clean blk-mq
implementation, that's what people can look at if they want to learn
how to write a new blk-mq driver.

-- 
Jens Axboe
