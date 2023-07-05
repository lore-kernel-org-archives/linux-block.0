Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4923EC001B0
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 07:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjGEH2l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 03:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGEH2k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 03:28:40 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923BE197;
        Wed,  5 Jul 2023 00:28:39 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5703d12ab9aso77735077b3.2;
        Wed, 05 Jul 2023 00:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688542118; x=1691134118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoAiNZNIgqbj41AcF+rgOlDOxtEarw6ZwBi600VKp2U=;
        b=Aj5m6T9RHGsqcb3Fvv3VZMZId9bmX9JvLsUXQMhP9BLv85wRRZqmfEDW5gaMtzpGnm
         HmLT0i/uXMKi6R32dEdq2BmDHC2pdv95Xpz1+xTuE0NRXYz+WHHtJchfQ90aER2dmxzl
         rbj92AIphE2LpDIsomV4PYn9xJKsIUC4mia/B5R+Q7Sv2dUi4PqmTxJsyNAIiFDbKi+i
         aciE+NCsTkOueOOpZbXG/PRNQUDeGpt01QTksmpVEDEQAVCfXkc9A9AYzu9x1TQZfPDp
         1RAEVJbMeq6R0zWVxHXMAfXEL9Zf8v4P35fclJoGWxb4tVm0B9sSIgsxtoOtmS1w5qod
         3zqg==
X-Gm-Message-State: ABy/qLa+Bo59mFVYyy7YEjiGqG3+TmLjtIYo8jWw0pcRGi5sherGYMYH
        KXIlqf1E6PqFUOFL56f5CFvQg4IXFiHXBQ==
X-Google-Smtp-Source: APBJJlHO/TOoRxkvI954xQrxqNar3VJwyWXBFev8luExhmYFWrwuJifcqirQuYXxPe3f39OB07kwzA==
X-Received: by 2002:a81:8450:0:b0:568:d63e:dd2c with SMTP id u77-20020a818450000000b00568d63edd2cmr14091002ywf.11.1688542118654;
        Wed, 05 Jul 2023 00:28:38 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id z3-20020a0dd703000000b0055a07c7be39sm6067900ywd.31.2023.07.05.00.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 00:28:38 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-c50c797c31bso3716373276.0;
        Wed, 05 Jul 2023 00:28:38 -0700 (PDT)
X-Received: by 2002:a25:7d83:0:b0:c13:aca0:b713 with SMTP id
 y125-20020a257d83000000b00c13aca0b713mr14221981ybc.1.1688542118078; Wed, 05
 Jul 2023 00:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230620201725.7020-1-schmitzmic@gmail.com> <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
In-Reply-To: <20230704233808.25166-2-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 09:28:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUc-mqHC80euFrXLGGJO3gLW3ywu2aG4MDQi5ED=dWFeQ@mail.gmail.com>
Message-ID: <CAMuHMdUc-mqHC80euFrXLGGJO3gLW3ywu2aG4MDQi5ED=dWFeQ@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 1:38 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
> fails the 'blk>0' test in the partition block loop if a
> value of (signed int) -1 is used to mark the end of the
> partition block list.
>
> This bug was introduced in patch 3 of my prior Amiga partition
> support fixes series, and spotted by Christian Zigotzky when
> testing the latest block updates.
>
> Explicitly cast 'blk' to signed int to allow use of -1 to
> terminate the partition block linked list.
>
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
> Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de

Please drop this line.

> Cc: <stable@vger.kernel.org> # 5.2
> Link: https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Reviewed-by: Martin Steigerwald <martin@lichtvoll.de>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
