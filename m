Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blkcg: avoid free blkcg_root when failed to alloc blkcg
 policy
To: weiping zhang <zhangweiping@didichuxing.com>
References: <20170825154926.GA25023@localhost.didichuxing.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f41340cd-2ece-7ed0-0300-a216b01692c7@kernel.dk>
Date: Fri, 25 Aug 2017 13:50:53 -0600
MIME-Version: 1.0
In-Reply-To: <20170825154926.GA25023@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/25/2017 09:49 AM, weiping zhang wrote:
> this patch fix two errors, firstly avoid kfree blk_root, secondly not
> free(blkcg) ,if blkcg alloc fail(blkcg == NULL), just unlock that mutex;

Looks good, applied.

-- 
Jens Axboe
