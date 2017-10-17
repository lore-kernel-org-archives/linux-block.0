Return-Path: <BATV+60eda6e2277543397899+5168+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 16 Oct 2017 23:50:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Move tagset reinit to its only current consumer,
 nvme-core
Message-ID: <20171017065055.GA4164@infradead.org>
References: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
 <20171016124817.GB26833@infradead.org>
 <718a34b5-b28e-fc4f-5b42-f961dde53482@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <718a34b5-b28e-fc4f-5b42-f961dde53482@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 16, 2017 at 08:47:38AM -0600, Jens Axboe wrote:
> On 10/16/2017 06:48 AM, Christoph Hellwig wrote:
> > Jens, are you fine with picking this up throught the nvme tree?
> > I think Sagi's later changes rely on it, so that would make life
> > a littler easier.
> 
> Yeah that's fine, you can add my reviewed-by to the patches
> as well.

Ok, applied to nvme-4.15 with your ACK.
