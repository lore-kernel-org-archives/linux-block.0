Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/7] nvme: introduce a nvme_ns_ids structure
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171109174450.17142-1-hch@lst.de>
	<20171109174450.17142-3-hch@lst.de>
Date: Thu, 09 Nov 2017 15:25:14 -0500
In-Reply-To: <20171109174450.17142-3-hch@lst.de> (Christoph Hellwig's message
	of "Thu, 9 Nov 2017 18:44:45 +0100")
Message-ID: <yq1d14rw66t.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

> This allows us to manage the various uniqueue namespace identifiers
> together instead needing various variables and arguments.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
