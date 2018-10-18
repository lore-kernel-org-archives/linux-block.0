Return-Path: <axboe@kernel.dk>
Subject: Re: convert drivers/block to the generic DMA API
To: Christoph Hellwig <hch@lst.de>
Cc: Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.vnet.ibm.com>, linux-block@vger.kernel.org
References: <20181018131516.10629-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <804f6dea-e5b7-0caf-e634-a2c6b9b3d53e@kernel.dk>
Date: Thu, 18 Oct 2018 15:15:11 -0600
MIME-Version: 1.0
In-Reply-To: <20181018131516.10629-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/18/18 7:15 AM, Christoph Hellwig wrote:
> Switch all remaining users of the legacy PCI DMA API to the
> generic DMA API.

Applied, thanks.

-- 
Jens Axboe
