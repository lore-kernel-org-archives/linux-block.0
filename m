Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: copy ioprio in __bio_clone_fast()
To: Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20180801143809.5472-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ba485213-abb5-1f7b-c2c2-3b6379b82cbe@kernel.dk>
Date: Wed, 1 Aug 2018 09:17:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180801143809.5472-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/1/18 8:38 AM, Hannes Reinecke wrote:
> We need to copy the io priority, too; otherwise the clone will run
> with a different priority than the original one.

Looks good, but please make the patch against the block 4.19 branch.

-- 
Jens Axboe
