Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE80FC433F5
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 22:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBADB60E78
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 22:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhKAWaJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhKAWaI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 18:30:08 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB12C061764
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 15:27:35 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bm28so2908215qkb.9
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mliPFQw/VXY6h6LfJw+z8TDpoLPTsaNzP4QdSOLirug=;
        b=gX2iWwDZMxAwg66h05cvntq2We2412TUSARCH3vd0l9MrhRe59sUYEWUahMEYEwsmm
         1Is6pGVL11an9gIOAOSa87IkQB1zY0kUX5AR8d4u4jpbLKfG7eeByqb36lPu9uN7yAy5
         Edw6fli3oK6tRHJIc0Dg0X3zwuasPSQTuqBb4hjNk6mE3yU7euWaYxwp9zBiiljIvx0l
         bDzb/eea/LTkwB6E9cyv2CS5/64XMIfOi3NDurZMNwQqddS9bvyeuyOorWR+zOMxk61V
         2bYDdPI66TDJlVB+1jdep/krNHmsDSk4YjejyOxuNAbwdrl+ssl0343wRy6Yk9mnbdeG
         17Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mliPFQw/VXY6h6LfJw+z8TDpoLPTsaNzP4QdSOLirug=;
        b=ci7fa4lJrY5h93T1dZQsbY4NwzwfWLPi1u2SmSV1FUc2a04Xgd0cCMD2wUYNl9ruJZ
         87MzEIIneOuutuaVnM7JAq0ESO80fsprUQGTvaJSeNtgDXpBaHw1xnF6NYvcczc+U1aO
         D/81td2u9p2SPy4hWPjJEX6QS9p/fidaEYBlthuTcrxmSgborXk5PYzkZ9vovWA/3mYo
         753vevqU9/BzjyfvzZwCjbnjENrRl+NO+5Ye22Ped4ELPjgHa6pSmM6V1YMT0NQV4oEt
         l9SLRaQgZMQWFlk7Fif7QiqDv4eR8tXjE2amARsq9I+eqitVIAvulX3oYa2ebXj5fUbx
         A8QQ==
X-Gm-Message-State: AOAM53303e6/xqdj9Km/AwUeYI42JwpxuqF5EBt92+cIo+zp6oszOq1+
        L6kUw4Cos2SfMrVkDp+vofDFAA==
X-Google-Smtp-Source: ABdhPJzKaslVle6xaIWUiwO8S+vEDWP3Uhb242PjJ4oPKfpLLEk+Y1oAfGLg0KjBouG+cDsp+lj6ew==
X-Received: by 2002:a05:620a:1381:: with SMTP id k1mr25078573qki.492.1635805654062;
        Mon, 01 Nov 2021 15:27:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q13sm11520686qtx.80.2021.11.01.15.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:27:33 -0700 (PDT)
Date:   Mon, 1 Nov 2021 18:27:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH -next v3 0/2] Fix hungtask when nbd_config_put
Message-ID: <YYBp1LO83KWlov7V@localhost.localdomain>
References: <20211101062956.791573-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101062956.791573-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 01, 2021 at 02:29:54PM +0800, Ye Bin wrote:
> Ye Bin (2):
>   nbd: Fix incorrect error handle when first_minor big than '0xff' in
>     nbd_dev_add
>   nbd: Fix hungtask when nbd_config_put
> 
>  drivers/block/nbd.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 

Hmm this seems to overlap with the series

https://lore.kernel.org/linux-block/20211021122936.758221-1-yukuai3@huawei.com/

and they are different checks, can y'all work out what this is supposed to look
like and send one series to integrate both sets of fixes?  Thanks,

Josef
