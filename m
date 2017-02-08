Return-Path: <hch@lst.de>
Date: Wed, 8 Feb 2017 14:36:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Kuzmin <andrey.v.kuzmin@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: support ranged discard requests
Message-ID: <20170208133632.GA13064@lst.de>
References: <20170208131343.4003-1-hch@lst.de> <20170208131343.4003-5-hch@lst.de> <CANvN+ekrmaCZaYt02wX1DRz4+hTLicjyP-tYDTTcKsWe2Lo5MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANvN+ekrmaCZaYt02wX1DRz4+hTLicjyP-tYDTTcKsWe2Lo5MQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 08, 2017 at 01:32:22PM +0000, Andrey Kuzmin wrote:
> On Wed, Feb 8, 2017, 16:14 Christoph Hellwig <hch@lst.de> wrote:
> 
> > NVMe supports up to 255 ranges per DSM command,
> 
> 
> 256 per spec, with number of ranges being zero-based.

You're right.  I'll do another round of the patch.  That beeing
said in my tests I never even managed to get three-digit ranges
anyway with any workload.
