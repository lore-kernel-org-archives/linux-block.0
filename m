Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH v2 1/8] nvme-rdma: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>
References: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
 <1499237591-15861-2-git-send-email-sagi@grimberg.me>
 <20170705071257.GA11084@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c349a9f0-d4cb-e19a-acc9-2b7157f6ec21@grimberg.me>
Date: Wed, 5 Jul 2017 10:15:28 +0300
MIME-Version: 1.0
In-Reply-To: <20170705071257.GA11084@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> As I commented yesterday, blk_mq_kick_requeue_list() isn't needed.

I commented in the cover-letter, I am removing it a two steps to keep
bisection. I'm only allowed to remove it in patch 5/8.
