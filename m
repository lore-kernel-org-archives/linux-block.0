Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B800AC4360F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2DF206C0
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 13:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="tpaSAk1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfDENsk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:48:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36351 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDENsk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 09:48:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id s16so5591001edr.3
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=528B/JfGdpZgxd0kLRXsuvTBl7OzD+enq01pNovCDQ8=;
        b=tpaSAk1hi34jh+YjOUF/7v+U76JGsuZ7RDQzLDlonDXPqRjS1kOo20M3k2Oxplxq9R
         WJDniDgeosTEmvDp7jAmTy/fY5HNEcWARnwyl+gDhgG3kdwWC4eWRvH9TQQQr4uzjk/f
         0bV7F2cxmQC90UxMV7RqzTL0oZrgfsMfeRHsD6e1yFzHk9HVV1HxXWN/VO+LMmQGWecL
         D0sJJ43V3V7tsnIS1JIAG5OsW7DA3gms6GZFGDgyQRLbMbtijnj6ic5kF6ih+tTp1KcF
         w5dByuf5mWZqkxDWCOVTb2QnjNZhosSChRnmnc/WdL7H5ARhON4/50wN4lWPaQuyU7CG
         /TxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=528B/JfGdpZgxd0kLRXsuvTBl7OzD+enq01pNovCDQ8=;
        b=SeCMOsSKvUsrb6nuHFyq9rhKquftK7qo6sKxOW7CdrlLHHSQR3nYtRY1fZClhRKqio
         cd7AiaejxidAG4xNxkELMDsPJcCrV/TN0tUTB7nxMQsC7/Vb4V9/rtCbW1XHjDMxXTdJ
         OTtfL7HouZ8yzNCRvgTF2HQXMGTVKGObYqMOOWHrVIs/hnFBH+2jnGOdyRSGl9+sRjsx
         Xvm6/gyhDQmiG7gQCJ7f0RawYkC4NuvW1G1iFb8xSxnarGAmizBr6aZ4klvTF+gdjRrG
         of5eYZumuIdI5COMmPpPrjCjxmPu5yxI2H6jdAl/RotZ+Cxp2DQLaxGz6z1LHl9442zx
         Jlwg==
X-Gm-Message-State: APjAAAWoGoXd2mmU1sZGrHTG9/e61KyEOxWM3J/j491wsItpQ+nWllTB
        m0M9qVK4LgMq9utPJaxvtuv5K0MO4lg=
X-Google-Smtp-Source: APXvYqyV2Apat/jEYqoU+AEqpQy9e+WtF4eUbrNz7/1ISZ0m1zshZEp7YHg70bdCjENj05ozP35/Ig==
X-Received: by 2002:a17:906:6b51:: with SMTP id o17mr7525978ejs.26.1554472118378;
        Fri, 05 Apr 2019 06:48:38 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id d8sm4018176ejb.19.2019.04.05.06.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 06:48:37 -0700 (PDT)
Subject: Re: [PATCH v3 10/10] lightnvm: track inflight target creations
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190327123901.12323-1-igor.j.konopko@intel.com>
 <20190327123901.12323-11-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <cd6e0671-ff0e-dcbe-4aff-18a43432a8b5@lightnvm.io>
Date:   Fri, 5 Apr 2019 15:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190327123901.12323-11-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/19 1:39 PM, Igor Konopko wrote:
> This patch adds a counter, which is responsible for tracking inflight
> target creations.
> 
> When creation process is still in progress, target is not yet on
> targets list. This causes a chance for removing whole lightnvm
> subsystem by calling nvm_unregister() in the meantime and finally by
> causing kernel panic inside target init function.
> 
> With this patch we are able to track such a scenarios and wait with
> completing nvm_unregister() and freeing memory until target creation
> will be completed.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/core.c  | 19 ++++++++++++++++++-
>   include/linux/lightnvm.h |  2 ++
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index e2abe88..62ed662 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1083,6 +1083,7 @@ static int nvm_core_init(struct nvm_dev *dev)
>   	INIT_LIST_HEAD(&dev->targets);
>   	mutex_init(&dev->mlock);
>   	spin_lock_init(&dev->lock);
> +	dev->create_inflight = 0;
>   
>   	ret = nvm_register_map(dev);
>   	if (ret)
> @@ -1180,6 +1181,11 @@ void nvm_unregister(struct nvm_dev *dev)
>   	struct nvm_target *t, *tmp;
>   
>   	mutex_lock(&dev->mlock);
> +	while (dev->create_inflight > 0) {
> +		mutex_unlock(&dev->mlock);
> +		io_schedule();
> +		mutex_lock(&dev->mlock);
> +	}
>   	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
>   		if (t->dev->parent != dev)
>   			continue;
> @@ -1198,6 +1204,7 @@ EXPORT_SYMBOL(nvm_unregister);
>   static int __nvm_configure_create(struct nvm_ioctl_create *create)
>   {
>   	struct nvm_dev *dev;
> +	int ret;
>   
>   	down_write(&nvm_lock);
>   	dev = nvm_find_nvm_dev(create->dev);
> @@ -1208,7 +1215,17 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
>   		return -EINVAL;
>   	}
>   
> -	return nvm_create_tgt(dev, create);
> +	mutex_lock(&dev->mlock);
> +	dev->create_inflight++;
> +	mutex_unlock(&dev->mlock);
> +
> +	ret = nvm_create_tgt(dev, create);
> +
> +	mutex_lock(&dev->mlock);
> +	dev->create_inflight--;
> +	mutex_unlock(&dev->mlock);
> +
> +	return ret;
>   }
>   
>   static long nvm_ioctl_info(struct file *file, void __user *arg)
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index d3b0270..e462d1d 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -428,6 +428,8 @@ struct nvm_dev {
>   	char name[DISK_NAME_LEN];
>   	void *private_data;
>   
> +	int create_inflight;
> +
>   	void *rmap;
>   
>   	struct mutex mlock;
> 

Hi Igor,

I think this may be better implemented with kref. Such that target 
creator can take a reference upon target initialize and release it again 
afterwards. Then the one turning of the lights can get to run the final 
cleanup routine.

-Matias
