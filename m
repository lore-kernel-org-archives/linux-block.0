Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37852 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbdIUNlw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 09:41:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so5248955wmh.4
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 06:41:51 -0700 (PDT)
Subject: Re: [PATCH V2] lightnvm: include NVM Express driver if OCSSD is
 selected for build
To: Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <20170921134123.GA29325@dhcp-216.srv.tuxera.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <5259c471-285d-c361-ac68-2907e69aba79@bjorling.me>
Date: Thu, 21 Sep 2017 15:41:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170921134123.GA29325@dhcp-216.srv.tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 09/21/2017 03:41 PM, Rakesh Pandit wrote:
> Because NVM needs BLK_DEV_NVME, select it automatically if we mark NVM
> in config file before building kernel.  Also append PCI to depends as
> select doesn't automatically add dependencies.
> 
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> 
> V2: appends 'depends' with PCI
> 
>   drivers/lightnvm/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> index ead61a9..2a953ef 100644
> --- a/drivers/lightnvm/Kconfig
> +++ b/drivers/lightnvm/Kconfig
> @@ -4,7 +4,8 @@
>   
>   menuconfig NVM
>   	bool "Open-Channel SSD target support"
> -	depends on BLOCK && HAS_DMA
> +	depends on BLOCK && HAS_DMA && PCI
> +	select BLK_DEV_NVME
>   	help
>   	  Say Y here to get to enable Open-channel SSDs.
>   
> 

Thanks Rakesh.
