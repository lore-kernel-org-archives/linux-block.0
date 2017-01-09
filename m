Return-Path: <BATV+346223d864736513bcc6+4887+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 9 Jan 2017 12:59:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Artemi Ivanov <artemi.ivanov@cogentembedded.com>
Subject: Re: blk_queue_bounce_limit() broken for mask=0xffffffff on 64bit
 archs
Message-ID: <20170109205959.GA1112@infradead.org>
References: <632ad7f3-e837-a17c-5ba7-ed9800ba3ec0@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <632ad7f3-e837-a17c-5ba7-ed9800ba3ec0@cogentembedded.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 09, 2017 at 11:48:11PM +0300, Nikita Yushchenko wrote:
> Hi
> 
> There is a use cases when architecture is 64-bit but hardware supports
> only DMA to lower 4G of address space. E.g. NVMe device on RCar PCIe host.

The solution is to shoot the SOC designer.  If that doesn't work use
swiotlb.
