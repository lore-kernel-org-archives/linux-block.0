Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <776f21e1-dc19-1b77-9ba4-44f0b8366625@oracle.com>
 <20180514093850.GA807@ming.t460p>
 <008cb38d-aa91-6ab7-64d9-417d6c53a1eb@oracle.com>
 <20180514122211.GB807@ming.t460p> <20180515003332.GB21743@ming.t460p>
 <d97b375f-9b47-6b95-bd5b-8166dae93676@oracle.com>
 <20180516020420.GB17412@ming.t460p> <20180516020903.GC17412@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c9a621e1-f114-321f-6a7d-b04a2c987582@oracle.com>
Date: Wed, 16 May 2018 10:15:32 +0800
MIME-Version: 1.0
In-Reply-To: <20180516020903.GC17412@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi ming

On 05/16/2018 10:09 AM, Ming Lei wrote:
> So could you check if only the patch("unquiesce admin queue after shutdown
> controller") can fix your IO hang issue?

I indeed tested this before fix the warning.
It could fix the io hung issue. :)

Thanks
Jianchao
