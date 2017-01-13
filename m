Return-Path: <sagi@grimberg.me>
Subject: Re: [PATCH 3/6] nvme/pci: Start queues after tagset is updated
To: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-4-git-send-email-keith.busch@intel.com>
Cc: Marc Merlin <marc@merlins.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <54faf39b-d632-0664-034a-e3c89bbabe5b@grimberg.me>
Date: Fri, 13 Jan 2017 22:38:18 +0200
MIME-Version: 1.0
In-Reply-To: <1483569671-1462-4-git-send-email-keith.busch@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>


> We need to leave the block queues stopped if we're changing the tagset's
> number of queues.

Umm, Don't we need to fail these requests? What am I missing?
Won't these requests block until timeout expiration and will
trigger error recovery again?
