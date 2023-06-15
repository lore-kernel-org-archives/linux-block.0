Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29418EB64DC
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 07:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbjFOHWv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 03:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244787AbjFOHWS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 03:22:18 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444C112E;
        Thu, 15 Jun 2023 00:21:45 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-46e9af5f2dfso503911e0c.3;
        Thu, 15 Jun 2023 00:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686813704; x=1689405704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn71mLncpr2dBLJLDyOG+/F3PHayIULue0eyh7Gy5ps=;
        b=MnMpCGrAh3xN9tWVNH84mMW9kkMhTvBrpnINp+CA25BqdEKYPx4lgkCyBJrxVrdqby
         XW4Iy0198zXiHR7UpTzy/6PI6PL16O2utythSZgWnMsDy7wd4IuEcpAKGL/zK/dzn1/1
         63QRADvrEiHc/TlELNgiBjv5m9wS4LzZF/MSgmPWE0HsyM6aasPTEmvDdJxDzEm5OS21
         HuH4uZEpL0DRl5/1Z28Cyfdk0e1XptyvrZR3pgGACak/aWUu8uyz7TALqnTaVuAYar26
         IY1yA2zld2k+kxw9+PcGGrZ2L8HNKrlTFPnYRao4agWrL3/m4e7yakkqSPmEFBAaEXcM
         hIMg==
X-Gm-Message-State: AC+VfDyVyQXSOpEVvssk0Sw7Uzwb0uNeOu32iFZpf04F+UmG1rgbnaqI
        T4H2i3OB2tAlYv6NNiI226LHYouZoHfFCA==
X-Google-Smtp-Source: ACHHUZ4zTgrcIQrQ03XlF1ED8ngRlTxDQyyimeUTDvmpKWzSyht9WMmVNM8ZjtiJKHhk0CSqpHYOTw==
X-Received: by 2002:a1f:3dcf:0:b0:463:57aa:96b9 with SMTP id k198-20020a1f3dcf000000b0046357aa96b9mr8711241vka.8.1686813704080;
        Thu, 15 Jun 2023 00:21:44 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id p12-20020a1fa60c000000b0045a62e76581sm2535090vke.45.2023.06.15.00.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:21:43 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-78a3e1ed1deso1314167241.1;
        Thu, 15 Jun 2023 00:21:43 -0700 (PDT)
X-Received: by 2002:a05:6102:3168:b0:43f:4779:49cf with SMTP id
 l8-20020a056102316800b0043f477949cfmr3074669vsm.5.1686813703273; Thu, 15 Jun
 2023 00:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230615030837.8518-1-schmitzmic@gmail.com> <20230615030837.8518-3-schmitzmic@gmail.com>
 <20230615041742.GA4426@lst.de> <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com>
 <20230615055349.GA5544@lst.de>
In-Reply-To: <20230615055349.GA5544@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Jun 2023 09:21:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyQnKUaNtxYjqpxXovFKNPmhQDeCXX=exrqtgOfSFUjw@mail.gmail.com>
Message-ID: <CAMuHMdWyQnKUaNtxYjqpxXovFKNPmhQDeCXX=exrqtgOfSFUjw@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in affs_hardblocks.h
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-m68k@vger.kernel.org, martin@lichtvoll.de,
        fthain@linux-m68k.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael,

Thanks for your patch!

On Thu, Jun 15, 2023 at 7:53 AM Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Jun 15, 2023 at 04:50:45PM +1200, Michael Schmitz wrote:
> >> And as far as I can tell everything that is a __u32 here should
> >> be an __be32 because it is a big endian on-disk format.  Why
> >> would you change only a single field?
> >
> > Because that's all I needed, and wanted to avoid excess patch churn. Plus
> > (appeal to authority here :-)) it's in keeping with what Al Viro did when
> > the __be32 annotations were first added.
> >
> > I can change all __u32 to __be32 and drop the comment if that's preferred.
>
> That would be great!

I totally agree with Christoph.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
