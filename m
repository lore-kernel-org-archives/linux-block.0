Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF06C433FE
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 17:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJQRXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJQRXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 13:23:16 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E9672686
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 10:23:14 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c23so8131264qtw.8
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+SEO6vfxiud9noRziv9aQrD1AXg6nct4mTi/PkkKZhU=;
        b=TevJIWxJKIujgIiWUkwjTCBogHB6CQC5h2eJkmXP/IYKYG8r3uAm1K+3RIq8ww2yPy
         mIXdAErNaWHHEqLmpFDqiC8aSieuZ4b3MmV6ia5yeZ4q0jIhJB4Kjs4e7hRZN72d1oBv
         6xf6PWfS8p5iy7vJorxHgQ6TYG11QysB8xvs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SEO6vfxiud9noRziv9aQrD1AXg6nct4mTi/PkkKZhU=;
        b=UIioq+1prwYE4nurBsXhnH4rxCPLz1Y+c6DrBSzXJbTsS8RhYz+pvRz5f8/MtqzQhV
         8crhM+/Xm69audm5CugNLK1ZPETV+XZfI7NXwPc5X6/YkszI/+qwMjALUOltFAQWMVxr
         wfbOUEUBZw+n4Vq3Hn9ax0i4qaDquqf9icye4KkESUHLTjhrFyuYAptuciZJMi25bxF2
         nEGT5YJi2VnEjx1CG7BZO8mMOpR+UHQg+o1hHenOHUTdlxo4HaEtz664a4X+fiL0roUo
         U8zjsWGVX6cBDfUzuawMPxQGYn7c6qaK1t2GgBMC5GT1GyytIk8ARKbmDHwYWd0v8hRR
         7kVQ==
X-Gm-Message-State: ACrzQf1CNt+52oL+AiiKa3Ak/rgtAe10D+ZzVD6JMe6uJcn9NAb9bUO9
        5yHm5yB39ofbdbz5ZoC6s8DqCqDx48o+HA==
X-Google-Smtp-Source: AMsMyM5QkhHbAgwZBajwMixoqbOWg5j2aOtW5QtWjoSVkHee3gGdxwWxmtSu+aNDkqahPb5d1Xnl2Q==
X-Received: by 2002:ac8:5bc7:0:b0:39c:c46f:a109 with SMTP id b7-20020ac85bc7000000b0039cc46fa109mr9727659qtb.47.1666027392901;
        Mon, 17 Oct 2022 10:23:12 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id c25-20020ac81119000000b003996aa171b9sm181761qtj.97.2022.10.17.10.23.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 10:23:11 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id a24so8117635qto.10
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 10:23:11 -0700 (PDT)
X-Received: by 2002:a05:622a:58d:b0:39c:d5e3:2346 with SMTP id
 c13-20020a05622a058d00b0039cd5e32346mr9579593qtb.227.1666027390840; Mon, 17
 Oct 2022 10:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220926220134.2633692-1-khazhy@google.com> <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
 <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
 <7e3a521e-acf7-c3a8-a29b-c51874862344@opensource.wdc.com> <CACGdZYKvTLd0g2yBuFX+++XeSa6aapuAwOM7e63zhKgdKFEGEw@mail.gmail.com>
 <Y0PHsxmsWHFYiLPK@infradead.org>
In-Reply-To: <Y0PHsxmsWHFYiLPK@infradead.org>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 17 Oct 2022 10:22:59 -0700
X-Gmail-Original-Message-ID: <CACGdZYKcpHG_bWew_K78CgwDYMQAGfXX+QU4-9PNoV1j2E1a0g@mail.gmail.com>
Message-ID: <CACGdZYKcpHG_bWew_K78CgwDYMQAGfXX+QU4-9PNoV1j2E1a0g@mail.gmail.com>
Subject: Re: [PATCH] block: allow specifying default iosched in config
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 10, 2022 at 12:20 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Oct 04, 2022 at 04:15:20PM -0700, Khazhy Kumykov wrote:
> > The kernel already picks and hardcodes a default scheduler, my
> > thinking is: why not let folks choose? This was allowed in the old
> > block layer since 2005.
>
> You can choose it using CONFIG_CMDLINE.  We can't add a config option
> for every bloody default as that simply does not scale.

Are you referring to elevator=? It looks like that needs to be
re-wired for blk-mq, but seems like a reasonable solution. I'll send a
new patch out.

Thanks,
Khazhy
