Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 8/8] xen-blockfront: quiesce IO before device removal
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-9-git-send-email-sagi@grimberg.me>
 <20170704221908.GA3732@ming.t460p>
 <77cea68f-7915-2bbf-0861-05d1ca389e6c@grimberg.me>
 <20170705225632.GB11849@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b4e867bf-65ba-d92c-1130-0fb8143b383d@grimberg.me>
Date: Thu, 6 Jul 2017 09:52:38 +0300
MIME-Version: 1.0
In-Reply-To: <20170705225632.GB11849@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>> Looks the above change isn't needed since this blk_mq_start_stopped_hw_queues()
>>> should have been the counterpart of blk_mq_stop_hw_queue() in
>>> blkif_queue_rq().
>>
>> Removed the patch altogether in v2 as I'm not convinced it is needed.
> 
> I've only started reading the series, but to me it seems like the
> two places where xen-blkfront currently calls blk_mq_stop_hw_queues
> should probably converted, as they are the same category as the other
> calls converted in your series.

I'm not familiar enough with the code, I can restore a correct version
of it if it makes sense to you guys...
