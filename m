Subject: Re: [PATCH] remove the mg_disk driver
To: Christoph Hellwig <hch@lst.de>, donari75@gmail.com
References: <20170406112846.31078-1-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <9e8d1c35-22dc-7022-5b2b-1d81d1e4b0e0@fb.com>
Date: Fri, 14 Apr 2017 14:01:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170406112846.31078-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/06/2017 05:28 AM, Christoph Hellwig wrote:
> This drivers was added in 2008, but as far as a I can tell we never had a
> single platform that actually registered resources for the platform driver.
> 
> It's also been unmaintained for a long time and apparently has a ATA mode
> that can be driven using the IDE/libata subsystem.

Added for 4.12.

-- 
Jens Axboe
