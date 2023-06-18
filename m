Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7721FEB64D8
	for <linux-block@archiver.kernel.org>; Sun, 18 Jun 2023 07:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFRHvn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Jun 2023 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFRHvm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2023 03:51:42 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845FE51;
        Sun, 18 Jun 2023 00:51:40 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5700401acbeso27900317b3.0;
        Sun, 18 Jun 2023 00:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687074699; x=1689666699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXMXyUUSJXR/nTNTa+k3QFOvjzI9dKq9J11YzB0zBbc=;
        b=DCxCDit2X9jblnIQiL8Q1yuZvkbo7/UbqjncYC6Q5XX2PxYGIb9ON4g8rfnaCb59Af
         lxDofc5ROwmlPcpV9tzFr+dbnPAQori3pFn/0N+6STQFUkQkU/nG3ze6KIkC43W04xlv
         WFzMytmCYL272rK5l4E9vNa8AMXBi3qwsKgQRMxLAg8bkd5iyw3SVSGARnhKEwaxiAHd
         ADJU4bLCLLgxLmiMDKym3PchVLVkIban5rL36616gb/aqACdGOcqvxaOeGRqHd75d8tM
         exqlQJ5BiC7xNFSPFBXa9I0g2RoID75j7gn2fGaWvCQi1w/RhnAnXoHdHXANEUc66U51
         KI/Q==
X-Gm-Message-State: AC+VfDz6wYj7aCEb8zGLsUj0gwCw+KXPBEQh6uDA0cRX1Ea1afuU7kcZ
        U03+WiZ5eYKD/fNDiYsik0fOm1PzO/cPuw==
X-Google-Smtp-Source: ACHHUZ7gfC9SiAKuiZVkdGPEIOUbBiWWQzVVNssBR/KT1jM0N6dnRFxrMrm59gO2v3gfW4ajop+EwA==
X-Received: by 2002:a0d:ca0d:0:b0:56d:770:c315 with SMTP id m13-20020a0dca0d000000b0056d0770c315mr6766217ywd.49.1687074699573;
        Sun, 18 Jun 2023 00:51:39 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id b16-20020a0dd910000000b005707f542f62sm953037ywe.25.2023.06.18.00.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 00:51:38 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bd6d9d7da35so2611586276.0;
        Sun, 18 Jun 2023 00:51:38 -0700 (PDT)
X-Received: by 2002:a5b:cb:0:b0:bc7:47a:9861 with SMTP id d11-20020a5b00cb000000b00bc7047a9861mr3316637ybp.51.1687074698581;
 Sun, 18 Jun 2023 00:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230616223616.6002-1-schmitzmic@gmail.com> <20230616223616.6002-3-schmitzmic@gmail.com>
 <CAMuHMdXo+Za3_Bz-PaLhq_oZzEzkN=g5YyDp=vaX7485WuE=Cg@mail.gmail.com> <e29dcf24-367f-4304-9b01-7913e0dcf650@gmail.com>
In-Reply-To: <e29dcf24-367f-4304-9b01-7913e0dcf650@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Jun 2023 09:51:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHNGKP4jFM7CDhFxHWd+SR4GG6Co0PosLCk1qpBV176w@mail.gmail.com>
Message-ID: <CAMuHMdUHNGKP4jFM7CDhFxHWd+SR4GG6Co0PosLCk1qpBV176w@mail.gmail.com>
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

Hi Michael,

On Sun, Jun 18, 2023 at 5:10 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 17.06.2023 um 23:08 schrieb Geert Uytterhoeven:
> > On Sat, Jun 17, 2023 at 12:36 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> The Amiga partition parser module uses signed int for partition sector
> >> address and count, which will overflow for disks larger than 1 TB.
> >>
> >> Use u64 as type for sector address and size to allow using disks up to
> >> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> >> format allows to specify disk sizes up to 2^128 bytes (though native
> >> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
> >> u64 overflow carefully to protect against overflowing sector_t.
> >>
> >> This bug was reported originally in 2012, and the fix was created by
> >> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> >> discussed and reviewed on linux-m68k at that time but never officially
> >> submitted (now resubmitted as patch 1 of this series).
> >>
> >> Patch 3 (this series) adds additional error checking and warning
> >> messages. One of the error checks now makes use of the previously
> >> unused rdb_CylBlocks field, which causes a 'sparse' warning
> >> (cast to restricted __be32).
> >>
> >> Annotate all 32 bit fields in affs_hardblocks.h as __be32, as the
> >> on-disk format of RDB and partition blocks is always big endian.
> >>
> >> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> >> Cc: <stable@vger.kernel.org> # 5.2
> >> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Thanks - now I notice the patch title for this one doesn't fit too well
> anymore.
>
> Would a change of title mess up the common patch tracking tools?

You mean changing one patch subject in v13?
Nah, happens all the time, so the tooling should handle that fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
