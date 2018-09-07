Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34727 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIGPI5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Sep 2018 11:08:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so6813081pgv.1
        for <linux-block@vger.kernel.org>; Fri, 07 Sep 2018 03:28:39 -0700 (PDT)
Subject: Re: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
To: javier@javigon.com
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4ac29eb8-65bf-f733-d196-80c5bb41876c@lightnvm.io>
Date: Fri, 7 Sep 2018 12:28:33 +0200
MIME-Version: 1.0
In-Reply-To: <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2018 12:09 PM, Javier González wrote:
> In the OCSSD 2.0 spec., the sector and metadata sizes are reported though
> the standard nvme identify command. Thus, the lightnvm subsystem needs
> to update this information on the geometry structure on bootup.
> 
> Since 1.2 devices report these values on the OCSSD geometry identify,
> avoid this update is it is unnecessary and can also corrupt the geometry
> if the devices does not report the nvme sizes correctly (which is not
> required by the OCSSD 1.2 spec either) >
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/nvme/host/lightnvm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 5bfa354c5dd5..33ed09f8410e 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -980,6 +980,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>   	struct nvm_dev *ndev = ns->ndev;
>   	struct nvm_geo *geo = &ndev->geo;
>   
> +	if (geo->version == NVM_OCSSD_SPEC_12)
> +		return;

The lba format sizes are not explicit in 2.0 either. For a conforming 
drive, it should implement the NVM Command Set and expose the LBA format 
correctly. Although, I do get your incentive, and if it is okay with 
you, I'll reword the commit message to this and apply it?:

"1.2 devices exposes their data and metadata size through the separate
identify command. Make sure that the NVMe LBA format does not override
these values."


> +
>   	geo->csecs = 1 << ns->lba_shift;
>   	geo->sos = ns->ms;
>   }
> 
