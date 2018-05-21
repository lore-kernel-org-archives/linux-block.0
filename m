Return-Path: <keith.busch@linux.intel.com>
Date: Mon, 21 May 2018 10:25:17 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] nvme: Sync request queues on reset
Message-ID: <20180521162517.GN5528@localhost.localdomain>
References: <20180518163823.27820-1-keith.busch@intel.com>
 <20180518223210.GB18334@ming.t460p>
 <20180518234408.GA31749@localhost.localdomain>
 <20180519000141.GB19799@ming.t460p>
 <20180521140413.GA5528@localhost.localdomain>
 <20180521152536.GB19099@ming.t460p>
 <20180521155909.GK5528@localhost.localdomain>
 <20180521160830.GA19858@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521160830.GA19858@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 12:08:37AM +0800, Ming Lei wrote:
> Please take a look at blk_mq_complete_request(). Even with Bart's
> change, the request still won't be completed by driver. The request can
> only be completed by either driver or blk-mq, not both.

So you're saying blk-mq can't complete a request the driver returned to
blk-mq to complete. And that's the nvme driver's problem to fix?
