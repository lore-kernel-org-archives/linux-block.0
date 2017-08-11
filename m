Return-Path: <hch@lst.de>
Date: Fri, 11 Aug 2017 10:38:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Block <bblock@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Steffen Maier <maier@linux.vnet.ibm.com>,
	open-iscsi@googlegroups.com
Subject: Re: [RFC PATCH 1/6] bsg: fix kernel panic resulting from missing
	allocation of a reply-buffer
Message-ID: <20170811083808.GA5497@lst.de>
References: <cover.1502120928.git.bblock@linux.vnet.ibm.com> <9e67ce3fc2f3cd42e9e05b2753b00d6676f46ee1.1502120928.git.bblock@linux.vnet.ibm.com> <20170810093217.GL24539@lst.de> <20170810221038.GA918@bblock-ThinkPad-W530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170810221038.GA918@bblock-ThinkPad-W530>
List-ID: <linux-block@vger.kernel.org>

My point was that we now gurantee that that the sense data is not
a stack pointer an a driver can DMA to it.  Now for BSG the sense
data is "just" abused as reply, but the point still stands - we
don't want to pass a possible stack pointer to drivers in a data
buffer because we want to allow DMA to it.

That being said with your patch 4 that becomes a moot point as we'll
now always dynamically allocate it.  So maybe just reorder that to go
first and we should be fine.
