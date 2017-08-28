Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block, scheduler: convert xxx_var_store to void
To: weiping zhang <zhangweiping@didichuxing.com>
References: <20170824171127.GA25877@localhost.didichuxing.com>
 <20170828122156.GA29322@localhost.didichuxing.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ad4b9407-6dd0-0a03-9c36-5e9da24b056a@kernel.dk>
Date: Mon, 28 Aug 2017 10:00:46 -0600
MIME-Version: 1.0
In-Reply-To: <20170828122156.GA29322@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/28/2017 06:22 AM, weiping zhang wrote:
> On Fri, Aug 25, 2017 at 01:11:33AM +0800, weiping zhang wrote:
>> The last parameter "count" never be used in xxx_var_store,
>> convert these functions to void.
>>
>
> Would you please look this misc patch at your convenience ?

Looks fine. But please don't send reminders so shortly after sending a
patch, especially when it's just a cleanup. This was received Thursday.

-- 
Jens Axboe
