Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 07/15] bcache: Populate writeback_rate_minimum attribute
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
 Ben Peddell <klightspeed@killerwolves.net>
References: <20181008124121.20192-1-colyli@suse.de>
 <20181008124121.20192-8-colyli@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7ff3b94a-d9cb-ccc2-0ca5-4bd59f7ec1b1@kernel.dk>
Date: Mon, 8 Oct 2018 08:19:11 -0600
MIME-Version: 1.0
In-Reply-To: <20181008124121.20192-8-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/8/18 6:41 AM, Coly Li wrote:
> From: Ben Peddell <klightspeed@killerwolves.net>
> 
> Forgot to include the maintainers with my first email.
> 
> Somewhere between Michael Lyle's original
> "bcache: PI controller for writeback rate V2" patch dated 07 Sep 2017
> and 1d316e6 bcache: implement PI controller for writeback rate,
> the mapping of the writeback_rate_minimum attribute was dropped.
> 
> Re-add the missing sysfs writeback_rate_minimum attribute mapping to
> "allow the user to specify a minimum rate at which dirty blocks are
> retired."
> 
> Fixes: 1d316e6 bcache: implement PI controller for writeback rate

Remember to use the correct format for the Fixes line.

-- 
Jens Axboe
