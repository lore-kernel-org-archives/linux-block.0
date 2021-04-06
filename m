Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CEC433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04766117A
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhDFIUu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhDFIUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:20:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209AFC06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:20:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ap14so20567011ejc.0
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 01:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9M2kb8YIcWOd3tqnteodfbIJJWQEJSa/HP5ZuaSACYQ=;
        b=YeZ7YJf5HU74EiId5173dEaST6+nt3YsoHR1W7I3SG5C1sEf29GQGk6iwm0B/oIPAD
         Nz3YXMWD4YonQcO5Outw2TOyLzMdYO6++jXseXjKRE48Ggio2LQ1Ig0CEetlsxI3MtHG
         UNboqTKgEWZDwRHOm2GXMWPH3VICF/ZPqXMEkWmbQmZuvtjVirFYrmqzVLbe1yoZ2BRZ
         epPcVBfuZxZ9MYVxOT2QafYgFCHFskEsGpdi91QVZYqn3CBSQ8soksw9AYp00+fPsSGT
         u0TSBRIiCVDc7RQMxJQA1vlHcx3u0Bcr/MAqJTDaIFm4uPpg4keoy/OM20neLw05vwbJ
         l/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9M2kb8YIcWOd3tqnteodfbIJJWQEJSa/HP5ZuaSACYQ=;
        b=AvW/jJ+7T0iDfHs4AerJFdblicYED7v4O0TCZDfkP7VQtJ3J+hcL/Sqzb1qskCW6QO
         ir2HikaHkU8sAVTeXUe8RJY9KyOSWhP4jo7NvynpLk+gLjPRVRLYmlb7vueLK6PuQaGr
         yY16UCfxOIqajcTWQqCqx1HXdXtE1U8dw+1nSLijrKRFE9ByDrw3DVarKRV6n60px1vx
         AiYvwtHkPHXt+4XlI0t6canf+HoElQr+tTnU9AZjORSXpfQmlSditI1IKYaCriJZUJGx
         T0inYrtgNb80Rx7lVRJz7rXxVVrdytm0TRcRkGibKBX1uheMYjEdxDiMwrPV57TFWGsU
         dSog==
X-Gm-Message-State: AOAM530d6nG7rhaj+voUrCpH0ItR64R4ur6Je3shNWDjBxKhwPCBOJQU
        Ue1P0ONCwL9ZR4TNaNY142dnKFSbXMS52RJaFo20dK2usbxXHc2b
X-Google-Smtp-Source: ABdhPJwQwE7qb7rImjsHak7FJ6gg5kAkSN7LJke8C0fzht+CdnZypqqh6LeQLqkqMXtRlhxUM80Yewv1dper73cQfO4=
X-Received: by 2002:a17:906:190d:: with SMTP id a13mr10823127eje.330.1617697241797;
 Tue, 06 Apr 2021 01:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com> <20210406070716.168541-5-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-5-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:20:06 +0200
Message-ID: <CAJX1YtaqJjuy0asTop-Fm9ZCeuJ8zjpsZ-O8E0xxAvT17DS9qA@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 04/19] block/rnbd-clt: Remove some arguments
 from rnbd_client_setup_device
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@gmx.com>
>
> Remove them since both sess and idx can be dereferenced from dev. And
> sess is not used in the function.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
> Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
