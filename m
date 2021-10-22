Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306B4C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 19:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1C661038
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 19:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhJVTFK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhJVTFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 15:05:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE47AC061766;
        Fri, 22 Oct 2021 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PscFrIvRQmZ/SyvfN+2TNRMCi8BT9Zm26PD1KUve61w=; b=i5+cLgGdoClMK8jZTxm7kMjR1B
        frWDoxQ49TrcXshL68GhoGaWD0TRqiTn0+TLLl5CyA9m5WuhtK1KI11q0CbIVZGQsbYpHJa/7Vw5R
        IjluvykhPHeX3gZpb+uj//f7Lb2M9cmZM0UTFfhnLy2f+8+ZHf0QgU9vsdBYyn+JBELf4tk90ZH4R
        RBfRHPX9WIAjrFCrISgO26wZ8rqqeZmXdUqJmjiHryK0j2EuiNvDv3J3UEMv6pGW7Vi4FjJnSLcEx
        xiCfjqnLp/SkAKkI93IwtSMRV3kOvsvxi1sRPjXUBbGfElInTRai7gFc12UEhiaWQlRFaZ030JdBc
        gTOWJtlw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdzoQ-00BnTC-82; Fri, 22 Oct 2021 19:02:42 +0000
Date:   Fri, 22 Oct 2021 12:02:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/4] zram: avoid race between zram_remove and
 disksize_store
Message-ID: <YXMK0l5lDeIH8qMQ@bombadil.infradead.org>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
 <20211020015548.2374568-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020015548.2374568-4-ming.lei@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 09:55:47AM +0800, Ming Lei wrote:
> After resetting device in zram_remove(), disksize_store still may come and
> allocate resources again before deleting gendisk, fix the race by resetting
> zram after del_gendisk() returns. At that time, disksize_store can't come
> any more.
> 
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/zram/zram_drv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 8883de7aa3d7..6078d1dae44a 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2002,6 +2002,13 @@ static int zram_remove(struct zram *zram)
>  	/* del_gendisk drains pending reset_store */
>  	WARN_ON_ONCE(claimed && zram->claim);
>  
> +	/*
> +	 * disksize store may come between zram_reset_device and del_gendisk, so
> +	 * run the last reset for avoiding leak anything allocated in
> +	 * disksize_store().

The above is not clear English, how about:

disksize_store() may be called in between zram_reset_device() and
del_gendisk(), so run the last reset to avoid leaking anything allocated
with disksize_store()

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
