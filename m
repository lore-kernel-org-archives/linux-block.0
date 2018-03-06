Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] block: null_blk: fix 'Invalid parameters' when loading
 module
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Bart Van Assche <Bart.VanAssche@wdc.com>,
 Shaohua Li <shli@kernel.org>, Kyungchan Koh <kkc6196@fb.com>,
 weiping zhang <zhangweiping@didichuxing.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20180306040713.32493-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7902ab27-c8eb-4f2e-32f0-ef02d4ea4ef5@kernel.dk>
Date: Tue, 6 Mar 2018 10:35:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180306040713.32493-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/5/18 9:07 PM, Ming Lei wrote:
> On ARM64, the default page size has been 64K on some distributions, and
> we should allow ARM64 people to play null_blk.
> 
> This patch fixes the issue by extend page bitmap size for supporting
> other non-4KB PAGE_SIZE.

Applied, thanks.

-- 
Jens Axboe
