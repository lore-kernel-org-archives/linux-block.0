Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 10 Jan 2018 10:35:23 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, osandov@fb.com, bart.vanassche@wdc.com
Subject: Re: [PATCH 1/4] block: remove REQ_ATOM_POLL_SLEPT
Message-ID: <20180110183523.GA30831@vader.DHCP.thefacebook.com>
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
 <1515544167-10751-2-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515544167-10751-2-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 09, 2018 at 05:29:24PM -0700, Jens Axboe wrote:
> We don't need this to be an atomic flag, it can be a regular
> flag. We either end up on the same CPU for the polling, in which
> case the state is sane, or we did the sleep which would imply
> the needed barrier to ensure we see the right state.

Second Bart's comment, looks good otherwise.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
