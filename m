Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 1/8] nvme-rdma: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-2-git-send-email-sagi@grimberg.me>
 <20170704081541.GC29053@ming.t460p>
 <43b6e445-d83e-dda0-51a5-a680a2b2623d@grimberg.me>
 <048027e5-3be9-def3-3c41-f84f640c8022@grimberg.me>
 <20170704124151.GA1798@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f3555b6f-58ed-9ba8-f1d4-66145be5b213@grimberg.me>
Date: Tue, 4 Jul 2017 18:35:17 +0300
MIME-Version: 1.0
In-Reply-To: <20170704124151.GA1798@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Then the kick can be removed from nvme_start_queues()
> 
>> requeue kick and in nvme_complete_rq call:
>>
>> blk_mq_requeue_request(req, !blk_queue_quiesced(req->q));
>>
>> Thoughts?
> 
> I think we can always to kick the requeue work even when queue
> is stopped. It is OK to put the requeue req into sw queue/scheduler
> queue when queue is stopped.
> 

Agreed.
