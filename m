Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 1/3] nvme/pci: Start request after doorbell ring
To: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8c7c2b8a-7e26-c1a1-4681-8c7721184d39@grimberg.me>
Date: Mon, 25 Dec 2017 12:11:47 +0200
MIME-Version: 1.0
In-Reply-To: <20171221204636.2924-2-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> This is a performance optimization that allows the hardware to work on
> a command in parallel with the kernel's stats and timeout tracking.

Curious to know what does this buy us?
