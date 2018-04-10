Return-Path: <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: Hang with blk-mq map series (block/008)
Message-ID: <d4cafa94-919c-e83d-eb91-d10dc06fc515@kernel.dk>
Date: Tue, 10 Apr 2018 09:51:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming,

Ran the above blktests on the current tree, and we end up getting
a hang that we never recover from. There's on request perpetually
stuck:

root@dell:/sys/kernel/debug/block/nvme0n1/hctx2# cat busy 
000000005e2b09fe {.op=READ, .cmd_flags=, .rq_flags=DONTPREP|IO_STAT|STATS, .state=in_flight, .tag=313, .internal_tag=-1}

and no amount of manual running or kicking the queue will bring it
back to life. If I run it on 'master', it works fine.

Did you run blktests on your series?

-- 
Jens Axboe
