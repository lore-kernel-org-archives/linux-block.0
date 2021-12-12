Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB282C433EF
	for <linux-block@archiver.kernel.org>; Sun, 12 Dec 2021 10:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhLLKDD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Dec 2021 05:03:03 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:35789 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhLLKDC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Dec 2021 05:03:02 -0500
Received: by mail-ua1-f47.google.com with SMTP id l24so24328556uak.2
        for <linux-block@vger.kernel.org>; Sun, 12 Dec 2021 02:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LgOMohw04LDTgliOMAxTx9ph3HfS1n9dnCmdkzOvyHo=;
        b=gRdw7CcU2vDLCMRnYtggufz+MaV6LGCk5Fh9HM+ZAKcOxMetdsoPBEK8l/eSZHL2X5
         mz22w3ecdcmgjjDF7t1GtCRa4x05xX4zf0WWvxFkyY53gU6BAJlYX35aqNHzSiT4zsQW
         HM4nIF12J3dI5onMxEURn4xdCa0ZnxJUtGuGzq66/Cor7yKfA6RjPzbm944CrsiO3D1X
         0jGYCvdW7xx9vjfC/wX8n8NmCGqTQz518OTtcDyXa5AJ1FvIWOp8F96SqyHgMPF/RPqp
         L2XHrKFOO5Ok20wJfkR30qaSAIlpNRkcnvu5YmP0ADSrFX+Lv9LwaV8tbyKp/BkPEupl
         RTZg==
X-Gm-Message-State: AOAM530xPGqbw3EChhEs6/lIbpYUUuB87IS7y2KEr3C/lYkAwKTiL46w
        2b6T1Tagt4gIMwq6eHOmz5GlVWqAQbkh6A==
X-Google-Smtp-Source: ABdhPJxbxRLFUgcZQnpuye6d4lpAC7ESsLQSgG3gKREgZ4yLYN9w9bJs7RzhzRwJSR9wrcVK93Dxcg==
X-Received: by 2002:a05:6102:199:: with SMTP id r25mr22629211vsq.44.1639303381991;
        Sun, 12 Dec 2021 02:03:01 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id u20sm3373443vke.0.2021.12.12.02.03.01
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 02:03:01 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id p2so24236103uad.11
        for <linux-block@vger.kernel.org>; Sun, 12 Dec 2021 02:03:01 -0800 (PST)
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr23586293vsg.57.1639303381121;
 Sun, 12 Dec 2021 02:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20211206070409.2836165-1-hch@lst.de> <4bc1b80c-9c43-ccd6-de78-09f9a1627cc8@kernel.dk>
In-Reply-To: <4bc1b80c-9c43-ccd6-de78-09f9a1627cc8@kernel.dk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 12 Dec 2021 11:02:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0q-W0YSLqjazK32VuE5ZH+eE8H1vbv74o014Dw7wSXg@mail.gmail.com>
Message-ID: <CAMuHMdU0q-W0YSLqjazK32VuE5ZH+eE8H1vbv74o014Dw7wSXg@mail.gmail.com>
Subject: Re: [PATCH] mtd_blkdevs: don't scan partitions for plain mtdblock
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On Fri, Dec 10, 2021 at 7:52 PM Jens Axboe <axboe@kernel.dk> wrote:
> On Mon, Dec 6, 2021 at 12:04 AM Christoph Hellwig <hch@lst.de> wrote:
> > mtdblock / mtdblock_ro set part_bits to 0 and thus nevever scanned
> > partitions.  Restore that behavior by setting the GENHD_FL_NO_PART flag.
> >
> > Fixes: 1ebe2e5f9d68e94c ("block: remove GENHD_FL_EXT_DEVT")
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > @@ -355,9 +355,11 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
> >                                  "%s%c%c", tr->name,
> >                                  'a' - 1 + new->devnum / 26,
> >                                  'a' + new->devnum % 26);
> > -       else
> > +       } else {
> >                 snprintf(gd->disk_name, sizeof(gd->disk_name),
> >                          "%s%d", tr->name, new->devnum);
> > +               gd->flags |= GENHD_FL_NO_PART;
> > +       }
>
> Not sure why I didn't spot this until now, but:
>
> drivers/mtd/mtd_blkdevs.c: In function ‘add_mtd_blktrans_dev’:
> drivers/mtd/mtd_blkdevs.c:362:30: error: ‘GENHD_FL_NO_PART’ undeclared (first use in this function); did you mean ‘GENHD_FL_NO_PART_SCAN’?
>   362 |                 gd->flags |= GENHD_FL_NO_PART;
>       |                              ^~~~~~~~~~~~~~~~
>       |                              GENHD_FL_NO_PART_SCAN
> drivers/mtd/mtd_blkdevs.c:362:30: note: each undeclared identifier is reported only once for each function it appears in
>
> Hmm?
>
> I'm going to revert this one for now, not sure how it could've been
> tested in this form.

Because next-20211130 and later have commit 46e7eac647b34ed4 ("block:
rename GENHD_FL_NO_PART_SCAN to GENHD_FL_NO_PART").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
