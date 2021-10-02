Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E72C433EF
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA27461B28
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 18:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhJBSI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhJBSI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Oct 2021 14:08:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692CFC0613EC
        for <linux-block@vger.kernel.org>; Sat,  2 Oct 2021 11:06:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so52412870lfu.5
        for <linux-block@vger.kernel.org>; Sat, 02 Oct 2021 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMLAcQ4cugydSzjtdfBtNLfXxAxvZHC1g7Ad+h0pdns=;
        b=gqhewJETbQM7LX5uu0L1u4zuc/COxRiGofITjMap4cvGAEJqHlCRnXuEAZBUe29n+h
         FlnbYd6d1r3hQ78y/+FnuFBZC0Jeti8MivZrJ83kff/qH3LqOcLtYOyz+5KuPCMlFlwK
         Y63Ovzvr4ybFKamkEDnPc0gQf9RwBS8EBoQso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMLAcQ4cugydSzjtdfBtNLfXxAxvZHC1g7Ad+h0pdns=;
        b=5kejTtgPB/tra5lCEdWjK5dabhZvOnxyC2pj5X/X0oYj5mGrw4JokSSYKY1brNa2LU
         Qad/DRbxfvDkpdk/J/RRJ3+ucOzIMRCRJtvJaTjEf9ybFsqmKUAhEHx6kBScMTVGL4ne
         GNTVb1RGmDWUizdyxuCE4P5/DU/NsYQ5B7tZ+vFq0FCJomQ+ZH6iPk1yuQa8G37O+P/Y
         pF+c+bNDSC8J3R78jZS+/EIYCKk2PvtaXFti7fQXgi4QWAgAkiIuFr9DPgpjLscA9gSM
         FlXpeSJA4+P7YsY9w/nHWLKXy9FJEcmXO+1vAVQW5lVZxBFdz9SupcBTtVo9go/0e9QD
         UFXA==
X-Gm-Message-State: AOAM531AVOWvO7bndnohBH1gOyx3jGeo4TF32KxQs049dPkQ/6mnb7zc
        KL5zM/XTkCeg/GioOq5mRPzGSBRFDMBBY0Pe2UI=
X-Google-Smtp-Source: ABdhPJwKJIOghzGdc+My7VTkbQ9xF/JkkIQRhfVEg7VIEcMQQVVWKkSXYlTTfP2K60Ro2MqMXo6fcw==
X-Received: by 2002:ac2:4157:: with SMTP id c23mr4769146lfi.184.1633197999488;
        Sat, 02 Oct 2021 11:06:39 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id s10sm1102805lfc.28.2021.10.02.11.06.38
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 11:06:38 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id i4so52815680lfv.4
        for <linux-block@vger.kernel.org>; Sat, 02 Oct 2021 11:06:38 -0700 (PDT)
X-Received: by 2002:a2e:1510:: with SMTP id s16mr4877861ljd.56.1633197997905;
 Sat, 02 Oct 2021 11:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <0ff68ebd-ae42-6b85-74bb-6ef114c948d0@kernel.dk>
In-Reply-To: <0ff68ebd-ae42-6b85-74bb-6ef114c948d0@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Oct 2021 11:06:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2sX142TVRhhKZ=HgFzatZv2wt8yT=sR7r3Ob-p2d_hA@mail.gmail.com>
Message-ID: <CAHk-=wi2sX142TVRhhKZ=HgFzatZv2wt8yT=sR7r3Ob-p2d_hA@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.15-rc4
To:     Jens Axboe <axboe@kernel.dk>, Aditya Garg <gargaditya08@live.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 1, 2021 at 7:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> - Add a quirk for Apple NVMe controllers, which due to their
>   non-compliance broke due to the introduction of command sequences
>   (Keith)

Pulled.

Did we get confirmation that this fixes the issue for Aditya? I just
remember seeing issues with some of the proposed patches, but I think
there was an additional problem that was specific to the Apple M1, so
I may be confused.

              Linus
