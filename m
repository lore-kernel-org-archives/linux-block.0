Return-Path: <hch@lst.de>
Date: Thu, 5 Oct 2017 17:59:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	maxg@mellanox.com, Linuxarm <linuxarm@huawei.com>
Subject: Re: [Question] on blk_mq_map_queues()
Message-ID: <20171005155901.GA30575@lst.de>
References: <f5280c3c-ffd9-bc3a-7e0b-226c4a1232c9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f5280c3c-ffd9-bc3a-7e0b-226c4a1232c9@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 05, 2017 at 02:28:43PM +0100, John Garry wrote:
> I know that we can add our own per-driver mapping function to solve, but I 
> would expect that that generic mapper would cover a generic platform.

Why aren't you using blk_mq_pci_map_queues?

What kind of hardware are we talking about?
