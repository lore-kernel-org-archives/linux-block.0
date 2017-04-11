Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34519 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbdDKKle (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 06:41:34 -0400
Received: by mail-wr0-f176.google.com with SMTP id z109so26008201wrb.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 03:41:33 -0700 (PDT)
Subject: Re: [PATCH 3/4] lightnvm: bad type conversion for nvme control bits
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
 <1491589874-26818-3-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d5982c6f-2bd5-e63b-54ac-84cee9efda78@lightnvm.io>
Date: Tue, 11 Apr 2017 12:41:32 +0200
MIME-Version: 1.0
In-Reply-To: <1491589874-26818-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/07/2017 08:31 PM, Javier González wrote:
> The NVMe I/O command control bits are 16 bytes, but is interpreted as
> 32 bytes in the lightnvm user I/O data path.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/nvme/host/lightnvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 2c8f933..83e7ea2 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -754,7 +754,7 @@ static int nvme_nvm_user_vcmd(struct nvme_ns *ns, int admin,
>  	c.common.cdw2[1] = cpu_to_le32(vcmd.cdw3);
>  	/* cdw11-12 */
>  	c.ph_rw.length = cpu_to_le16(vcmd.nppas);
> -	c.ph_rw.control  = cpu_to_le32(vcmd.control);
> +	c.ph_rw.control  = cpu_to_le16(vcmd.control);
>  	c.common.cdw10[3] = cpu_to_le32(vcmd.cdw13);
>  	c.common.cdw10[4] = cpu_to_le32(vcmd.cdw14);
>  	c.common.cdw10[5] = cpu_to_le32(vcmd.cdw15);
>
Thanks. Applied for 4.12.
