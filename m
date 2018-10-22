Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] skd: fix unchecked return values
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181019184417.GA21154@embeddedor.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bf4ab819-0116-e0cc-5186-441415609483@kernel.dk>
Date: Mon, 22 Oct 2018 03:16:53 -0600
MIME-Version: 1.0
In-Reply-To: <20181019184417.GA21154@embeddedor.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/19/18 12:44 PM, Gustavo A. R. Silva wrote:
> Check return values of dma_set_mask_and_coherent().
> 
> Otherwise, if dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> fails, the following piece of code will be executed even when the call
> to dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)); returns 0:
> 
> dev_err(&pdev->dev, "DMA mask error %d\n", rc);
> goto err_out_regions;

Applied, thanks.

-- 
Jens Axboe
