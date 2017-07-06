Return-Path: <maxg@mellanox.com>
Subject: Re: [PATCH 1/1] null_blk: fix error flow for shared tags during
 module_init
To: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <1499347489-10863-1-git-send-email-maxg@mellanox.com>
 <636382e7-4413-6695-7f11-8b6a0ca1a80b@kernel.dk>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <1ec6cce9-0e4b-fb2b-3562-d744d26e38d5@mellanox.com>
Date: Thu, 6 Jul 2017 17:32:25 +0300
MIME-Version: 1.0
In-Reply-To: <636382e7-4413-6695-7f11-8b6a0ca1a80b@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-Path: maxg@mellanox.com
List-ID: <linux-block@vger.kernel.org>



On 7/6/2017 5:02 PM, Jens Axboe wrote:
> On 07/06/2017 07:24 AM, Max Gurtovoy wrote:
>> In case we use shared tags feature, blk_mq_alloc_tag_set might fail
>> during module initialization. Check the return value and default to run
>> without shared tag set before continuing. Also move the tagset
>> initialization process after defining the amount of submition queues.
>
> Fail the load instead. For two reasons:
>
> 1) We could be loading to test this explicitly. null_blk isn't a regular
>    driver, it's not like we're bringing up the system on this thing.
>    Hence I feel it's more important that it loads with what we asked for,
>    or not load at all.
>
> 2) If initializing one tag set fails, the unshared case will surely
>    fail too.
>

Ok. I'll send V2 version soon.
