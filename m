Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375B6C433ED
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 15:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDE66112F
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 15:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhDBPG3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 11:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBPG3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Apr 2021 11:06:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3409361103;
        Fri,  2 Apr 2021 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617375987;
        bh=Zz61+Zv+0eQq6UNIJIIuqH0bH3OpUwYDc4oQL8V3jq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Px4srRQ2HP1H9cR723OYPVptqskOEl4eynqXNC2SML4LPE6/1Oiom0rTq429gBMmc
         j/De5i4vBBE9pDUO7BRkOT6/ZaNfj+8NtymcedhKh2QOYuYDzV5uELhG03kG6nVQBV
         JJkxxrAc0hmSRito8+UeHuFMFRtnU73npB+nozgU=
Date:   Fri, 2 Apr 2021 17:06:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, axboe@kernel.dk,
        hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH] drivers core: don't do anything in device_del() when
 device_add() fail
Message-ID: <YGcy8amoQiYX48xL@kroah.com>
References: <20210401130138.2164928-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401130138.2164928-1-yuyufen@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 01, 2021 at 09:01:38AM -0400, Yufen Yu wrote:
> Recently, our syzbot test reported NULL pointer dereference in
> device_del() by injecting memory allocation fail in device_add().

Don't do that :)

> For now, callers of device_add(), such as add_disk(), may ignore
> device_add()'s fail and go on working.

Please fix up those users, if device_add() fails there is no need to
call device_del().

> In unregister path, it will
> call device_del() from del_gendisk(). That can cause various NULL
> pointer dereference, including dev->p is NULL in kill_device(),
> 'name' is NULL in sysfs_remove_link(), kobj->sd is 'NULL' when call
> dpm_sysfs_remove(), and so on.
> 
> To avoid these kernel panic, we call device_del() only when device_add()
> is success.

As Rafael said, that's not what you are doing here, so even if I wanted
to take this patch, I can't.

> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  drivers/base/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f29839382f81..a10ec5dbc577 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3380,6 +3380,9 @@ void device_del(struct device *dev)
>  	struct class_interface *class_intf;
>  	unsigned int noio_flag;
>  
> +	if (!dev->p)
> +		return;

Also, this isn't a good test as it's not obvious what you are trying to
check for here.

thanks,

greg k-h
