Return-Path: <hch@lst.de>
Date: Thu, 10 Aug 2017 11:32:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Block <bblock@linux.vnet.ibm.com>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Steffen Maier <maier@linux.vnet.ibm.com>,
	open-iscsi@googlegroups.com
Subject: Re: [RFC PATCH 1/6] bsg: fix kernel panic resulting from missing
	allocation of a reply-buffer
Message-ID: <20170810093217.GL24539@lst.de>
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com> <9e67ce3fc2f3cd42e9e05b2753b00d6676f46ee1.1502120928.git.bblock@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e67ce3fc2f3cd42e9e05b2753b00d6676f46ee1.1502120928.git.bblock@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

We can't use an on-stack buffer for the sense data, as drivers will
dma to it.  So we should reuse the SCSI init_rq_fn() for the BSG
queues and/or implement the same scheme.
