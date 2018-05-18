Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq: make sure that correct hctx->dispatch_from is set
To: huhai <huhai@kylinos.cn>
Cc: "ming.lei" <ming.lei@redhat.com>,
 linux-block <linux-block@vger.kernel.org>
References: <tencent_47349987636D0D2B620828E0@qq.com>
 <6c265e65-d248-f6e0-1be4-e4223f1a4ed6@kernel.dk>
 <07c44734-2aeb-79b2-6404-893b575debd5@kernel.dk>
 <tencent_128A9294097C7C620337BAAF@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <11b5bc94-7d28-0e2f-5902-aea7208925dc@kernel.dk>
Date: Fri, 18 May 2018 08:50:29 -0600
MIME-Version: 1.0
In-Reply-To: <tencent_128A9294097C7C620337BAAF@qq.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/18/18 8:46 AM, huhai wrote:
> Yes, it is more readable

Final version:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.18/block&id=d416c92c5d6229b33f37f0f75e52194081ccbcc4

> Finally, thank you for reminding me. Next time I'll change gmail to submit patch.

Not sure gmail can ever really work. You should not top-post reply to
postings either. If you want to experiment with getting a mailer setup
and whether or not it does the right thing, feel free to send a patch
to my email privately, and I can let you know if the end result is
as it should be.

-- 
Jens Axboe
