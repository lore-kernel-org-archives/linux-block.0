Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 06/16] blk-mq: add 'type' attribute to the sysfs hctx
 directory
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-7-axboe@kernel.dk> <20181101215957.GH18005@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <163b5cc9-8106-9369-9675-f93bca24cd81@kernel.dk>
Date: Thu, 1 Nov 2018 16:50:22 -0600
MIME-Version: 1.0
In-Reply-To: <20181101215957.GH18005@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/1/18 3:59 PM, Omar Sandoval wrote:
> On Tue, Oct 30, 2018 at 12:32:42PM -0600, Jens Axboe wrote:
>> It can be useful for a user to verify what type a given hardware
>> queue is, expose this information in sysfs.
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq-sysfs.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
> 
> Out of curiousity, why sysfs instead of debugfs?

I don't feel that strongly about it, but it is a property
like the mapped CPUs, for instance, so kind of makes sense to
put it there rather than in debugfs.

-- 
Jens Axboe
