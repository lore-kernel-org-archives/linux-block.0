Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91F9C433FE
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 01:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0D56113E
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 01:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhIJBjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 21:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhIJBjg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Sep 2021 21:39:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CD8360235;
        Fri, 10 Sep 2021 01:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631237906;
        bh=86uwgpv3XHY0LHOHBnztwjKU6xGaIlZvY44jUqB/nFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JIlwnRuWGDHWC8ATcmRLJCe4j81R/96waGMmJaWgbtoMA8xb4kffUdDKvRvx1ZQ5W
         pohPcgke1aaJ52uWIXoxLlZWk+wAylAX74PTlrlJHfDpCa5V24gcpOuY2u+FShPty0
         jUyMwwWqKS9az/f5EFCT96UaZPb9b24THLeVbJxT/7U5Xj1nU+HAXohPHjG8GnTB78
         rn69jKK/QWOGiYt//9Bl8pSjd10x7XylFJJNF9Uf+fGi1pvz/lsT0xblbE1q9wE6cR
         5KgQskJxiXrgs0UJdvN7U/GptuJwSNh6aJOmA3beK20RChA9r7JUKf8mBHWPFxCw51
         798UeW9yHUBPQ==
Date:   Fri, 10 Sep 2021 03:38:21 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     axboe@kernel.dk, pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 04/15] block: Add block device LED trigger
 integrations
Message-ID: <20210910033821.7da8299b@thinkpad>
In-Reply-To: <20210909222513.2184795-5-arequipeno@gmail.com>
References: <20210909222513.2184795-1-arequipeno@gmail.com>
        <20210909222513.2184795-5-arequipeno@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu,  9 Sep 2021 17:25:02 -0500
Ian Pilcher <arequipeno@gmail.com> wrote:

> @@ -166,6 +166,9 @@ struct gendisk {
>  #endif	/* CONFIG_BLK_DEV_INTEGRITY */
>  #if IS_ENABLED(CONFIG_CDROM)
>  	struct cdrom_device_info *cdi;
> +#endif
> +#if IS_ENABLED(CONFIG_LEDS_TRIGGER_BLKDEV)
> +	struct ledtrig_blkdev_disk *ledtrig;
>  #endif

So in this patch you are adding pointer to a structure, but the
structure is introduced in a later patch (07/15).

Please send these changes as one patch, it is easier to review.

Marek
