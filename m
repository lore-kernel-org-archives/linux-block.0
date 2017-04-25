Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:47356
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1951591AbdDYRH7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2017 13:07:59 -0400
From: =?iso-8859-1?Q?Matias_Bj=F8rling?= <matias@cnexlabs.com>
To: Christoph Hellwig <hch@lst.de>,
        Javier Gonzalez <javier@cnexlabs.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] nvme/lightnvm: add missing endianess conversion in
        nvme_nvm_end_io
Date: Tue, 25 Apr 2017 17:07:53 +0000
Message-ID: <MWHPR06MB2781448DFC0474CCEB0A6CE7BA1E0@MWHPR06MB2781.namprd06.prod.outlook.com>
References: <20170421063017.26380-1-hch@lst.de>,<20170425164100.GA15964@lst.de>
In-Reply-To: <20170425164100.GA15964@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

________________________________________
From: Christoph Hellwig <hch@lst.de>
Sent: 25 April 2017 09:41
To: Javier Gonzalez; Matias Bj=F8rling
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme/lightnvm: add missing endianess conversion in nvm=
e_nvm_end_io

Javier, Matias:  can I get a quick ACK?  This is the last patch needed
to make drivers/nvme warning-free.

On Fri, Apr 21, 2017 at 08:30:17AM +0200, Christoph Hellwig wrote:
> Found by sparse.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/lightnvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index de61a4a03d78..e4e4e60b1224 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -483,7 +483,7 @@ static void nvme_nvm_end_io(struct request *rq, int e=
rror)
>  {
>       struct nvm_rq *rqd =3D rq->end_io_data;
>
> -     rqd->ppa_status =3D nvme_req(rq)->result.u64;
> +     rqd->ppa_status =3D le64_to_cpu(nvme_req(rq)->result.u64);
>       rqd->error =3D nvme_req(rq)->status;
>       nvm_end_io(rqd);
>
> --
> 2.11.0
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Thanks Christoph.

Reviewed-by: Matias Bj=F8rling <matias@cnexlabs.com>=
