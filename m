Return-Path: <hch@lst.de>
Date: Sat, 15 Sep 2018 09:03:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-block@vger.kernel.org, xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: clean up physical merging helpers
Message-ID: <20180915070300.GA10555@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Jens, any comments?

On Tue, Sep 04, 2018 at 12:14:18PM -0700, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves various helpers related to merging based on physical
> addresses from the public headers into block/, moves the Xen special
> case from arch hooks into common code, cleans up the code a bit, and
> removes not nessecary includes from the block headers.
---end quoted text---
