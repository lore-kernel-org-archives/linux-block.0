Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
To: Keith Busch <keith.busch@intel.com>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Linux Block <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Jianchao Wang <jianchao.w.wang@oracle.com>, Ming Lei <ming.lei@redhat.com>,
 Don Brace <don.brace@microsemi.com>, qla2xxx-upstream@qlogic.com,
 linux-scsi@vger.kernel.org
References: <20180327153908.3732-1-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <973b51a9-d340-3c9e-bec0-12db96002d9b@kernel.dk>
Date: Tue, 27 Mar 2018 21:24:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180327153908.3732-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/27/18 9:39 AM, Keith Busch wrote:
> The PCI interrupt vectors intended to be associated with a queue may
> not start at 0; a driver may allocate pre_vectors for special use. This
> patch adds an offset parameter so blk-mq may find the intended affinity
> mask and updates all drivers using this API accordingly.

Looks good to me, I'll queue it up for 4.17.

-- 
Jens Axboe
