Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 06/16] blk-mq: add 'type' attribute to the sysfs hctx
 directory
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-7-axboe@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2d858eb1-56d6-5c3e-7c7e-9e36b1ad04fc@grimberg.me>
Date: Tue, 30 Oct 2018 17:53:43 -0700
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-7-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> It can be useful for a user to verify what type a given hardware
> queue is, expose this information in sysfs.

I assume the user is expected to understand the meaning of the
enumeration it sees in accessing this field correct?

Would be nice to output some meaningful string but I'm not
yet sure how to do that, but would be nice...

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
