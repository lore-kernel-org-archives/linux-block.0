Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: don't allow write on attributes with
 seq_operations set
To: Eryu Guan <eguan@redhat.com>, linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@osandov.com>
References: <20180123172000.20919-1-eguan@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9b37df1b-6a3e-2d24-f1f3-de34d8c690d9@kernel.dk>
Date: Tue, 23 Jan 2018 14:32:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180123172000.20919-1-eguan@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/23/18 10:20 AM, Eryu Guan wrote:
> Attributes that only implement .seq_ops are read-only, any write to
> them should be rejected. But currently kernel would crash when
> writing to such debugfs entries, e.g.
> 
> chmod +w /sys/kernel/debug/block/<dev>/requeue_list
> echo 0 > /sys/kernel/debug/block/<dev>/requeue_list
> chmod -w /sys/kernel/debug/block/<dev>/requeue_list
> 
> Fix it by returning -EPERM in blk_mq_debugfs_write() when writing to
> such attributes.

I don't particularly like the fix, since it's not really clear why
that comparison makes sense. Can't we just prevent anyone from
making the debugfs entries writable? Seems like a much more sane
approach.

-- 
Jens Axboe
