Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC34C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB57613BE
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhDFIY2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhDFIY2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:24:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A57AC061756
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:24:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ap14so20582113ejc.0
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clBGZIZe4sgCSo3K+9SEqmJRY4RiGFqW9mKysDwJGBc=;
        b=hvyOHrzcUITGY0mGunygF9OIgxJDdgwYjc5Te5/josGQ++xEJZiWQMg0R4vVxlPho8
         IUi7vuOJMkKxZmsQKjQmK+gIUUfXzeZlnDhdk9uT/yYKAUYuPGwACOqEvTpQFP+pXyjQ
         xqXvZaXE19ATaYdwGAe8AS1ZFZhK3ThNtoCwNzvGB3xkG60V4CZSUvCBisp2QsqWl1wY
         wWeoawL4BrbeVXxKabaTjxdf6Bx7lXur/HOjFdDWDdXgpDZMSLesBqypr2bLlkICnNTG
         DKZ6R+MO5fuOfGF8KJjsAWO3uxQELYo0/UZ2J5xLSGMbkuJ4WNVmcwfAKjAkmwZzqJ6G
         DBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clBGZIZe4sgCSo3K+9SEqmJRY4RiGFqW9mKysDwJGBc=;
        b=IfARGRRWvjS1saSA8K2YKB36v91OuJUo6u5asy45+xjduPWXYly5+tP9YwsFD6Qn6s
         9XLTXDZSqJjolwB+xcWSroUxV7+2laQbtroTjiQmIJjU3ahQ7rlV8R7olXH1a1Mswo4M
         poaAiRxAWeuBtiv6qfhlQudMBw3qToeD+x9+LdSmFX5PO2xjWYOs5Qsr32DLTQdIkEnn
         NMxvVa0XvajT6pU9jXyliLHrvUu5koGPAQOnRiv0xr5LokKOt6i5nIDBEx5yHkozKpph
         Ull99LOuPpv77x+qFhlf9gpXkUuqge49XUYNp9aJoHqHWzz3UxoCZcZEWOS+fkSyUrwH
         OKNQ==
X-Gm-Message-State: AOAM533wduuydRv5Fqnn4IWrmXjteBAUrZMaRYgIrQX0yCy4kawDjYbH
        xoubrx62pi+AAaDSSB9H4zbo8A9zh2C2GjHVWhW54IwhZky6ChjN
X-Google-Smtp-Source: ABdhPJwJW+GpRsRr85JTaaKScPttTlGN41rA1wvE4LyxRJagmyi+IikNWNWlsORrIIz4BVyWuOQIs5liRCcnFW3DSY8=
X-Received: by 2002:a17:907:969e:: with SMTP id hd30mr11204049ejc.5.1617697459545;
 Tue, 06 Apr 2021 01:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com> <20210406070716.168541-9-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-9-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:23:43 +0200
Message-ID: <CAJX1YtbZB8cXerBWtALNgs5QEezF2xzvgrThGqj0nTgkrJJ5iw@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 08/19] block/rnbd-clt: Replace {NO_WAIT,WAIT}
 with RTRS_PERMIT_{WAIT,NOWAIT}
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> They are defined with the same value and similar meaning, let's remove
> one of them, then we can remove {WAIT,NOWAIT}.
>
> Also change the type of 'wait' from 'int' to 'enum wait_type' to make
> it clear.
>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
