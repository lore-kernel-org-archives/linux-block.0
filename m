Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <b7c597c0-7c0e-4a16-8f7c-ff3a6d6d17a6@oracle.com>
References: <20180503031716.31446-1-ming.lei@redhat.com> <20180503031716.31446-8-ming.lei@redhat.com>
 <32819b0a-acc8-fa76-5e58-8e75e2bc081b@oracle.com> <20180503100824.GA5078@ming.t460p>
 <ea98b607-9c8f-3b18-8314-cdcfd8bc5e96@oracle.com> <20180504042451.GA20791@ming.t460p>
 <2e6e88f9-089a-2809-0c2b-4e96ba1199e9@oracle.com> <20180504080223.GB20791@ming.t460p>
 <b7c597c0-7c0e-4a16-8f7c-ff3a6d6d17a6@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 5 May 2018 08:16:37 +0800
Message-ID: <CACVXFVMVkfu-Lu2PKStmryWZYqekWQu8=5JT=iQrecPEYpRo5w@mail.gmail.com>
Subject: Re: [PATCH V3 7/8] nvme: pci: recover controller reliably
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>,
	linux-block <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, May 4, 2018 at 4:28 PM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
> Hi ming
>
> On 05/04/2018 04:02 PM, Ming Lei wrote:
>>> nvme_error_handler should invoke nvme_reset_ctrl instead of introducing another interface.
>>> Then it is more convenient to ensure that there will be only one resetting instance running.
>>>
>> But as you mentioned above, reset_work has to be splitted into two
>> contexts for handling IO timeout during wait_freeze in reset_work,
>> so single instance of nvme_reset_ctrl() may not work well.
>
> I mean the EH kthread and the reset_work which both could reset the ctrl instead of
> the pre and post rest context.
>
> Honestly, I suspect a bit that whether it is worthy to try to recover from [1].
> The Eh kthread solution could make things easier, but the codes for recovery from [1] has
> made code really complicated. It is more difficult to unify the nvme-pci, rdma and fc.

Another choice may be nested EH, which should be easier to implement:

- run the whole recovery procedures(shutdown & reset) in one single context
- and start a new context to handle new timeout during last recovery in the
same way

The two approaches is just like sync IO vs AIO.

Thanks,
Ming Lei
