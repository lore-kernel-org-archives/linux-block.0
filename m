Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [PATCHv2 2/2] nvme: Complete all stuck requests
To: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
References: <1487896561-10454-1-git-send-email-keith.busch@intel.com>
 <1487896561-10454-2-git-send-email-keith.busch@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b66a614e-140e-86e9-56bf-d3eafb750aa5@grimberg.me>
Date: Mon, 27 Feb 2017 15:46:09 +0200
MIME-Version: 1.0
In-Reply-To: <1487896561-10454-2-git-send-email-keith.busch@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Marc MERLIN <marc@merlins.org>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>



On 24/02/17 02:36, Keith Busch wrote:
> If the block layer has entered requests and gets a CPU hot plug event
> prior to the resume event, it will wait for those requests to exit. If
> the nvme driver is shutting down, it will not start the queues back up,
> preventing forward progress.
>
> To fix that, this patch freezes the request queues when the driver intends
> to shut down the controller so that no new requests may enter.  After the
> controller has been disabled, the queues will be restarted to force all
> entered requests to end in failure so that blk-mq's hot cpu notifier may
> progress. To ensure the queue usage count is 0 on a shutdown, the driver
> waits for freeze to complete before completing the controller shutdown.

Keith, can you explain (again) for me why is the freeze_wait must happen
after the controller has been disabled, instead of starting the queues
and waiting right after freeze start?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
