Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA30C19F2A
	for <linux-block@archiver.kernel.org>; Thu, 11 Aug 2022 11:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiHKLkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiHKLkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 07:40:35 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39A826ACC;
        Thu, 11 Aug 2022 04:40:32 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id u8so13123271qvv.1;
        Thu, 11 Aug 2022 04:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=m1vcPRXZY9358VOf0RRIxm3up9W1D3tTJDEWIQmiED4=;
        b=1/sBDk78UW0lwBlCan1Dv9POw9QYtg9W2UBdB8AKissjD1LgvbjmrtWWjO0SHj+7qt
         4VJWSizCrSCrP0SmrhyACk2q4sE1RUx1BCFSqHps6OIuF8TX7cueG3CZtAut8TZOQjwj
         xtITyrPhD5GdGhBUJS0VuLdpCKfUMZdhTsBtOQC6UZAPAr0h70w/w8ZOE6qEohDVuX7l
         cH1yNj/qyQCobF+bUfa2iGtXx0SIvDMdSNT1fsF2o/xmLH8gfXwnQw7Y3q15ACKTok0D
         tspJbaUpsud/1KssVq7HjDO4j2xfH2zqF9pPsH9Lcxbj4x804yF1GZZyl90vNljKL2ZK
         VxjQ==
X-Gm-Message-State: ACgBeo3L1SodWqrTg5iuJKCpijW5pCrDA4StWcxCSPCsI7QP8+elnY20
        0K0GP2ruYllPJYQIhbS9neLPL9JzRlGLFgns
X-Google-Smtp-Source: AA6agR6oRlk1uiesoaFZA3edh3bms6Om4cT4gnHFWPI5ricPnE64PPK4tfKtOTNvdYcqdaWb9uKR1w==
X-Received: by 2002:ad4:5cc3:0:b0:474:8dda:dfb6 with SMTP id iu3-20020ad45cc3000000b004748ddadfb6mr27828751qvb.82.1660218031840;
        Thu, 11 Aug 2022 04:40:31 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id fz19-20020a05622a5a9300b00342fbe7f3a2sm1494718qtb.70.2022.08.11.04.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 04:40:30 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-32269d60830so169903817b3.2;
        Thu, 11 Aug 2022 04:40:30 -0700 (PDT)
X-Received: by 2002:a81:f47:0:b0:31f:434b:5ee with SMTP id 68-20020a810f47000000b0031f434b05eemr32968546ywp.383.1660218029924;
 Thu, 11 Aug 2022 04:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220726045747.4779-1-schmitzmic@gmail.com> <20220726045747.4779-3-schmitzmic@gmail.com>
 <Yt/TQOJQZEhZE+2p@infradead.org>
In-Reply-To: <Yt/TQOJQZEhZE+2p@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 13:40:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWW1=kXC14H6iUFF61sMOnsbfXodKS=mpdNbCtvgvjqKA@mail.gmail.com>
Message-ID: <CAMuHMdWW1=kXC14H6iUFF61sMOnsbfXodKS=mpdNbCtvgvjqKA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] block: add overflow checks for Amiga partition support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Tue, Jul 26, 2022 at 1:43 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Jul 26, 2022 at 04:57:47PM +1200, Michael Schmitz wrote:
> > The Amiga partition parser module uses signed int for partition sector
> > address and count, which will overflow for disks larger than 1 TB.
> >
> > Use u64 as type for sector address and size to allow using disks up to
> > 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> > format allows to specify disk sizes up to 2^128 bytes (though native
> > OS limitations reduce this somewhat, to max 2^68 bytes), so check for
> > u64 overflow carefully to protect against overflowing sector_t.
> >
> > Bail out if sector addresses overflow 32 bits on kernels without LBD
> > support.
> >
> > This bug was reported originally in 2012, and the fix was created by
> > the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> > discussed and reviewed on linux-m68k at that time but never officially
> > submitted (now resubmitted as separate patch).
> > This patch adds additional error checking and warning messages.
> >
> > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> > Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> > Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> > Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > --- a/block/partitions/amiga.c
> > +++ b/block/partitions/amiga.c

> >               if (!data) {
> > -                     pr_err("Dev %s: unable to read RDB block %d\n",
> > -                            state->disk->disk_name, blk);
> > +                     pr_err("Dev %s: unable to read RDB block %llu\n",
> > +                            state->disk->disk_name, (u64) blk);
>
> No need for the various printk casts, a sector_t is always an
> unsigned long long.

That is true, as of commit 72deb455b5ec619f
("block: remove CONFIG_LBDAF") in v5.2.
Since 4.9, 4.14, and 4.19 are still receiving stable updates, the
cast should be re-added when this is backported.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
