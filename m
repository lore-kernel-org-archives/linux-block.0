Return-Path: <SRS0=cVCO=ED=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747DDC56202
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D6820704
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 22:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ins/48je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbgJ1W0j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733094AbgJ1W0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 18:26:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E852C0613D1;
        Wed, 28 Oct 2020 15:26:38 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p7so1212080ioo.6;
        Wed, 28 Oct 2020 15:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sjEb0zN49oaIgAufe8xKhLgOv463zV86NX/WiY9lMDg=;
        b=ins/48je6GCuzC77llgddm1BWOhvZ6uazsomXrcWJwl9hv29UzUQLz9mXKQ1dQrzon
         GTRPslbb9K5uBXJj2gwvYX+LIKUP+0wVC4IstAQucpRuKed0cq8EONeycmWDPlhwGB1P
         wF5W9zuEcjT1HQf0yZ3ppS9KwE2Lm6ac7WmgjRaUw1w09VkIp7Y1g762KEenVNHlaEdY
         IJjf21Eg70oUsTB5yUAcmGAuKzF3LthEaQOfPnivZN5Al7Ipy4sh1Mnf3QN5Et6nEHEw
         U1+u7Xxm+QhJHx4Aof9mQRhKDsCu0wvFwqLML/DN0p20Rw7rdfe1iuITaF2mbdq1Nxqw
         YyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sjEb0zN49oaIgAufe8xKhLgOv463zV86NX/WiY9lMDg=;
        b=sgXRSDcJRqIkARJ9fWdVdop3nGZAKMGBikXV9amHGBmI81nIcm3eoXFBQdUlfTwdAA
         +lFQ6a+LSjFlstBrAksZcBSOoN5bv0fToWwHjPX3hO0b0pASLhjbeNYtRmkDdfClLIPH
         yJSihSD4HmTLAF7ifO7uGRD4CmDcCaSw9zxIylN98VnsERbracm6Thfpjciqi41ViZ14
         EOmMjuS6/GsZHOjSmWpB0Vw9E9VfOA6Q3ctM+2gMyf9Lf4HPvI8I+fLORSgVPPfi1iKy
         pDG9WiEBitBREbyBZ/lnPmhRpenPIjDsaidkFRnTEEFgneNNfI+DnQrZ0buIUd1hObdh
         zj+g==
X-Gm-Message-State: AOAM530J5+gFYiKomVbRPg9ihDcpgxBcqGRDFORwhwzGGBnMJ99MKDIG
        EAiZa0MZdsS9xYiLEgu6IY0UDTVAyfk=
X-Google-Smtp-Source: ABdhPJy/9p8gddGaTW5w39lJapijT3I+Qdeklbh+tEf1vk7pVfid4diusK/CP48SGgLCOD9c8BlcxA==
X-Received: by 2002:a63:1d12:: with SMTP id d18mr618273pgd.314.1603909321194;
        Wed, 28 Oct 2020 11:22:01 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id b67sm276268pfa.151.2020.10.28.11.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:22:00 -0700 (PDT)
Date:   Thu, 29 Oct 2020 03:21:58 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        minchan@kernel.org, ngupta@vflare.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3] zram: break the strict dependency from lzo
Message-ID: <20201028182158.GA128655@google.com>
References: <20201026085141.1179-1-rsalvaterra@gmail.com>
 <20201027012204.GD2412725@google.com>
 <CALjTZvbf4qK6SHEe7OhkTC_o7kaY4oOKQ+kk-D2OUq_ULsYAqQ@mail.gmail.com>
 <20201028101934.GB48825@google.com>
 <CALjTZvaTiAS1vMyrTNvrfy7KOjemy+tW5-hbTy5SHYfsbRE=_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvaTiAS1vMyrTNvrfy7KOjemy+tW5-hbTy5SHYfsbRE=_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On (20/10/28 11:25), Rui Salvaterra wrote:
> > diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> > index fe7a4b7d30cf..f93eed40e155 100644
> > --- a/drivers/block/zram/Kconfig
> > +++ b/drivers/block/zram/Kconfig
> > @@ -2,7 +2,7 @@
> >  config ZRAM
> >         tristate "Compressed RAM block device support"
> >         depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
> > -       select CRYPTO_LZO
> > +       depends on (CRYPTO_LZO || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842 || CRYPTO_ZSTD)
> 
> This reverses the dependency order, as now we have to select a
> supported compression algorithm in order for zram to be visible in the
> block device drivers list.

Right, but well we also need to select ZSMALLOC and CRYPTO for
zram to become visible (the thing that I found out recently is
that you can always check the hidden/blocked items by hitting
'z' in menuconfig).

> This is why I wrote the ZRAM_AUTOSEL_ALGO
> kconfig symbol, which automatically selects lzo as a fallback. If the
> user chooses to select another supported algorithm, he will then be
> allowed to deselect lzo. We thus follow the principle of least
> surprise, IMHO.

OK, makes sense.

	-ss
