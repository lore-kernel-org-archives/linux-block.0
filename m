Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34590 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbdDKOfz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 10:35:55 -0400
Received: by mail-wr0-f178.google.com with SMTP id z109so30296131wrb.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 07:35:49 -0700 (PDT)
Subject: Re: [PATCH 3/3] lightnvm: convert sprintf into strlcpy
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1491920338-2348-1-git-send-email-javier@cnexlabs.com>
 <1491920338-2348-5-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d525e1ce-1407-5106-609e-ed679274f0fe@lightnvm.io>
Date: Tue, 11 Apr 2017 16:35:37 +0200
MIME-Version: 1.0
In-Reply-To: <1491920338-2348-5-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/11/2017 04:18 PM, Javier González wrote:
> Convert sprintf calls to strlcpy in order to make possible buffer
> overflow more obvious.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 258007a..2c26af3 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -273,7 +273,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>  		goto err_disk;
>  	blk_queue_make_request(tqueue, tt->make_rq);
>
> -	sprintf(tdisk->disk_name, "%s", create->tgtname);
> +	strlcpy(tdisk->disk_name, create->tgtname, sizeof(tdisk->disk_name));
>  	tdisk->flags = GENHD_FL_EXT_DEVT;
>  	tdisk->major = 0;
>  	tdisk->first_minor = 0;
> @@ -1198,13 +1198,13 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
>  	list_for_each_entry(dev, &nvm_devices, devices) {
>  		struct nvm_ioctl_device_info *info = &devices->info[i];
>
> -		sprintf(info->devname, "%s", dev->name);
> +		strlcpy(info->devname, dev->name, sizeof(info->devname));
>
>  		/* kept for compatibility */
>  		info->bmversion[0] = 1;
>  		info->bmversion[1] = 0;
>  		info->bmversion[2] = 0;
> -		sprintf(info->bmname, "%s", "gennvm");
> +		strlcpy(info->bmname, "gennvm", sizeof(info->bmname));
>  		i++;
>
>  		if (i > 31) {
>
Thanks. Applied for 4.12.
