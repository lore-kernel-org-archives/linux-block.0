Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F7DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 03:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiEKDmt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiEKDmr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 23:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B8374889E
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 20:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652240565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sefl67FwsXBtmKFEQpUouuXzLQl1QnxCDGfEfEODxe0=;
        b=dNMpPoBBAhsjpySzJnrVMf3pOiuS7KJ0oDljXZcfabIvt3/nCvK8eD0xt0PzDDoSVMjFEI
        z5j2ZbqrHUOmJ7V+t16XgtNj5v4SgfBnLfiO4PHcusubp34LERa6uVb3gWCsowaxDLCDvY
        4DuD69lOzGNaqFfvD1ibvzFkf0L9r1w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-bq7dTUSbPiGkqidj7a478A-1; Tue, 10 May 2022 23:42:43 -0400
X-MC-Unique: bq7dTUSbPiGkqidj7a478A-1
Received: by mail-pl1-f199.google.com with SMTP id l5-20020a170902ec0500b0015cf1cfa4eeso414589pld.17
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 20:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sefl67FwsXBtmKFEQpUouuXzLQl1QnxCDGfEfEODxe0=;
        b=bglEgyMD8E5ZUtqRpvgQNH5666CkCju/LWsLeflHMo6f+anIyjeeYNOohdJjxx78DZ
         D4+lx8f7iY3JxUBSk67bhjlh22HIpgxFqZdYxnl/Pwf9ym67CL29TKOBOvIavzMFurAa
         neR6zKbeXlbV/WqnYrSdGsrTeCj+T9flfVkwmOSIKpN4nZfEekaG2F2UqvhZy5YMu9wB
         2Edm+HvWTbVYtctboZcaP+zTmzE6rWqm2aqDdkKChpNwwmzsslWlturc63jQGiXjJxMm
         S+zbSQ7xgF1hIwDROwKedmIUTiuYtNyQK+o3nIcgQDLGvOEAE3TbP1Pmamwcz/OkEjlN
         zwcQ==
X-Gm-Message-State: AOAM533KzTGO3wDL23Au55I2sWebMY4IMekMORZpBoR8HyrzOtB2QtS/
        DDfIGycbpHOqvzwfKGbT1yo1Yi4EChK6H3vHhWREopxHtk/YUSItDTfYEJBRz1ix7EG8GI0eJaB
        BKJGwuP6MKRa2Ob0Pe3IF0KMsBkMWJutXWVwnNzU=
X-Received: by 2002:a63:184c:0:b0:3c5:fd55:1e9e with SMTP id 12-20020a63184c000000b003c5fd551e9emr18998488pgy.315.1652240562709;
        Tue, 10 May 2022 20:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztazOUgg5olbz82DOxLtma9DpeokrEtTyX/BGQtk04ZFBOeOsGkvV3fknOEohClfRmbAXOmzxPFs84jB1r30Y=
X-Received: by 2002:a63:184c:0:b0:3c5:fd55:1e9e with SMTP id
 12-20020a63184c000000b003c5fd551e9emr18998476pgy.315.1652240562465; Tue, 10
 May 2022 20:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220511030059.205953-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220511030059.205953-1-yangx.jy@fujitsu.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 11 May 2022 11:42:30 +0800
Message-ID: <CAHj4cs96m4OActiqs4DZMq3TBZo2_L3C58q8HibeXh3uY7R6jQ@mail.gmail.com>
Subject: Re: [PATCH blktests] Documentation: Fix typo nvme-trtype -> nvme_trtype
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     osandov@fb.com, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the fix.

Reviewed-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, May 11, 2022 at 11:01 AM Xiao Yang <yangx.jy@fujitsu.com> wrote:
>
> Fixes: 3be78490def5 ("Documentation: add document for nvme-rdma nvmeof-mp srp tests")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  Documentation/running-tests.md | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
> index 713d7ba..586be0b 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -103,12 +103,12 @@ RUN_ZONED_TESTS=1
>  Most of these tests will use the rdma_rxe (soft-RoCE) driver by default. The siw (soft-iWARP) driver is also supported.
>  ```sh
>  To use the rdma_rxe driver:
> -nvme-trtype=rdma ./check nvme/
> +nvme_trtype=rdma ./check nvme/
>  ./check nvmeof-mp/
>  ./check srp/
>
>  To use the siw driver:
> -use_siw=1 nvme-trtype=rdma ./check nvme/
> +use_siw=1 nvme_trtype=rdma ./check nvme/
>  use_siw=1 ./check nvmeof-mp/
>  use_siw=1 ./check srp/
>  ```
> --
> 2.25.4
>
>
>


-- 
Best Regards,
  Yi Zhang

