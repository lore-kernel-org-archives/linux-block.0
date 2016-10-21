Return-Path: <hch@lst.de>
Date: Fri, 21 Oct 2016 15:38:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] softirq: Display IRQ_POLL for irq-poll statistics
Message-ID: <20161021133823.GA19067@lst.de>
References: <1476101451-722-1-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476101451-722-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 10, 2016 at 03:10:51PM +0300, Sagi Grimberg wrote:
> This library was moved to the generic area and was
> renamed to irq-poll. Hence, update proc/softirqs output accordingly.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
