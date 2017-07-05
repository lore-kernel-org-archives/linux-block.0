Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Wed, 5 Jul 2017 14:08:28 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	James Smart <james.smart@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>, Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH v3 6/8] nbd: quiesce request queues to make sure no
 submissions are inflight
Message-ID: <20170705180827.GA18539@destiny>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
 <1499274037-17438-7-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499274037-17438-7-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 05, 2017 at 08:00:35PM +0300, Sagi Grimberg wrote:
> Unlike blk_mq_stop_hw_queues, blk_mq_quiesce_queue respects the
> submission path rcu grace. quiesce the queue before iterating
> on live tags.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Cc: Josef Bacik <jbacik@fb.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Sounds fine by me, you can add

Acked-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
