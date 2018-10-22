Return-Path: <hch@lst.de>
Date: Mon, 22 Oct 2018 11:14:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] skd: fix unchecked return values
Message-ID: <20181022091457.GA19279@lst.de>
References: <20181019184417.GA21154@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181019184417.GA21154@embeddedor.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 19, 2018 at 08:44:17PM +0200, Gustavo A. R. Silva wrote:
> Check return values of dma_set_mask_and_coherent().
> 
> Otherwise, if dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> fails, the following piece of code will be executed even when the call
> to dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)); returns 0:
> 
> dev_err(&pdev->dev, "DMA mask error %d\n", rc);
> goto err_out_regions;
> 
> Addresses-Coverity-ID: 1474553 ("Unchecked return value")
> Fixes: 138126214868 ("skd: switch to the generic DMA API")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
