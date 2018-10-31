Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 06/16] blk-mq: add 'type' attribute to the sysfs hctx
 directory
To: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-7-axboe@kernel.dk>
 <2d858eb1-56d6-5c3e-7c7e-9e36b1ad04fc@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a7dc22ab-73b5-f869-07b5-51ddf7d795dd@kernel.dk>
Date: Wed, 31 Oct 2018 08:21:34 -0600
MIME-Version: 1.0
In-Reply-To: <2d858eb1-56d6-5c3e-7c7e-9e36b1ad04fc@grimberg.me>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/30/18 6:53 PM, Sagi Grimberg wrote:
> 
>> It can be useful for a user to verify what type a given hardware
>> queue is, expose this information in sysfs.
> 
> I assume the user is expected to understand the meaning of the
> enumeration it sees in accessing this field correct?
> 
> Would be nice to output some meaningful string but I'm not
> yet sure how to do that, but would be nice...

The type is driver private, there's no specific meaning associated
with the type. We could make it output a string provided that
the driver had a way to query it. For now I think the type is
enough, it'll allow you to see which ones are different.

> Other than that,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Thanks

-- 
Jens Axboe
