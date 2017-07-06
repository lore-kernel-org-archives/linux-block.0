Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/1] null_blk: fix error flow for shared tags during
 module_init
To: Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org
References: <1499353207-32376-1-git-send-email-maxg@mellanox.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <572ed2ea-c6b6-b5c6-e32e-803d9a78adf7@kernel.dk>
Date: Thu, 6 Jul 2017 09:52:17 -0600
MIME-Version: 1.0
In-Reply-To: <1499353207-32376-1-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/06/2017 09:00 AM, Max Gurtovoy wrote:
> In case we use shared tags feature, blk_mq_alloc_tag_set might fail
> during module initialization. In that case, fail the load with the
> suitble error code. Also move the tagset initialization process after
> defining the amount of submition queues.

I've fixed some of the typos in your commit message, but this looks
good. Applied, thanks.

-- 
Jens Axboe
