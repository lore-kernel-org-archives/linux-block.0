Return-Path: <prvs=6335d9f7e=Bart.VanAssche@wdc.com>
Subject: Re: [PATCH v3] blk-mq: Avoid that submitting a bio concurrently with
 device removal triggers a crash
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20180410230240.27709-1-bart.vanassche@wdc.com>
 <20180412062748.GC30499@lst.de>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <3e231879-7845-02de-d8a4-2ee8112e971f@wdc.com>
Date: Thu, 12 Apr 2018 06:14:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180412062748.GC30499@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 04/12/18 00:27, Christoph Hellwig wrote:
> On Tue, Apr 10, 2018 at 05:02:40PM -0600, Bart Van Assche wrote:
>> Because blkcg_exit_queue() is now called from inside blk_cleanup_queue()
>> it is no longer safe to access cgroup information during or after the
>> blk_cleanup_queue() call. Hence protect the generic_make_request_checks()
>> call with blk_queue_enter() / blk_queue_exit().
> 
> I think the problem is that blkcg does weird things from
> blk_cleanup_queue.  I'd rather fix that root cause than working around it.

Hello Christoph,

Can you clarify your comment? generic_make_request_checks() calls 
blkcg_bio_issue_check() and that function in turn calls blkg_lookup() 
and other blkcg functions. Hence this patch that avoids that blkcg code 
is called concurrently with removal of a request queue from blkcg.

Thanks,

Bart.
