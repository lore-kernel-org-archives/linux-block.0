Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 7/7] nvme: create 'slaves' and 'holders' entries for hidden controllers
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171109174450.17142-1-hch@lst.de>
	<20171109174450.17142-8-hch@lst.de>
Date: Thu, 09 Nov 2017 15:34:39 -0500
In-Reply-To: <20171109174450.17142-8-hch@lst.de> (Christoph Hellwig's message
	of "Thu, 9 Nov 2017 18:44:50 +0100")
Message-ID: <yq1r2t7ur6o.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

> From: Hannes Reinecke <hare@suse.de>
>
> When creating nvme multipath devices we should populate the 'slaves'
> and 'holders' directorys properly to aid userspace topology detection.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
