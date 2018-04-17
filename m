Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36964 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeDQGQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Apr 2018 02:16:28 -0400
Received: by mail-lf0-f67.google.com with SMTP id b23-v6so6615720lfg.4
        for <linux-block@vger.kernel.org>; Mon, 16 Apr 2018 23:16:27 -0700 (PDT)
Subject: Re: [PATCH] nvme: lightnvm: add granby support
To: Wei Xu <wxu@cnexlabs.com>, linux-nvme@lists.infradead.org
Cc: javier@cnexlabs.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <6e50972d-f806-52ac-7983-2642bd211afa@lightnvm.io>
Date: Tue, 17 Apr 2018 08:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 4/17/18 3:55 AM, Wei Xu wrote:
> Add a new lightnvm quirk to identify CNEX’s Granby controller.
> 
> Signed-off-by: Wei Xu <wxu@cnexlabs.com>
> ---
>   drivers/nvme/host/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cb73bc8..9419e88 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2529,6 +2529,8 @@ static const struct pci_device_id nvme_id_table[] = {
>   		.driver_data = NVME_QUIRK_LIGHTNVM, },
>   	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
>   		.driver_data = NVME_QUIRK_LIGHTNVM, },
> +	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
> +		.driver_data = NVME_QUIRK_LIGHTNVM, },
>   	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
> 

Looks good to me.

Reviewed-by: Matias Bjørling <mb@lightnvm.io>

Keith, when convenient can you pick this up for 4.18?
