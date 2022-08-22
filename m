Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932E4C32792
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 21:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiHVVDn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiHVVDm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 17:03:42 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EB922BC2;
        Mon, 22 Aug 2022 14:03:40 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id w28so8941614qtc.7;
        Mon, 22 Aug 2022 14:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=C4cNXBClYJizPfX9ssw4xC6Z6QwnFOv7GKI9BXZIqcU=;
        b=FvQy+X8OPM97LlQPTeH002e+PjnlBebZYSmQqmpGsp+pPlqqjmR4FuqfNQj3hgrrTn
         l+EPXe4ak+XJa8FQTKEmOt6OzV6e7CNx9xxsK2mPWdElFPJpkBr6wS0kSxkIIgMbAoPn
         IoIDBUyvOvOyHHk+V5yAQgWuajACZcfK0g/ETLiqu1hRIxUSaXDqj56KQlhqcyiDdGnd
         2xSO42cutpCQrUsij0mavn/mnDTLpRqnOg/H0z9tz9sbI0dg5h19dih0JgChoIuKaLzX
         ly70Z61itxi+usY65KtzQ5MiNl12ndqdGZYBsQe5wnE4R+KO/L4iA+0jEWxd0fE9jMD3
         OVdA==
X-Gm-Message-State: ACgBeo0wf54Sc9pW0a3mxbAsz1PU/iJg1+4KCMRtoCtkAPoF4vJj9pg2
        BA+WrHFxSnv852rfG5ttVnxv/fcAVAOzKw==
X-Google-Smtp-Source: AA6agR6SHFLzab9+3k1zPg6NZHULqHLSTEAzpVpNbaKkxSYrTpQDKD4WtZVaF/LtCJ+NJZAPDMLFsQ==
X-Received: by 2002:a05:622a:1ba9:b0:343:786c:3bb1 with SMTP id bp41-20020a05622a1ba900b00343786c3bb1mr16761332qtb.125.1661202219229;
        Mon, 22 Aug 2022 14:03:39 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a455500b006b615cd8c13sm11907885qkp.106.2022.08.22.14.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 14:03:38 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-33365a01f29so329003897b3.2;
        Mon, 22 Aug 2022 14:03:38 -0700 (PDT)
X-Received: by 2002:a25:cbcf:0:b0:695:2d3b:366 with SMTP id
 b198-20020a25cbcf000000b006952d3b0366mr15142659ybg.365.1661202218384; Mon, 22
 Aug 2022 14:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220726045747.4779-1-schmitzmic@gmail.com> <20220726045747.4779-3-schmitzmic@gmail.com>
 <Yt/TQOJQZEhZE+2p@infradead.org> <CAMuHMdWW1=kXC14H6iUFF61sMOnsbfXodKS=mpdNbCtvgvjqKA@mail.gmail.com>
 <81e8bd2a-bb3f-6da0-ed39-b522a6b822be@gmail.com>
In-Reply-To: <81e8bd2a-bb3f-6da0-ed39-b522a6b822be@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Aug 2022 23:03:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU2S820t37cfojnBUumYM9V3ntZJ0AtANE-NSJDkHQLag@mail.gmail.com>
Message-ID: <CAMuHMdU2S820t37cfojnBUumYM9V3ntZJ0AtANE-NSJDkHQLag@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] block: add overflow checks for Amiga partition support
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael,

On Mon, Aug 22, 2022 at 10:38 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 11/08/22 23:40, Geert Uytterhoeven wrote:
> > On Tue, Jul 26, 2022 at 1:43 PM Christoph Hellwig <hch@infradead.org> wrote:
> >> On Tue, Jul 26, 2022 at 04:57:47PM +1200, Michael Schmitz wrote:
> >>> The Amiga partition parser module uses signed int for partition sector
> >>> address and count, which will overflow for disks larger than 1 TB.
> >>>
> >>> Use u64 as type for sector address and size to allow using disks up to
> >>> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> >>> format allows to specify disk sizes up to 2^128 bytes (though native
> >>> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
> >>> u64 overflow carefully to protect against overflowing sector_t.
> >>>
> >>> Bail out if sector addresses overflow 32 bits on kernels without LBD
> >>> support.
> >>>
> >>> This bug was reported originally in 2012, and the fix was created by
> >>> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> >>> discussed and reviewed on linux-m68k at that time but never officially
> >>> submitted (now resubmitted as separate patch).
> >>> This patch adds additional error checking and warning messages.
> >>>
> >>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> >>> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> >>> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> >>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> >>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >>> --- a/block/partitions/amiga.c
> >>> +++ b/block/partitions/amiga.c
> >>>                if (!data) {
> >>> -                     pr_err("Dev %s: unable to read RDB block %d\n",
> >>> -                            state->disk->disk_name, blk);
> >>> +                     pr_err("Dev %s: unable to read RDB block %llu\n",
> >>> +                            state->disk->disk_name, (u64) blk);
> >> No need for the various printk casts, a sector_t is always an
> >> unsigned long long.
> > That is true, as of commit 72deb455b5ec619f
> > ("block: remove CONFIG_LBDAF") in v5.2.
> > Since 4.9, 4.14, and 4.19 are still receiving stable updates, the
> > cast should be re-added when this is backported.
>
> Does this require a note in the commit message, or explicit CC to Greg?

According to [1], you should add

    Cc: <stable@vger.kernel.org> # 5.2

[1] https://docs.kernel.org/process/stable-kernel-rules.html?highlight=prerequisites

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
