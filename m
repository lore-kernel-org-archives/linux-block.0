Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34910 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbdEDIEN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 04:04:13 -0400
Received: by mail-lf0-f68.google.com with SMTP id t144so577232lff.2
        for <linux-block@vger.kernel.org>; Thu, 04 May 2017 01:04:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] lightnvm: create cmd before allocating request
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>, mb@lightnvm.io
References: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>,
        Jens Axboe <axboe@fb.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <6f124946-d5a2-e3bc-3594-a41bf758b03e@bjorling.me>
Date: Thu, 4 May 2017 10:04:10 +0200
MIME-Version: 1.0
In-Reply-To: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/03/2017 11:19 AM, Javier González wrote:
> Create nvme command before allocating a request using
> nvme_alloc_request, which uses the command direction. Up until now, the
> command has been zeroized, so all commands have been allocated as a
> read operation.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/nvme/host/lightnvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index de61a4a03d78..090bbeb655bc 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -503,6 +503,8 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
>  	if (!cmd)
>  		return -ENOMEM;
>
> +	nvme_nvm_rqtocmd(rq, rqd, ns, cmd);
> +
>  	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0, NVME_QID_ANY);
>  	if (IS_ERR(rq)) {
>  		kfree(cmd);
> @@ -517,8 +519,6 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
>  		rq->__data_len = 0;
>  	}
>
> -	nvme_nvm_rqtocmd(rq, rqd, ns, cmd);
> -
>  	rq->end_io_data = rqd;
>
>  	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_io);
>

Reviewed-by: Matias Bjørling <matias@cnexlabs.com>

Jens, would you pick this up when convenient? Thank you!
