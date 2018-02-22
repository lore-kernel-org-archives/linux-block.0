Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:47008 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbeBVH2g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 02:28:36 -0500
Received: by mail-lf0-f68.google.com with SMTP id r80so5973363lfe.13
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 23:28:35 -0800 (PST)
Subject: Re: [PATCH 03/20] lightnvm: fix capabilities for 2.0 sysfs
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-4-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <23b494fb-264d-a8ef-6172-5330d5a63bea@lightnvm.io>
Date: Thu, 22 Feb 2018 08:28:33 +0100
MIME-Version: 1.0
In-Reply-To: <1519205218-26994-4-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/21/2018 10:26 AM, Javier González wrote:
> Both 1.2 and 2.0 specs define a field for media and controller
> capabilities. Also, 1.2 defines a separate field dedicated to device
> capabilities.
> 
> In 2.0 sysfs, this values have been mixed. Revert them to the right
> value.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/nvme/host/lightnvm.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 969bb874850c..598abba66f52 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -914,8 +914,8 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
>   
>   	if (strcmp(attr->name, "version") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->ver_id);
> -	} else if (strcmp(attr->name, "capabilities") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.cap);
> +	} else if (strcmp(attr->name, "media_capabilities") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mccap);
>   	} else if (strcmp(attr->name, "read_typ") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.trdt);
>   	} else if (strcmp(attr->name, "read_max") == 0) {
> @@ -993,8 +993,8 @@ static ssize_t nvm_dev_attr_show_12(struct device *dev,
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.tbem);
>   	} else if (strcmp(attr->name, "multiplane_modes") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.mpos);
> -	} else if (strcmp(attr->name, "media_capabilities") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.mccap);
> +	} else if (strcmp(attr->name, "capabilities") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.cap);
>   	} else if (strcmp(attr->name, "max_phys_secs") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", NVM_MAX_VLBA);
>   	} else {
> @@ -1055,7 +1055,7 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
>   
>   /* general attributes */
>   static NVM_DEV_ATTR_RO(version);
> -static NVM_DEV_ATTR_RO(capabilities);
> +static NVM_DEV_ATTR_RO(media_capabilities);
>   
>   static NVM_DEV_ATTR_RO(read_typ);
>   static NVM_DEV_ATTR_RO(read_max);
> @@ -1080,12 +1080,12 @@ static NVM_DEV_ATTR_12_RO(prog_max);
>   static NVM_DEV_ATTR_12_RO(erase_typ);
>   static NVM_DEV_ATTR_12_RO(erase_max);
>   static NVM_DEV_ATTR_12_RO(multiplane_modes);
> -static NVM_DEV_ATTR_12_RO(media_capabilities);
> +static NVM_DEV_ATTR_12_RO(capabilities);
>   static NVM_DEV_ATTR_12_RO(max_phys_secs);
>   
>   static struct attribute *nvm_dev_attrs_12[] = {
>   	&dev_attr_version.attr,
> -	&dev_attr_capabilities.attr,
> +	&dev_attr_media_capabilities.attr,
>   
>   	&dev_attr_vendor_opcode.attr,
>   	&dev_attr_device_mode.attr,
> @@ -1108,7 +1108,7 @@ static struct attribute *nvm_dev_attrs_12[] = {
>   	&dev_attr_erase_typ.attr,
>   	&dev_attr_erase_max.attr,
>   	&dev_attr_multiplane_modes.attr,
> -	&dev_attr_media_capabilities.attr,
> +	&dev_attr_capabilities.attr,
>   	&dev_attr_max_phys_secs.attr,
>   
>   	NULL,
> @@ -1134,7 +1134,7 @@ static NVM_DEV_ATTR_20_RO(reset_max);
>   
>   static struct attribute *nvm_dev_attrs_20[] = {
>   	&dev_attr_version.attr,
> -	&dev_attr_capabilities.attr,
> +	&dev_attr_media_capabilities.attr,
>   
>   	&dev_attr_groups.attr,
>   	&dev_attr_punits.attr,
> 

With the mccap changes, it should make sense to keep the capabilities as is.
