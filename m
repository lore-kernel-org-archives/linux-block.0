Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Mon, 27 Feb 2017 10:01:08 -0500
From: Keith Busch <keith.busch@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv2 2/2] nvme: Complete all stuck requests
Message-ID: <20170227150107.GA5789@localhost.localdomain>
References: <1487896561-10454-1-git-send-email-keith.busch@intel.com>
 <1487896561-10454-2-git-send-email-keith.busch@intel.com>
 <b66a614e-140e-86e9-56bf-d3eafb750aa5@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <b66a614e-140e-86e9-56bf-d3eafb750aa5@grimberg.me>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Marc MERLIN <marc@merlins.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 27, 2017 at 03:46:09PM +0200, Sagi Grimberg wrote:
> On 24/02/17 02:36, Keith Busch wrote:
> > If the block layer has entered requests and gets a CPU hot plug event
> > prior to the resume event, it will wait for those requests to exit. If
> > the nvme driver is shutting down, it will not start the queues back up,
> > preventing forward progress.
> > 
> > To fix that, this patch freezes the request queues when the driver intends
> > to shut down the controller so that no new requests may enter.  After the
> > controller has been disabled, the queues will be restarted to force all
> > entered requests to end in failure so that blk-mq's hot cpu notifier may
> > progress. To ensure the queue usage count is 0 on a shutdown, the driver
> > waits for freeze to complete before completing the controller shutdown.
> 
> Keith, can you explain (again) for me why is the freeze_wait must happen
> after the controller has been disabled, instead of starting the queues
> and waiting right after freeze start?

Yeah, the driver needs to make forward progress even if the controller
isn't functioning. If we do the freeze wait before disabling the
controller, there's no way to reclaim missing completions. If the
controller is working perfectly, it'd be okay, but the driver would be
stuck if there's a problem.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
