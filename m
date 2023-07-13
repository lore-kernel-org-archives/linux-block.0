Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D256C001DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 20:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjGMUd2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjGMUd1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 16:33:27 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C442120
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 13:33:26 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-565db4666d7so861526eaf.0
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689280406; x=1691872406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q4LBnvQYMGaYAXdu1AoVu2cAixaHPevENTPqDGX8zmE=;
        b=3qkvShK5M5ZZTm1rRRNP7fxG4P21ZOQ44gVVdW+FARcOqArr9OYc8E9QjvKIg7ad+b
         wnljlOhMhHjdwTmXnXV6cwI14JwQG6O+goxOETiH4Lslcr2CiuH/uwwjYmeu3/XE2Bjs
         uZQZR79Sf7nXNLgXcLXMh2KrdEjguSI2hY7N+Z58pMoMWLV2qVwkLkzy1oV1arx3C2m6
         1C/HlwoxiZrPCDUO3VKqts5vGocGOVKMFxFmfDP4DrhwgUDL0s5HKd+aI3g7uh3VKBCS
         RCNXv+cAXcBR5AuTaQOd7VOkjhYMLRzl6URr7RBaDOFk+bRo//BBJgDoP8FNqddt59mJ
         3Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280406; x=1691872406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4LBnvQYMGaYAXdu1AoVu2cAixaHPevENTPqDGX8zmE=;
        b=cXf4KkHYtuhPpJfl1MdjUDgOwHxI98gRh7u7sdCot2SjibHXLc0XAlNe9J0DEDIbf1
         /2v46Dwa45AfiZQAN5Bo2iBzH6Yt7nUrdG6Q5NHv7r/1lptLtVWMimlaQKv+Ro2tvrQ5
         Wj3oDASlED0941WGNUuwrZv34A5z2zQf2si/2Xf0GBoc8HaRrTh1MtZrEQdnAkbt/tsI
         dlg8YWCrH5sWtzae0148pMP8GFOKeSEBwNJmiXdo2t7aAkrxUANlAO/C6lkjOQIXM9l+
         0xYnQSe6NhxTXlBXEdIc6b0NXSYjpstr+wXxQyhkgfZnzqkPzeTQSIjUod0mCQfRggxU
         +62w==
X-Gm-Message-State: ABy/qLbzwaXSnPtFqwPY8XkpIgMhGYh1ncQIGeI5B2L9uz8k/IMISXYU
        GG8HWy2jClWMKQ87GYxulAhSxA==
X-Google-Smtp-Source: APBJJlGG4VuVwM+4L4wB4MX/WwSs+GeQBUdteNFfVVbOzd4v6pIevqoKMkhL/4Q92QB03MJq/O9PRA==
X-Received: by 2002:a05:6358:7e43:b0:134:e59a:2ffe with SMTP id p3-20020a0563587e4300b00134e59a2ffemr2922810rwm.11.1689280405544;
        Thu, 13 Jul 2023 13:33:25 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s126-20020a0dd084000000b0057a918d6644sm1923706ywd.128.2023.07.13.13.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:33:24 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:33:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] nbd: automatically load module on genl access
Message-ID: <20230713203324.GA338010@perftesting>
References: <20230713-b4-nbd-genl-v3-1-226cbddba04b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713-b4-nbd-genl-v3-1-226cbddba04b@weissschuh.net>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 13, 2023 at 09:29:35PM +0200, Thomas Weiﬂschuh wrote:
> Add a module alias to nbd.ko that allows the generic netlink core to
> automatically load the module when netlink messages for nbd are
> received.
> 
> This frees the user from manually having to load the module before using
> nbd functionality via netlink.
> If the system policy allows it this can even be used to load the nbd
> module from containers which would otherwise not have access to the
> necessary module files to do a normal "modprobe nbd".
> 
> For example this avoids the following error when using nbd-client:
> 
> $ nbd-client localhost 10809 /dev/nbd0
> ...
> Error: Couldn't resolve the nbd netlink family, make sure the nbd module is loaded and your nbd driver supports the netlink interface.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Josef Bacik <josef@toxicpadna.com>

Thanks,

Josef
