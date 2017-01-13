Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 13 Jan 2017 15:17:20 -0700
To: Christoph Hellwig <hch@lst.de>
Cc: Dexuan Cui <decui@microsoft.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: fix data transfer size caculation for special payload requests
Message-ID: <20170113221720.GA16425@kernel.dk>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484306953-3194-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 13 2017, Christoph Hellwig wrote:
> Hi all,
> 
> the first two fixes fix a regression in 4.10-rc1 where the data transfer
> size for discard commands wasn't set properly, leading to hangs with
> Hyper-V VMs.  The use the new data transfer size helper added in patch 1
> more widely.

Added for this series, thanks.

-- 
Jens Axboe
