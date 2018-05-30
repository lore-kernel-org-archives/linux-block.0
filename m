Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 04/12] nvmet: add a new nvmet_zero_sgl helper
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5f65f72b-682d-e08b-6bbb-4863b868313c@grimberg.me>
Date: Thu, 31 May 2018 00:24:21 +0300
MIME-Version: 1.0
In-Reply-To: <20180530164600.26856-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> +u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)

Would personally prefer nvmet_clear_sgl, but not hard headed on it,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
