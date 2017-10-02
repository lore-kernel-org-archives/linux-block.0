Return-Path: <hch@lst.de>
Date: Mon, 2 Oct 2017 18:31:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Block <bblock@linux.vnet.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Steffen Maier <maier@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] bsg-lib: fix use-after-free under
	memory-pressure
Message-ID: <20171002163120.GA11691@lst.de>
References: <f7479308094ff44164f0a5fea83689ad7ef50db1.1506874870.git.bblock@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f7479308094ff44164f0a5fea83689ad7ef50db1.1506874870.git.bblock@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
