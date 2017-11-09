Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 5/7] nvme: also expose the namespace identification sysfs files for mpath nodes
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171109174450.17142-1-hch@lst.de>
	<20171109174450.17142-6-hch@lst.de>
Date: Thu, 09 Nov 2017 15:33:10 -0500
In-Reply-To: <20171109174450.17142-6-hch@lst.de> (Christoph Hellwig's message
	of "Thu, 9 Nov 2017 18:44:48 +0100")
Message-ID: <yq1zi7vur95.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

> We do this by adding a helper that returns the ns_head for a device
> that can belong to either the per-controller or per-subsystem block
> device nodes, and otherwise reuse all the existing code.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
