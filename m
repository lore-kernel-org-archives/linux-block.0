Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DADDEB64DB
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 07:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbjFPH3R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 03:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFPH3L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 03:29:11 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072BC1993;
        Fri, 16 Jun 2023 00:29:10 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-75d4a4cf24aso45413185a.1;
        Fri, 16 Jun 2023 00:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686900549; x=1689492549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7y8yJPq+FD0bHdZzb2ZE3rX0uq1K5Mdo2D9q9KpkJAQ=;
        b=JfdFPHpZCT9OhbrNIJLW0M5ZroPStyVkcqCp0psgFIWbjpwL7tI0btHCBoDiaPt8UV
         8vQkXxOR3s5loZE5H+OGkaRRIlUZ0dnwbDbvnHMKwmQWvU8DcjUrwpiFBoGRADTrBV+P
         TE9swNKGp0bJU7QUAaiGwgVc0mzvvhoZ9gCXCIe8R2dOeoCCugbNBpPiWnVTTlKAi3A6
         pWm8HJFGV4bfWRvVEFk0QKD18dI/2aW1i4a+LHryRlS9Q3kG36zg+CozBfta/ljvtqXB
         M5hhCBOlC6RqtbvCe4GbcCfVWO1gtLOWaR0Bo7xWWlIJ5Co+GmvXRjhSVFMVdROzBSpN
         DWZA==
X-Gm-Message-State: AC+VfDy4b+oOBRxDUS82CXlyWRvVsQQMLXfobVf3XHCcw/uCqgRSPnvD
        dudu8jEiHhFkZXEvU/C/VnCvxbsLve2tAA==
X-Google-Smtp-Source: ACHHUZ6UeEPMfRmlWiH7jCoKvVbSU2r73elnjZnHy0sYWy/2Tt8GmDUMcUBbGRL1qKUmlJT5fSLX0Q==
X-Received: by 2002:ac8:58d2:0:b0:3f9:a65b:bc69 with SMTP id u18-20020ac858d2000000b003f9a65bbc69mr1836595qta.61.1686900548760;
        Fri, 16 Jun 2023 00:29:08 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id bt15-20020ac8690f000000b003f3937c16c4sm7192206qtb.5.2023.06.16.00.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:29:08 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3fddc2f1d03so1134201cf.3;
        Fri, 16 Jun 2023 00:29:08 -0700 (PDT)
X-Received: by 2002:a05:622a:24a:b0:3fd:db88:b0e9 with SMTP id
 c10-20020a05622a024a00b003fddb88b0e9mr547418qtx.6.1686900548065; Fri, 16 Jun
 2023 00:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230615030837.8518-1-schmitzmic@gmail.com> <20230615030837.8518-3-schmitzmic@gmail.com>
 <20230615041742.GA4426@lst.de> <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com>
 <20230615055349.GA5544@lst.de> <CAMuHMdWyQnKUaNtxYjqpxXovFKNPmhQDeCXX=exrqtgOfSFUjw@mail.gmail.com>
 <69ecfff9-0f18-abe7-aa97-3ec60cf53f13@gmail.com> <20230616054847.GB28499@lst.de>
 <80ffb46c-b560-7c4e-0200-f9a91350c000@gmail.com>
In-Reply-To: <80ffb46c-b560-7c4e-0200-f9a91350c000@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Jun 2023 09:28:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpxK2HXJ0s_Fa--sMOAjR8Qt4EVQL2UC7UynMCA6q+1g@mail.gmail.com>
Message-ID: <CAMuHMdXpxK2HXJ0s_Fa--sMOAjR8Qt4EVQL2UC7UynMCA6q+1g@mail.gmail.com>
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

On Fri, Jun 16, 2023 at 9:21 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 16.06.2023 um 17:48 schrieb Christoph Hellwig:
> > On Fri, Jun 16, 2023 at 07:53:11AM +1200, Michael Schmitz wrote:
> >> Thanks - now there's two __s32 fields in that header - one checksum each
> >> for RDB and PB. No one has so far seen the need for a 'signed big endian 32
> >> bit' type, and I'd rather avoid adding one to types.h. I'll leave those as
> >> they are (with the tacit understanding that they are equally meant to be
> >> big endian).
> >
> > We have those in a few other pleases and store them as __be32 as well.  The
> > (implicit) cast to s32 will make them signed again.
>
> Where's that cast to s32 hidden? I've only seen
>
> #define __be32_to_cpu(x) ((__force __u32)(__be32)(x))
>
> which would make the checksums unsigned if __be32 was used.
>
> Whether the checksum code uses signed or unsigned math would require
> inspection of the Amiga partitioning tool source which I don't have, so
> I've kept __s32 to be safe.

Unsurprisingly, block/partitions/amiga.c:checksum_block() calculates
a checksum over __be32 words.  The actual signedness of the checksum
field doesn't matter much[*], as using two-complement numbers, you can
just assign a signed value to an unsigned field.
It should definitely be __be32.

[*] I guess it was made signed because the procedure to update the
check goes like this:
  1. set checksum field to zero,
  2. calculate sum,
  3. store negated sum in checksum field.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
