Return-Path: <hch@lst.de>
Date: Wed, 2 May 2018 14:45:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-xfs@vger.kernel.org, linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCHSET 0/2] sync discard
Message-ID: <20180502124508.GD22857@lst.de>
References: <1525102372-8430-1-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525102372-8430-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 30, 2018 at 09:32:50AM -0600, Jens Axboe wrote:
> We recently had a pretty severe perf regression with the XFS async
> discard. This small series add a SYNC issue discard flag, and also
> limits the chain size for sync discards. Patch 2 adds support for
> reverting XFS back to doign sync discards.

Please explain the hardware and workload that you see this with.
Also given that it is a hardware limitation a quirk limiting the
size of discard requests and/or number of outstanding discards
would be more useful than falling back to a broken mode of issueing
block commands.
