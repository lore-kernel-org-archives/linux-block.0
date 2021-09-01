Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD028C4320A
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D8561059
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 19:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhIATjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhIATjo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 15:39:44 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562B8C061575;
        Wed,  1 Sep 2021 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wGnx/rmz0OqMpEcvhGWrN84A7v4283xqEJSD+WpfhBU=; b=WrYWDlmxdtUHZZUeFY6LJYlLFt
        y57bI6R7XBLggF1C9/BdG718ZnykUK1PEksOdZI3/zipDNGy9cOpLHeCby3lYwt0Pkmd3f1nXyud+
        jooZeSTzWBk+Czt58gK83qjjWGzP8NKQD1W1eFcM8zzN9djcFH5JuSIOjFmdJZvHGXUbMqa5L+Meu
        IeXG2IuLmb2+likZOUZX6+zrC/qx7UHXBNe/2/tEk0NygberUWqrlKTW79Zynag2KyIN4TC7urN5h
        66AOUiA2DBy+e4ST7s3rJPmDRy/VSLVGbvbC9lGGeCF2iuJzF7iWO5bS5vP7SVe/NGjTp7nexSxxN
        +0h+dHCQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLW43-0077KJ-TT; Wed, 01 Sep 2021 19:38:27 +0000
Date:   Wed, 1 Sep 2021 12:38:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] pd: add error handling support for add_disk()
Message-ID: <YS/Ws2iD1suaut39@bombadil.infradead.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
 <20210830221000.179369-16-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830221000.179369-16-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 30, 2021 at 03:10:00PM -0700, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/paride/pd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
> index 500b89a4bdaf..226ed5c93b68 100644
> --- a/drivers/block/paride/pd.c
> +++ b/drivers/block/paride/pd.c
> @@ -938,8 +938,12 @@ static int pd_probe_drive(struct pd_unit *disk, int autoprobe, int port,
>  	if (ret)
>  		goto put_disk;
>  	set_capacity(disk->gd, disk->capacity);
> -	add_disk(disk->gd);
> +	ret = add_disk(disk->gd);
> +	if (ret)
> +		goto cleanup_disk;
>  	return 0;
> +cleanup_disk:
> +	blk_cleanup_disk(&disk);

This should be blk_cleanup_disk(disk->gd); Will fix up in my v2.

  Luis
