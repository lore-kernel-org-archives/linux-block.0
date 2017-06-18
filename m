Return-Path: <axboe@kernel.dk>
Date: Sun, 18 Jun 2017 12:41:45 -0600
From: Jens Axboe <axboe@kernel.dk>
To: NeilBrown <neilb@suse.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] block: assorted cleanup for bio splitting and
 cloning.
Message-ID: <20170618184143.GA10920@kernel.dk>
References: <149776047907.23258.8058071140236879834.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149776047907.23258.8058071140236879834.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jun 18 2017, NeilBrown wrote:
> This is a resend of my series of patches working
> towards removing the bioset work queues.
> 
> This set is based on for-4.13/block.
> 
> It incorporates the revised versions of all the patches that were
> resent following feedback on the last set.
> 
> It also includes a minor grammatic improvement to a comment, and
> simple changes to compensate for a couple of changes to the block tree
> since the last posting.
> 
> I hope to eventually get rid of the new BIOSET_NEED_RESCUER flag,
> but that needs work in dm and probably bcache first.

Thanks Neil, applied.

-- 
Jens Axboe
