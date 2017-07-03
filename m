Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: NVMe induced NULL deref in bt_iter()
To: Ming Lei <ming.lei@redhat.com>
Cc: Max Gurtovoy <maxg@mellanox.com>, Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
 <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>
 <7138df5a-b1ce-7f46-281f-ae15172c61e5@grimberg.me>
 <20170703093951.GA28651@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bc6e2ecf-031b-45c0-8fbb-98c12c790ee4@grimberg.me>
Date: Mon, 3 Jul 2017 13:07:44 +0300
MIME-Version: 1.0
In-Reply-To: <20170703093951.GA28651@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Ming,

> Yeah, the above change is correct, for any canceling requests in this
> way we should use blk_mq_quiesce_queue().

I still don't understand why should blk_mq_flush_busy_ctxs hit a NULL
deref if we don't touch the tagset...

Also, I'm wandering in what case we shouldn't use
blk_mq_quiesce_queue()? Maybe we should unexport blk_mq_stop_hw_queues()
and blk_mq_start_stopped_hw_queues() and use the quiesce/unquiesce
equivalent always?

The only fishy usage is in nvme_fc_start_fcp_op() where if submission
failed the code stop the hw queues and delays it, but I think it should
be handled differently..
