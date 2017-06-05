Return-Path: <hch@lst.de>
Date: Mon, 5 Jun 2017 10:20:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme: fix hang in remove path
Message-ID: <20170605082055.GA22375@lst.de>
References: <20170602083208.4518-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170602083208.4518-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Thanks Ming, I'll add this to the nvme tree for 4.12-rc.
