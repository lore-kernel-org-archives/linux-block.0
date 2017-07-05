Return-Path: <ming.lei@redhat.com>
Date: Wed, 5 Jul 2017 15:34:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v2 1/8] nvme-rdma: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
Message-ID: <20170705073423.GG11084@ming.t460p>
References: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
 <1499237591-15861-2-git-send-email-sagi@grimberg.me>
 <20170705071257.GA11084@ming.t460p>
 <c349a9f0-d4cb-e19a-acc9-2b7157f6ec21@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c349a9f0-d4cb-e19a-acc9-2b7157f6ec21@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 05, 2017 at 10:15:28AM +0300, Sagi Grimberg wrote:
> 
> > As I commented yesterday, blk_mq_kick_requeue_list() isn't needed.
> 
> I commented in the cover-letter, I am removing it a two steps to keep
> bisection. I'm only allowed to remove it in patch 5/8.

The kick requeue list shouldn't be added at the 1st step.

The thing is simple, we only need to kick request list where the queue
is restarted. Now quiesce and unquiesce do not touch STOP state, so
it may make people confused if you add the kick after unquiese.

-- 
Ming
