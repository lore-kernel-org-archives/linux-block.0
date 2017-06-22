Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: remove double set queue_num
To: Erics Di <zwp10758@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
References: <CAA70yB4PT=uPio1owQ7AaBnZABid92ywRUcX7kzEqiTGGJJeMw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <05ed445c-b9a1-7bc8-511b-d915fb0e6d17@kernel.dk>
Date: Thu, 22 Jun 2017 08:10:38 -0600
MIME-Version: 1.0
In-Reply-To: <CAA70yB4PT=uPio1owQ7AaBnZABid92ywRUcX7kzEqiTGGJJeMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/22/2017 03:29 AM, Erics Di wrote:
> hwctx's queue_num has been set prior call blk_mq_init_hctx, so no need
> 
> set it again.

You are right, that is a duplicate setting. But your patch is odd
in various ways:

1) Your signed-off-by and sender email (and name) have nothing to do
   with each other.

2) The patch is severely mangled. How are you sending it?

#2 I can manually fix up, but I can't fix up #1.

-- 
Jens Axboe
