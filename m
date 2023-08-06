Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F52EC001DE
	for <linux-block@archiver.kernel.org>; Sun,  6 Aug 2023 13:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHFNgY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Aug 2023 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHFNgY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Aug 2023 09:36:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD75C9
        for <linux-block@vger.kernel.org>; Sun,  6 Aug 2023 06:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5EE06114C
        for <linux-block@vger.kernel.org>; Sun,  6 Aug 2023 13:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E84C433C8;
        Sun,  6 Aug 2023 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691328982;
        bh=x0PpT5p+QbnzQ42XPIImjfH70NVnMPNFz0tYlMnwl5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSGNzWyotOrdMn3jwBKbL4Ta4b/Ql9eX3Rzj6uj/uSbof6tWvunzBYVpDl48ifFbQ
         qRdnnp4KOZO2eug5qQ0mkeBr/Te64zP7e2HwtH80rTqq9/OdCe5qmG2tjnjLocuyyw
         SSeSUcxKrzsGvWHCo/H6WD6oFt+nhc1HgNBPlJQw=
Date:   Sun, 6 Aug 2023 15:36:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        nbd@other.debian.org
Subject: Re: [PATCH v1] drivers: block: Updates return value check
Message-ID: <2023080600-pretext-corporal-61e3@gregkh>
References: <20230806122351.157168-1-atulpant.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806122351.157168-1-atulpant.linux@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 06, 2023 at 05:53:51PM +0530, Atul Kumar Pant wrote:
> Updating the check of return value from debugfs_create_dir
> to use IS_ERR.

Why?

> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  drivers/block/nbd.c     | 4 ++--
>  drivers/block/pktcdvd.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 9c35c958f2c8..65ecde3e2a5b 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1666,7 +1666,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
>  		return -EIO;
>  
>  	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
> -	if (!dir) {
> +	if (IS_ERR(dir)) {
>  		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
>  			nbd_name(nbd));
>  		return -EIO;

This isn't correct, sorry.  Please do not make this change.

> @@ -1692,7 +1692,7 @@ static int nbd_dbg_init(void)
>  	struct dentry *dbg_dir;
>  
>  	dbg_dir = debugfs_create_dir("nbd", NULL);
> -	if (!dbg_dir)
> +	if (IS_ERR(dbg_dir))
>  		return -EIO;

Again, not corrct.

>  	nbd_dbg_dir = dbg_dir;
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index d5d7884cedd4..69e5a100b3cf 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -451,7 +451,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
>  	if (!pkt_debugfs_root)
>  		return;
>  	pd->dfs_d_root = debugfs_create_dir(pd->name, pkt_debugfs_root);
> -	if (!pd->dfs_d_root)
> +	if (IS_ERR(pd->dfs_d_root))
>  		return;

Also not correct.

Why check the return value at all?  As this check has always been wrong,
why are you wanting to keep it?

Also, you never responded to our previous review comments, why not?  To
ignore people is not generally considered a good idea :(

greg k-h
