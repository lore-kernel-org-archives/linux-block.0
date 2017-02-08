Return-Path: <axboe@kernel.dk>
Subject: Re: support for multi-range discard requests V3
To: Christoph Hellwig <hch@lst.de>
References: <20170208134650.5380-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <229a3478-e370-952a-ae80-ad02a429aacc@kernel.dk>
Date: Wed, 8 Feb 2017 10:45:48 -0700
MIME-Version: 1.0
In-Reply-To: <20170208134650.5380-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/08/2017 06:46 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds support for merging discontiguous discard bios into a
> single request if the driver supports it.  This reduces the number of
> discards sent to the device by about a factor of 5-6 for typical
> workloads on NVMe, and for slower devices that use I/O scheduling
> the number will probably be even bigger but I've not implemented
> that support yet.

This looks good to me. It's running testing now, but provided that
the tests are successful, we should get this queued up for 4.11.


-- 
Jens Axboe
