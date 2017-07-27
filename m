Return-Path: <BATV+f91223e0de2c9036fbc6+5086+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 27 Jul 2017 06:26:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shaohua Li <shli@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>,
	Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [BUG] nvme driver crash
Message-ID: <20170727132646.GA30362@infradead.org>
References: <20170725222408.fq2fncwtid3fhvqh@kernel.org>
 <20170726173443.GA25527@infradead.org>
 <20170726191221.GA22421@vader.DHCP.thefacebook.com>
 <20170726222952.pn74rllluhq6cflm@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170726222952.pn74rllluhq6cflm@kernel.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 26, 2017 at 03:29:52PM -0700, Shaohua Li wrote:
> irq_create_affinity_masks returns null and prints error, could we fix that?

I've already sent a fix for that to the PCI list yesterday.
