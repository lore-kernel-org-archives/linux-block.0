Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: change the default nbd partitions
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <1502736976-15966-1-git-send-email-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <625f826f-8cf1-a1a1-3780-b75b3c473db3@kernel.dk>
Date: Thu, 17 Aug 2017 11:03:40 -0600
MIME-Version: 1.0
In-Reply-To: <1502736976-15966-1-git-send-email-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/14/2017 12:56 PM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> There's no reason to have partitions disabled for nbd by default, it costs us
> nothing to have it enabled and is just confusing/obnoxious to users who try to
> use partitions with nbd.

Added for 4.14, thanks.

-- 
Jens Axboe
