Return-Path: <axboe@kernel.dk>
Date: Mon, 16 Oct 2017 09:08:03 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Michael Lyle <mlyle@lyle.org>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 00/15] bcache: series of patches for 4.15
Message-ID: <20171016150802.GA27385@kernel.dk>
References: <20171013233542.20938-1-mlyle@lyle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171013233542.20938-1-mlyle@lyle.org>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 13 2017, Michael Lyle wrote:
> Jens, and everyone:
> 
> Here is the current series of work for inclusion in next and for 4.15's
> merge window.  We may get some additional fixes, but this is most of the
> work we expect.  All have been previously sent to these lists except the
> very last one.
> 
> There's a lot of small cleanup patches and fixes for race conditions.
> 
> Also included is my new rate controller which we've been measuring for
> some time, and other related changes to writeback rate management.

Applied for 4.15, thanks.

-- 
Jens Axboe
