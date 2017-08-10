Return-Path: <hch@lst.de>
Date: Thu, 10 Aug 2017 11:32:34 +0200
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
Subject: Re: [RFC PATCH 2/6] bsg: assign sense_len instead of fixed
	SCSI_SENSE_BUFFERSIZE
Message-ID: <20170810093234.GM24539@lst.de>
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com> <2dd8381929af2037a6eec3086256f54f55c01e78.1502120928.git.bblock@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2dd8381929af2037a6eec3086256f54f55c01e78.1502120928.git.bblock@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
