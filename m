Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C417BC64ED9
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 20:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjB0UzY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 15:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjB0UzX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 15:55:23 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158F125971
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 12:55:21 -0800 (PST)
Date:   Mon, 27 Feb 2023 20:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677531320;
        bh=+KvjAxNh/K4RplByoVPV+tkiQERMjKP+jk/W8kiNVJg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=nPao+mb6vGX3lrWAnEUU0zErSc5oa8PbJcJX8ePg3Iag2Yjl3W7bXTsBwNlLs6dCx
         ZoXrvoADhY1crB1d5Eygc4iQXUWZt1vpz89lBfmks1ekrZNxwad4AwjokudlrHBI4I
         YeEi17AFqOcxV6oOlzYbhfH17W/noWdhLdXALKek=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH] nbd: automatically load module on genl access
Message-ID: <c8512a6d-804a-4d64-a263-dad7942f9462@t-8ch.de>
References: <20221110052438.2188-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110052438.2188-1-linux@weissschuh.net>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Josef, Jens,

could you take a look at this patch?

Thanks,
Thomas

On Thu, Nov 10, 2022 at 06:24:38AM +0100, Thomas Weißschuh wrote:
> Instead of forcing the user to manually load the module do it
> automatically.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/block/nbd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5cffd96ef2d7..1c38a7ea9531 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2328,6 +2328,7 @@ static struct genl_family nbd_genl_family __ro_after_init = {
>  	.mcgrps		= nbd_mcast_grps,
>  	.n_mcgrps	= ARRAY_SIZE(nbd_mcast_grps),
>  };
> +MODULE_ALIAS_GENL_FAMILY(NBD_GENL_FAMILY_NAME);
>  
>  static int populate_nbd_status(struct nbd_device *nbd, struct sk_buff *reply)
>  {
> 
> base-commit: f67dd6ce0723ad013395f20a3f79d8a437d3f455
> -- 
> 2.38.1
> 
