Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: NVMe induced NULL deref in bt_iter()
To: Ming Lei <ming.lei@redhat.com>, Max Gurtovoy <maxg@mellanox.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
 <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>
 <7138df5a-b1ce-7f46-281f-ae15172c61e5@grimberg.me>
 <20170703093951.GA28651@ming.t460p>
 <bc6e2ecf-031b-45c0-8fbb-98c12c790ee4@grimberg.me>
 <20170703120348.GB28651@ming.t460p>
 <c381e5ab-51b6-494f-db62-09cd4bfdfe39@mellanox.com>
 <20170703155443.GC28651@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4a871598-a948-9149-4879-347240368c72@grimberg.me>
Date: Tue, 4 Jul 2017 09:58:58 +0300
MIME-Version: 1.0
In-Reply-To: <20170703155443.GC28651@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> So looks it is still a normal release in initiator.
> 
> Per my experience, without quiescing queue before
> blk_mq_tagset_busy_iter() for canceling requests, request double free
> can be caused: one submitted req in .queue_rq can completed in
> blk_mq_end_request(), meantime it can be completed in
> nvme_cancel_request(). That is why we have to quiescing queue
> first before canceling request in this way. Except for NVMe, looks
> NBD and mtip32xx need fix too.

Let me cook some patches for those as well...
