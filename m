Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BECEB64DD
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 09:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjGEJIe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjGEJId (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 05:08:33 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B011706;
        Wed,  5 Jul 2023 02:08:32 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-c5c03379a76so1906428276.1;
        Wed, 05 Jul 2023 02:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548111; x=1691140111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+TNnJonIwEoTpka1YO/KDKKK9gHKhOV507pFmzvVvo=;
        b=gAYjz5MryJWAeykZs1fl1yyMyFyI+wRQ6dcNjzxp7RSObvB9WHH9RsHEJTpM7mClEX
         niulX6xvqCg46B2Aluyj/6OaeBNeHq9ipCaxmWaQS8CrG9ItCg6SA/dW7Wtdkdwj4u4r
         Tx7gK16a3aAUkRFrjhJa0eDtyIykEBWsMsBS+N8s52du5DbjS1QQqQnAVHNTuXW6c6pa
         EU0FpCX3bAjAEoZy/iM+dMPBriIUnxVZVtvdD6+ipAjeYWoQ1HlBM+fUKaxnf1TK7RoG
         3NDvxdurBLAxZ5yK+4NHy75Th8SCpUEAysKoibS+5At8o6DNXbMy/7ZUp2ClS+CJlWut
         d2wg==
X-Gm-Message-State: ABy/qLbiLio7X4Swd3MGEHC4iZYZ0JKaDBAYZBGFxDLCI+UwI6P0cMMQ
        A1bnnkYwz9pf/FJhn6HL5jv4lOgto/izEA==
X-Google-Smtp-Source: APBJJlF2cdFQ/RfTXYI9fun9UP6bBacdF2Oe83rK3eciuHwHnRCu8SziRtjj81RzWWJu2Ew1HH9AbA==
X-Received: by 2002:a25:ab65:0:b0:c1b:d362:4b4e with SMTP id u92-20020a25ab65000000b00c1bd3624b4emr14470370ybi.43.1688548110951;
        Wed, 05 Jul 2023 02:08:30 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id q6-20020a258e86000000b00c5cac376dffsm672813ybl.22.2023.07.05.02.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:08:30 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so1402582276.2;
        Wed, 05 Jul 2023 02:08:30 -0700 (PDT)
X-Received: by 2002:a25:d701:0:b0:c19:df8b:68b with SMTP id
 o1-20020a25d701000000b00c19df8b068bmr14361415ybg.47.1688548110559; Wed, 05
 Jul 2023 02:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230620201725.7020-1-schmitzmic@gmail.com> <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com> <CAMuHMdUc-mqHC80euFrXLGGJO3gLW3ywu2aG4MDQi5ED=dWFeQ@mail.gmail.com>
 <06995206-5dc5-8008-ef06-c76389ef0dd8@gmail.com>
In-Reply-To: <06995206-5dc5-8008-ef06-c76389ef0dd8@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 11:08:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVGNB_aZnDHw_wfDTinDk+LKkP1Lx96Cgm0jM6J1WdACQ@mail.gmail.com>
Message-ID: <CAMuHMdVGNB_aZnDHw_wfDTinDk+LKkP1Lx96Cgm0jM6J1WdACQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check patch
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de, hch@lst.de,
        martin@lichtvoll.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael,

On Wed, Jul 5, 2023 at 10:53 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 05.07.2023 um 19:28 schrieb Geert Uytterhoeven:
> > On Wed, Jul 5, 2023 at 1:38 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
> >> fails the 'blk>0' test in the partition block loop if a
> >> value of (signed int) -1 is used to mark the end of the
> >> partition block list.
> >>
> >> This bug was introduced in patch 3 of my prior Amiga partition
> >> support fixes series, and spotted by Christian Zigotzky when
> >> testing the latest block updates.
> >>
> >> Explicitly cast 'blk' to signed int to allow use of -1 to
> >> terminate the partition block linked list.
> >>
> >> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> >> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
> >> Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
> >
> > Please drop this line.
>
> Because it's redundant, as I've also used Link:?

(That, too ;-)

Because the use of the Message-ID: tag in patches is not documented.
IIRC, it might also cause issues when applying, as the downloaded patch
will appear to have two Message-IDs.
I'm not sure the sample git hook in Documentation/maintainer/configure-git.rst
(and all variants the various maintainers are using) handles this correctly.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
