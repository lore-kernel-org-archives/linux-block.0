Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/1] bsg: fix regression resulting in panics when
 sending commands via BSG
To: Benjamin Block <bblock@linux.vnet.ibm.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
 Christoph Hellwig <hch@lst.de>, Steffen Maier <maier@linux.vnet.ibm.com>
References: <cover.1503528302.git.bblock@linux.vnet.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fd48c80b-1100-e993-6b45-32cdf62a2916@kernel.dk>
Date: Thu, 24 Aug 2017 08:22:45 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1503528302.git.bblock@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/23/2017 05:57 PM, Benjamin Block wrote:
> Hello all,
> 
> This is the second try for fixing the regression in the BSG-interface that
> exists since v4.11 (for more infos see the first series).
> 
> I separated my other changes from the bug-fix so that it is easier to apply
> if judged good. I will rebase my cleanups I sent in v1 and send them when I
> get a bit more time. But the regression-fix is more important, so here's
> that.
> 
> I did some more tests on it than on v1, including some heavy parallel I/O
> on the same blk-queue using both BSG and the normal SCSI-stack at the same
> time (throwing some intentional bad commands in it too). That seemed to
> work all well enough - i.e. it didn't crash and got the expected results. I
> haven't done any external error-inject, but IMO that would be beyond the
> scope right now.
> 
> The fix is based on Christoph's idea, I discussed this with him off-list
> already.
> 
> I rebased the series on Jens' for-next.

Added for 4.13, thanks.

-- 
Jens Axboe
