Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:43285 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbdIULcn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:32:43 -0400
Received: by mail-wm0-f46.google.com with SMTP id m72so454657wmc.0
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 04:32:42 -0700 (PDT)
Subject: Re: [PATCH 6/6] lightnvm: include NVM Express driver if OCSSD is
 selected for build
To: Rakesh Pandit <rakesh@tuxera.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <20170921112832.GA28582@dhcp-216.srv.tuxera.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <b33a3e2a-2465-a0f4-5807-868a259e8850@lightnvm.io>
Date: Thu, 21 Sep 2017 13:32:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170921112832.GA28582@dhcp-216.srv.tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/21/2017 01:28 PM, Rakesh Pandit wrote:
> Because NVM needs BLK_DEV_NVME, select it automatically if we mark NVM
> in config file before building kernel.
> 
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
>   drivers/lightnvm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> index ead61a9..b3c00cb 100644
> --- a/drivers/lightnvm/Kconfig
> +++ b/drivers/lightnvm/Kconfig
> @@ -5,6 +5,7 @@
>   menuconfig NVM
>   	bool "Open-Channel SSD target support"
>   	depends on BLOCK && HAS_DMA
> +	select BLK_DEV_NVME
>   	help
>   	  Say Y here to get to enable Open-channel SSDs.
>   
> 

Thanks Rakesh. I've picked it up for 4.15.
