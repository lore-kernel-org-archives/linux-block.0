Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60799 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753022AbdKCMya (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Nov 2017 08:54:30 -0400
Date: Fri, 3 Nov 2017 13:54:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: hch@lst.de, sagi@grimberg.me, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 2/3] nvme: compare NQN string with right size
Message-ID: <20171103125429.GB25186@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com> <1509703370-20379-3-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1509703370-20379-3-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Nov 03, 2017 at 11:02:49AM +0100, Javier Gonz�lez wrote:
> Compare subnqns using NVMF_NQN_SIZE as it is < 256
> 
> Signed-off-by: Javier Gonz�lez <javier@cnexlabs.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bd1d5ff911c9..ae8ab0a1ef0d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1743,7 +1743,7 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  
>  	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
>  	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
> -		strcpy(ctrl->subnqn, id->subnqn);
> +		strncpy(ctrl->subnqn, id->subnqn, NVMF_NQN_SIZE);
>  		return;
>  	}

This isn't a compare, but a copy.  Except for that it looks ok to me.
