Return-Path: <hch@lst.de>
Date: Thu, 5 Oct 2017 18:27:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	axboe@kernel.dk, maxg@mellanox.com, Linuxarm <linuxarm@huawei.com>
Subject: Re: [Question] on blk_mq_map_queues()
Message-ID: <20171005162758.GA31439@lst.de>
References: <f5280c3c-ffd9-bc3a-7e0b-226c4a1232c9@huawei.com> <20171005155901.GA30575@lst.de> <9f1e7e62-7d9d-199f-cb78-3dc4039b3042@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9f1e7e62-7d9d-199f-cb78-3dc4039b3042@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 05, 2017 at 05:06:54PM +0100, John Garry wrote:
> It's a HiSilicon hip07 (D05) platform. For this platform, the integrated 
> SAS controller is a platform device. This controller supports 16 hw queues.

That's v1 or v2 in drivers/scsi/hisi_sas?

Seems like you need to implement the equivalent of the 
pci_alloc_irq_vectors vector spreading for platform devices to get
your vectors properly assigned, and the have a blk_mq_of_map_queues
equivalent to blk_mq_pci_map_queues to map the queues based on the
interrupt assignment.
