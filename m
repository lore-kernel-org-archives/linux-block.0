Return-Path: <hch@lst.de>
Date: Mon, 19 Jun 2017 17:00:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>
Subject: Re: [PATCH 01/10] pktcdvd: remove the call to blk_queue_bounce
Message-ID: <20170619150022.GA10165@lst.de>
References: <20170619072628.12894-1-hch@lst.de> <20170619072628.12894-2-hch@lst.de> <CACVXFVMxgKk1kzL=rgAzdw8X5qgWn8Z_Hv-gUHSKfp1rXRArxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVMxgKk1kzL=rgAzdw8X5qgWn8Z_Hv-gUHSKfp1rXRArxA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 19, 2017 at 10:34:36PM +0800, Ming Lei wrote:
> blk_queue_make_request() sets bounce for any highmem page for long time,
> and in theory this patch might cause regression on 32bit arch, when
> the controller can't handle higmem page really(especially in case of PAE), so
> we may need to be careful about this change, especially on some old hardware.

Which controller?
