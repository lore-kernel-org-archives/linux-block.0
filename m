Return-Path: <hch@lst.de>
Date: Tue, 25 Sep 2018 22:29:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-block@vger.kernel.org, xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org,
	Ming Lei <ming.lei@redhat.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [Xen-devel] clean up physical merging helpers
Message-ID: <20180925202929.GA9705@lst.de>
References: <20180904191431.20102-1-hch@lst.de> <20180915070300.GA10555@lst.de> <b8f3621a-f789-d737-649f-7b3645912888@kernel.dk> <20180920062946.GA12893@lst.de> <6e7fa8d3-4839-726d-572c-1678f5450880@kernel.dk> <5fc63f64-4e81-0e10-bc3e-bde6f279c973@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5fc63f64-4e81-0e10-bc3e-bde6f279c973@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 24, 2018 at 10:25:45AM -0400, Boris Ostrovsky wrote:
> Konrad is out this (and last) week, this looks good to me. Including
> patch 13, although it's hard to say whether it may break some builds.

I fixed up everything the buildbot reported (which was quite a bit
as you can see in the patch), and the buildbot has been quiet for
weeks now, so I think we should be fine.
