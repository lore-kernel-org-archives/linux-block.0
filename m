Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/4] blk: add blk_queue_fua() helper function
To: Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, hch@lst.de,
 rdorr@microsoft.com
References: <20180418040828.18165-1-david@fromorbit.com>
 <20180418040828.18165-4-david@fromorbit.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7f399e07-b0e6-4f6e-9d3c-2eeac3d070ec@kernel.dk>
Date: Wed, 18 Apr 2018 08:23:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180418040828.18165-4-david@fromorbit.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/17/18 10:08 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> So we can check FUA support status from the iomap direct IO code.

Applied, thanks.

-- 
Jens Axboe
