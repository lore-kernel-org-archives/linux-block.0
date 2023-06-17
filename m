Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189BBEB64DA
	for <linux-block@archiver.kernel.org>; Sat, 17 Jun 2023 11:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjFQLI5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Jun 2023 07:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjFQLIz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Jun 2023 07:08:55 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784A7212C;
        Sat, 17 Jun 2023 04:08:52 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5701e8f2b79so21389277b3.0;
        Sat, 17 Jun 2023 04:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687000131; x=1689592131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWtixX3Z6V44aeoqqIIxWyopGY/w/u3lW96iqUHBgNM=;
        b=kaU3hsRdAozjSoGR8EAAsMJVlDMeWpXMC2mHPzwB0g/J0Az/3GTH8mOktfP8XuzT+p
         bCtTrTDiUgdl/a2Yj/Aj7xwHL9P/CDW+YrPSx0+7IZ1I09ZmkwVhDUAxqXb3y0lH0kti
         YSdjHNyW4mHnRmXgXX9lbZ0KcuE8CNwtpc7pUic/JNvg8BiXjY09ZoNPZeyI52NHgayd
         L1pPq6nrhPvTu8QLJTuIutOpd0O6IifW3EK9glERwqzptSjgSmN2IxWmoPYKaoCRS5yS
         D+m1PSp3EFxpVwglxhs8Jz+tIlMI6mnrRLqqhZAQ4/TNcr750LBZZO++bhYW2+A2zIQH
         f2Ow==
X-Gm-Message-State: AC+VfDzohN4yllvsoh6ynXSh3FTT2Fbzm/6blFYwMnGxa35Z9EQgCXit
        Mr9D7nDE2FbpbE8BCrz3Qx2bbXt0crVOkA==
X-Google-Smtp-Source: ACHHUZ5n38vgX09upKwlvBP+oVLfgWv42x4mdkLw24WwhcRTs0ffv7Jg9R5nwG5H1BSzDwFXrpeg0w==
X-Received: by 2002:a81:4f54:0:b0:56f:f565:c037 with SMTP id d81-20020a814f54000000b0056ff565c037mr5219067ywb.7.1687000131444;
        Sat, 17 Jun 2023 04:08:51 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id p187-20020a0dffc4000000b005706c3e5dfcsm709395ywf.48.2023.06.17.04.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 04:08:51 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-bd744ffc263so1822127276.3;
        Sat, 17 Jun 2023 04:08:50 -0700 (PDT)
X-Received: by 2002:a25:ae26:0:b0:be5:c78a:e9b5 with SMTP id
 a38-20020a25ae26000000b00be5c78ae9b5mr2319004ybj.47.1687000130521; Sat, 17
 Jun 2023 04:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230616223616.6002-1-schmitzmic@gmail.com> <20230616223616.6002-3-schmitzmic@gmail.com>
In-Reply-To: <20230616223616.6002-3-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 17 Jun 2023 13:08:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXo+Za3_Bz-PaLhq_oZzEzkN=g5YyDp=vaX7485WuE=Cg@mail.gmail.com>
Message-ID: <CAMuHMdXo+Za3_Bz-PaLhq_oZzEzkN=g5YyDp=vaX7485WuE=Cg@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] block: change annotation of rdb_CylBlocks in affs_hardblocks.h
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, hch@lst.de, martin@lichtvoll.de,
        fthain@linux-m68k.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jun 17, 2023 at 12:36 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> The Amiga partition parser module uses signed int for partition sector
> address and count, which will overflow for disks larger than 1 TB.
>
> Use u64 as type for sector address and size to allow using disks up to
> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> format allows to specify disk sizes up to 2^128 bytes (though native
> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
> u64 overflow carefully to protect against overflowing sector_t.
>
> This bug was reported originally in 2012, and the fix was created by
> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> discussed and reviewed on linux-m68k at that time but never officially
> submitted (now resubmitted as patch 1 of this series).
>
> Patch 3 (this series) adds additional error checking and warning
> messages. One of the error checks now makes use of the previously
> unused rdb_CylBlocks field, which causes a 'sparse' warning
> (cast to restricted __be32).
>
> Annotate all 32 bit fields in affs_hardblocks.h as __be32, as the
> on-disk format of RDB and partition blocks is always big endian.
>
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Cc: <stable@vger.kernel.org> # 5.2
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
