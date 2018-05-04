Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3 7/8] nvme: pci: recover controller reliably
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
References: <20180503031716.31446-1-ming.lei@redhat.com>
 <20180503031716.31446-8-ming.lei@redhat.com>
 <32819b0a-acc8-fa76-5e58-8e75e2bc081b@oracle.com>
 <20180503100824.GA5078@ming.t460p>
 <ea98b607-9c8f-3b18-8314-cdcfd8bc5e96@oracle.com>
 <20180504042451.GA20791@ming.t460p>
 <2e6e88f9-089a-2809-0c2b-4e96ba1199e9@oracle.com>
 <20180504080223.GB20791@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b7c597c0-7c0e-4a16-8f7c-ff3a6d6d17a6@oracle.com>
Date: Fri, 4 May 2018 16:28:23 +0800
MIME-Version: 1.0
In-Reply-To: <20180504080223.GB20791@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi ming

On 05/04/2018 04:02 PM, Ming Lei wrote:
>> nvme_error_handler should invoke nvme_reset_ctrl instead of introducing another interface.
>> Then it is more convenient to ensure that there will be only one resetting instance running.
>>
> But as you mentioned above, reset_work has to be splitted into two
> contexts for handling IO timeout during wait_freeze in reset_work,
> so single instance of nvme_reset_ctrl() may not work well.

I mean the EH kthread and the reset_work which both could reset the ctrl instead of
the pre and post rest context.

Honestly, I suspect a bit that whether it is worthy to try to recover from [1].
The Eh kthread solution could make things easier, but the codes for recovery from [1] has
made code really complicated. It is more difficult to unify the nvme-pci, rdma and fc. 

How about just fail the resetting as the Keith's solution ?

[1] io timeout when nvme_reset_work or the new nvme_post_reset_dev invoke nvme_wait_freeze.

Thanks
Jianchao
