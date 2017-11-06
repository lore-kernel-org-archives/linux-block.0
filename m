Return-Path: <keith.busch@intel.com>
Date: Mon, 6 Nov 2017 07:46:48 -0700
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/6] nvme: always unregister the integrity profile in
 __nvme_revalidate_disk
Message-ID: <20171106144647.GC11677@localhost.localdomain>
References: <20171102182856.9162-1-hch@lst.de>
 <20171102182856.9162-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171102182856.9162-3-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
