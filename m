Return-Path: <hch@lst.de>
Date: Thu, 10 Aug 2017 11:35:45 +0200
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
Subject: Re: [RFC PATCH 6/6] bsg: reduce unnecessary arguments for
	blk_complete_sgv4_hdr_rq()
Message-ID: <20170810093545.GQ24539@lst.de>
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com> <d95177abfa703a4f77a3d8ddb218eaead465f5ec.1502120928.git.bblock@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d95177abfa703a4f77a3d8ddb218eaead465f5ec.1502120928.git.bblock@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
