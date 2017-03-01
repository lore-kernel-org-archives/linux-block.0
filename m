Return-Path: <prvs=42332f6725=axboe@fb.com>
Subject: Re: [PATCH 0/3] nvme suspend/resume fix
To: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <1488396132-11369-1-git-send-email-keith.busch@intel.com>
CC: Marc MERLIN <marc@merlins.org>, Jens Axboe <axboe@kernel.dk>
From: Jens Axboe <axboe@fb.com>
Message-ID: <2d236d6a-f8dd-c585-8f6a-edd0be6fa115@fb.com>
Date: Wed, 1 Mar 2017 16:29:09 -0700
MIME-Version: 1.0
In-Reply-To: <1488396132-11369-1-git-send-email-keith.busch@intel.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 03/01/2017 12:22 PM, Keith Busch wrote:
> Hi Jens,
> 
> This is hopefully the last version to fix nvme stopping blk-mq's CPU
> event from making forward progress. The solution requires a couple new
> blk-mq exports so the nvme driver can properly sync with queue states.
> 
> Since this depends on the blk-mq parts, and if you approve of the
> proposal, I think it'd be easiest if you can take this directly into
> linux-block/for-linus. Otherwise, we can send you a pull request if you
> Ack the blk-mq parts.
> 
> The difference from the previous patch is an update that Artur
> confirmed passes hibernate on a stacked request queue. Personally,
> I tested this for several hours with fio running buffered writes
> in the back-ground and rtcwake running suspend/resume at intervals.
> This succeeded with no fio errors.

I've queued it up for this series, thanks Keith.

-- 
Jens Axboe
