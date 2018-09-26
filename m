Return-Path: <axboe@kernel.dk>
Subject: Re: clean up physical merging helpers
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-block@vger.kernel.org,
 xen-devel@lists.xen.org, linux-arm-kernel@lists.infradead.org
References: <20180925203009.1838-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <46a3e4e8-1b4f-1cd7-78a0-c515a2e8e63e@kernel.dk>
Date: Wed, 26 Sep 2018 08:45:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180925203009.1838-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/25/18 2:30 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves Xen special handling of block merges from arch hooks
> into common code.  A previous version has been reviewed by Boris.

Applied, thanks.

-- 
Jens Axboe
