Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89790C433FE
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E76610FC
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbhI0Ww2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbhI0Ww2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:52:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664D0C061604;
        Mon, 27 Sep 2021 15:50:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l8so27872768edw.2;
        Mon, 27 Sep 2021 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbtHxjRemmXiBIhG0GW8nlURXNpwyPs370Xxo7AeQQk=;
        b=YZ2VTmSCUUUwt9GaX+TF009NFPIKAVOBMPTgS3jayY1GsTxjk0eyD6zyo3KSDp2ffd
         15/G6kf8ngNImvfP+WO3GwmQFWGvbVqsojWS5PsZGnhvbMFfwNf8hSswllXfjJWH5bOE
         iuZL52rFsekbaWI4lIXdwtbN7zFzDlTDgpjQpSXSpN15NE9HDPayoVqneLYjbtMi9s4X
         ps/Z9ps2NUVxdYW6SyynTklGHbpuzsS5CawTlfWbAl6o8ozZlHhvGY0lDmYlvpfHfCUs
         GD4OE0hwIQQOcnCDaiwMPQ95SiG9tHFH0M56s31hXESkpNn5z5fJT/O3fmOeyg3xh3Pb
         IunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbtHxjRemmXiBIhG0GW8nlURXNpwyPs370Xxo7AeQQk=;
        b=5XKaGDkvcoVJlL9pe3UVR14KU1IbdbEqhoa2oXQb8YbzBmP/uHfSlLrss1J+KnyQaN
         QiSbvFt/kc2xkXE+rFV/Fkq6j7km1NXTOWm/+jZRciq7/X8ofqwnF3pSHNnofBclieLL
         lgqde1932/1h0ObLfD3ckb79qj2JeDiPB7vGTciW/Q8CPhfFN5H7w8N3ioEeI09LpkJo
         x7LfCmfhOjDZGYeH1bqEKlknECJVJ5kA2gvvm04hm6QGe9+bNLjoCDnTwvB/hc/9qXJK
         AY/NCYnsAlrQR/vSa+6B8fMVBPYl9zyLMnHbIxNQHGpSnXmQ6U3VWOV8ivIkLcVxMknZ
         4BwQ==
X-Gm-Message-State: AOAM533e0WmKIMXdRejW6+kRdES6HJmsBpTPy7fVrLEbYjlrJ7sBxIbg
        b5eAu9JD0RrwHjpANgIHL1pRImmKJBiraOkjycM=
X-Google-Smtp-Source: ABdhPJxqWtQBQk+q3MXvQ7lymGiQEolFkglJxXrWFsK3GxDKn2WvP9KOWmJHtaEmST6By7Czy4V78fbFN5iEYd3RzYA=
X-Received: by 2002:aa7:d592:: with SMTP id r18mr3465274edq.172.1632783048036;
 Mon, 27 Sep 2021 15:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210927220110.1066271-1-mcgrof@kernel.org> <20210927220110.1066271-7-mcgrof@kernel.org>
In-Reply-To: <20210927220110.1066271-7-mcgrof@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 27 Sep 2021 15:50:36 -0700
Message-ID: <CAMo8BfLX84HBuVe=FyqWkVU5Ek-aKFk++omnqsmf9wO6fdVpMQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] xtensa/platforms/iss/simdisk: add error handling
 support for add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, justin@coraid.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, hare@suse.de,
        Tejun Heo <tj@kernel.org>, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        Chris Zankel <chris@zankel.net>, tim@cyberelk.net,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-um@lists.infradead.org,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 27, 2021 at 3:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  arch/xtensa/platforms/iss/simdisk.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
