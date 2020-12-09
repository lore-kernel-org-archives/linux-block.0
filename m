Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EBCC4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E421923B79
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 07:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgLIHhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 02:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgLIHhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 02:37:24 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9920CC0613D6
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 23:36:43 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id jx16so652998ejb.10
        for <linux-block@vger.kernel.org>; Tue, 08 Dec 2020 23:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UA44RrXj/Op8plv0v8h0D8Z4mBnynfJmnSPQ6/b9gLY=;
        b=LZX1uYunDFgDIxR6Lnkx6UdTzZlmqfRGkqrFxy8lsqpObwm8MJXc7nZ8yo2t6r9yVL
         n6cNFUqFLqomN1h8VuODjwheM6wXalgBw43+cUB5yk5Hp3MVofxrb5kX2YNr35HA6Oxk
         YW+x3N7gJYx2eh30VoLL6bWDr8ohtYw7ca3yxdqYmgMKkUSPysFGoQO5ESm41c1JMmFz
         CIWD4r/O0udeqhibEtol4wz0Gyl9uh/s0EiaF8DY3TVS3XPoCoakm86uX11JeGHEZh+0
         GOcFuS1C1QcQNtW/9vByhTygy9OR0QqbIAJOj9yc55oZOwhWK9dZKvEb+/Y+MFfTOcYm
         1ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UA44RrXj/Op8plv0v8h0D8Z4mBnynfJmnSPQ6/b9gLY=;
        b=e4ySXcGI+P+9p4BT7WS/kDAf2renhM3uMveAGZ199XsosZfeT1ElCnmnU36uJCc5kE
         q5cH52ntVlPOSUY1U0M/Yvb2vNGCcFnOEnkBAdZ0mqwv5BoqQZC60xXUAv0Ho/7XCYY8
         tRQWz2esawwGVhZMmNxdjWtir1EAgRoHfSf4ojmfuA25Cpe/5PHzhFK4sD7IgdrqJgDb
         6GbbOMLy0dmM45WfHcVgfvyr8GKNqIDH0OUR29Fa7v2RFONF1phWtLk4KHOBDt7XJhfo
         1Yk3u1E1tV/egArMmd6dbQypgyXWL3ATUUc4jBk6/EQG86mGnE0aHWvbz77NsuGnKtME
         ikIg==
X-Gm-Message-State: AOAM5301t7tMDCHnXoa3hVTXosqmHbKUQsV5qv3wLXDFm4t/hJHtodBb
        A79P63AhgTo2NvE7RsH63v9lkASVlMpstGia9yhuMw==
X-Google-Smtp-Source: ABdhPJy4xAuX5Q3bGZ4jdHtO3el9O1QyJABOEBrHlTFr+KeC6eOsQgQ21Wa+c4RzNjXDBBwQJLtuwWK/2Ow7dNbE0w8=
X-Received: by 2002:a17:906:94ca:: with SMTP id d10mr942078ejy.62.1607499402342;
 Tue, 08 Dec 2020 23:36:42 -0800 (PST)
MIME-Version: 1.0
References: <X9B0IyxwbBDq+cSS@mwanda>
In-Reply-To: <X9B0IyxwbBDq+cSS@mwanda>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 9 Dec 2020 08:36:31 +0100
Message-ID: <CAMGffEn6a92UDBgzkR2L6wutNBpxY_xNf3cakvbivkaGRnk_uQ@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd-clt: Fix error code in rnbd_clt_add_dev_symlink()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>,
        linux-block <linux-block@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Dan,



On Wed, Dec 9, 2020 at 7:52 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "ret" variable should be set to -ENOMEM but it returns uninitialized
> stack data.
>
> Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for the patch. But there is already a fix from Colin merged in
block tree:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.11/drivers&id=733c15bd3a944b8eeaacdddf061759b6a83dd3f4

There is still other problem through with commit 64e8a6ece1a5
("block/rnbd-clt: Dynamically alloc buffer for pathname &
blk_symlink_name")

I will send the fix today together with other changes.

Regards!
Jack
