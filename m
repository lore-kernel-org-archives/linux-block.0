Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84681C433ED
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 07:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9BA613BB
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 07:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhDMHf3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231236AbhDMHf2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 03:35:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29246613B8;
        Tue, 13 Apr 2021 07:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618299309;
        bh=hrLewTy+tax+Ne9nlzA7X9m5SbQlFR8964ZNQauoK2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7lCWUve2gHCK/PTOlQakXcSd8bD7rUvQP3uQTBTSn163QoboBGGXsVSHRYLgvBVU
         M+PWgWJzqWMvNwFkAoSxjcDdqd5UrdlteUrmCQU3xJlWQtyPs7IRQPdh9c24QxCMUo
         2bASHbAAkeQEMCJ+4ZNJ8VvE9RoW0DlJhFLT4aPE=
Date:   Tue, 13 Apr 2021 09:35:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     damien.lemoal@wdc.com, bvanassche@acm.org,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v7 3/3] bio: add limit_bio_size sysfs
Message-ID: <YHVJq0n/fzd6WVO4@kroah.com>
References: <20210413025502.31579-1-nanich.lee@samsung.com>
 <CGME20210413031259epcas1p4406eaed9ba20e684fc038bf1937b94ff@epcas1p4.samsung.com>
 <20210413025502.31579-4-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413025502.31579-4-nanich.lee@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 13, 2021 at 11:55:02AM +0900, Changheun Lee wrote:
> Add limit_bio_size block sysfs node to limit bio size.
> Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size is set.
> And bio max size will be limited by queue max sectors via
> QUEUE_FLAG_LIMIT_BIO_SIZE set.
> 
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> ---
>  Documentation/ABI/testing/sysfs-block | 10 ++++++++++
>  Documentation/block/queue-sysfs.rst   |  7 +++++++
>  block/blk-sysfs.c                     |  3 +++
>  3 files changed, 20 insertions(+)

Isn't it too late to change the sysfs entry after the device has been
probed and initialized by the kernel as the kernel does not look at this
value after that?

Why do you need a userspace knob for this?  What tool is going to ever
change this, and what logic is it going to use to change it?  Why can't
the kernel also just "do the right thing" and properly detect this
option as well as userspace can?

thanks,

greg k-h
