Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 1/6] nvme: move the dying queue check from cancel to
 completion
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171102182856.9162-1-hch@lst.de>
 <20171102182856.9162-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0c6187ca-b714-2f24-9f41-791103b9d8e5@grimberg.me>
Date: Sun, 5 Nov 2017 16:01:52 +0200
MIME-Version: 1.0
In-Reply-To: <20171102182856.9162-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
