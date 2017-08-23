Return-Path: <hch@lst.de>
Date: Wed, 23 Aug 2017 20:06:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 5/5] skd: Change default interrupt mode to MSI-X
Message-ID: <20170823180601.GE5802@lst.de>
References: <20170823175633.12680-1-bart.vanassche@wdc.com> <20170823175633.12680-6-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823175633.12680-6-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 23, 2017 at 10:56:33AM -0700, Bart Van Assche wrote:
> Since MSI support on some motherboards is unreliable, change the
> default interrupt mode from MSI to MSI-X. This patch avoids that
> the following message appears sporadially in the kernel logs of
> my test setup:

It might be worth noting that the driver still supports MSI
and INTX interrupts in this mode, which makes it match what most
other drivers do.

Signed-off-by: Christoph Hellwig <hch@lst.de>
