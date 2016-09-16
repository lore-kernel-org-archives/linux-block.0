Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34871 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbcIPKTy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2016 06:19:54 -0400
Received: by mail-pa0-f66.google.com with SMTP id pp5so3321496pac.2
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2016 03:19:54 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: propagate device_add() error code
To: Arnd Bergmann <arnd@arndb.de>, Matias Bjorling <mb@lightnvm.io>
References: <20160915155325.3009409-1-arnd@arndb.de>
Cc: "Simon A. F. Lund" <slund@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <57DBC746.4000509@bjorling.me>
Date: Fri, 16 Sep 2016 12:19:50 +0200
MIME-Version: 1.0
In-Reply-To: <20160915155325.3009409-1-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/15/2016 05:53 PM, Arnd Bergmann wrote:
> device_add() may fail, and all callers are supposed to check the
> return value, but one new user in lightnvm doesn't:
>
> drivers/lightnvm/sysfs.c: In function 'nvm_sysfs_register_dev':
> drivers/lightnvm/sysfs.c:184:2: error: ignoring return value of 'device_add', declared with attribute warn_unused_result [-Werror=unused-result]
>
> This changes the caller to propagate any error codes, which avoids
> the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 38c9e260b9f9 ("lightnvm: expose device geometry through sysfs")
> ---
>   drivers/lightnvm/lightnvm.h | 2 +-
>   drivers/lightnvm/sysfs.c    | 9 ++++++---
>   2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/lightnvm/lightnvm.h b/drivers/lightnvm/lightnvm.h
> index 93f1aacc9f02..305c181509a6 100644
> --- a/drivers/lightnvm/lightnvm.h
> +++ b/drivers/lightnvm/lightnvm.h
> @@ -24,7 +24,7 @@
>   #include <linux/lightnvm.h>
>
>   /* core -> sysfs.c */
> -int nvm_sysfs_register_dev(struct nvm_dev *);
> +int __must_check nvm_sysfs_register_dev(struct nvm_dev *);
>   void nvm_sysfs_unregister_dev(struct nvm_dev *);
>   int nvm_sysfs_register(void);
>   void nvm_sysfs_unregister(void);
> diff --git a/drivers/lightnvm/sysfs.c b/drivers/lightnvm/sysfs.c
> index 72ad089c0269..0338c27ab95a 100644
> --- a/drivers/lightnvm/sysfs.c
> +++ b/drivers/lightnvm/sysfs.c
> @@ -174,6 +174,8 @@ static struct device_type nvm_type = {
>
>   int nvm_sysfs_register_dev(struct nvm_dev *dev)
>   {
> +	int ret;
> +
>   	if (!dev->parent_dev)
>   		return 0;
>
> @@ -181,11 +183,12 @@ int nvm_sysfs_register_dev(struct nvm_dev *dev)
>   	dev_set_name(&dev->dev, "%s", dev->name);
>   	dev->dev.type = &nvm_type;
>   	device_initialize(&dev->dev);
> -	device_add(&dev->dev);
> +	ret = device_add(&dev->dev);
>
> -	blk_mq_register_dev(&dev->dev, dev->q);
> +	if (!ret)
> +		blk_mq_register_dev(&dev->dev, dev->q);
>
> -	return 0;
> +	return ret;
>   }
>
>   void nvm_sysfs_unregister_dev(struct nvm_dev *dev)
>

Thans Arnd. Applied for 4.9.
