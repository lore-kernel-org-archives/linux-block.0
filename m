Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: don't allow write on attributes with
 seq_operations set
To: Ming Lei <ming.lei@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
References: <20180123172000.20919-1-eguan@redhat.com>
 <9b37df1b-6a3e-2d24-f1f3-de34d8c690d9@kernel.dk>
 <20180124034925.GA16074@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a15d3c9c-36e1-9e41-f584-09bdb90631fb@kernel.dk>
Date: Wed, 24 Jan 2018 09:45:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180124034925.GA16074@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/23/18 8:49 PM, Ming Lei wrote:
> On Tue, Jan 23, 2018 at 02:32:06PM -0700, Jens Axboe wrote:
>> On 1/23/18 10:20 AM, Eryu Guan wrote:
>>> Attributes that only implement .seq_ops are read-only, any write to
>>> them should be rejected. But currently kernel would crash when
>>> writing to such debugfs entries, e.g.
>>>
>>> chmod +w /sys/kernel/debug/block/<dev>/requeue_list
>>> echo 0 > /sys/kernel/debug/block/<dev>/requeue_list
>>> chmod -w /sys/kernel/debug/block/<dev>/requeue_list
>>>
>>> Fix it by returning -EPERM in blk_mq_debugfs_write() when writing to
>>> such attributes.
>>
>> I don't particularly like the fix, since it's not really clear why
>> that comparison makes sense. Can't we just prevent anyone from
> 
> It might be the simplest way to check if the attribute defines .seq_ops
> or not. If it is .seq_ops, it is wrong to interpret m->private as
> 'struct blk_mq_debugfs_attr *' because it actually points to 'struct
> request_queue *' or others, which depends on the specific attribute.
> 
> So it works for avoiding the oops.
> 
>> making the debugfs entries writable? Seems like a much more sane
>> approach.
> 
> I guess fs should allow root user to do 'chmod +w' on files in proc,
> debugfs or sysfs. I just tried, it works on proc, debugfs and sysfs.

Yeah good point, I guess the proposed fix is the simplest version
we can do. At least it has a comment. I'll apply it, thanks.

-- 
Jens Axboe
