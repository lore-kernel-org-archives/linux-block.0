Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F073C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A92D6108E
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFVHso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhFVHso (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 03:48:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29B63611BF;
        Tue, 22 Jun 2021 07:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624347988;
        bh=k5OShHJzlbgiBh15okQZfljiD9uwOSXoRJyDuSLaKWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCs8RxrZYuZNw+wLVAYR8s04VvxbZ7LFAh9MBMdgLab9mJhxRdCQSZQ4CNFa8A9Ry
         k6/E7JnQqEDMIswtNN16jTlkhOfgG8gu9p/WgL8IlBKH9s1qlavgZfpcO+Iu6moTW3
         MLh9xal3cd58heRG4FSXpSPJuSFdnfOdJ7XXLRXQ=
Date:   Tue, 22 Jun 2021 09:46:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drivers/base/core: refcount kobject and bus on
 device attribute read / store
Message-ID: <YNGVUk18pmTFZqAB@kroah.com>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233651.597220-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621233651.597220-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 04:36:51PM -0700, Luis Chamberlain wrote:
> It's possible today to have a device attribute read or store
> race against device removal. When this happens there is a small
> chance that the derefence for the private data area of the driver
> is NULL.
> 
> Let's consider the zram driver as an example. Its possible to run into
> a race where a sysfs knob is being used, we get preempted, and a zram
> device is removed before we complete use of the sysfs knob. This can happen
> for instance on block devices, where for instance the zram block devices
> just part of the private data of the block device.
> 
> For instance this can happen in the following two situations
> as examples to illustrate this better:
> 
>         CPU 1                            CPU 2
> destroy_devices
> ...
>                                  compact_store()
>                                  zram = dev_to_zram(dev);
> idr_for_each(zram_remove_cb
>   zram_remove
>   ...
>   kfree(zram)
>                                  down_read(&zram->init_lock);
> 
>         CPU 1                            CPU 2
> hot_remove_store
>                                  compact_store()
>                                  zram = dev_to_zram(dev);
>   zram_remove
>     kfree(zram)
>                                  down_read(&zram->init_lock);
> 
> To ensure the private data pointer is valid we could use bdget() / bdput()
> in between access, however that would mean doing that in all sysfs
> reads/stores on the driver. Instead a generic solution for all drivers
> is to ensure the device kobject is still valid and also the bus, if
> a bus is present.
> 
> This issue does not fix a known crash, however this race was
> spotted by Minchan Kim through code inspection upon code review
> of another zram patch.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/base/base.h |  2 ++
>  drivers/base/bus.c  |  4 ++--
>  drivers/base/core.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 42 insertions(+), 6 deletions(-)

Please make this an independent patch of the zram mess and I will be
glad to consider it for the driver core tree then.

thanks,

greg k-h
