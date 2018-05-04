Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3 7/8] nvme: pci: recover controller reliably
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180503031716.31446-1-ming.lei@redhat.com>
 <20180503031716.31446-8-ming.lei@redhat.com>
 <32819b0a-acc8-fa76-5e58-8e75e2bc081b@oracle.com>
 <20180503100824.GA5078@ming.t460p>
 <ea98b607-9c8f-3b18-8314-cdcfd8bc5e96@oracle.com>
 <20180504042451.GA20791@ming.t460p>
 <2e6e88f9-089a-2809-0c2b-4e96ba1199e9@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ee550e2f-d8c2-1633-3e49-9d4e201d080b@oracle.com>
Date: Fri, 4 May 2018 14:21:57 +0800
MIME-Version: 1.0
In-Reply-To: <2e6e88f9-089a-2809-0c2b-4e96ba1199e9@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Oh sorry.

On 05/04/2018 02:10 PM, jianchao.wang wrote:
> nvme_error_handler should invoke nvme_reset_ctrl instead of introducing another interface.
> Then it is more convenient to ensure that there will be only one resetting instance running.

ctrl state is still in RESETTING state, nvme_reset_ctrl cannot work.

Thanks
Jianchao
