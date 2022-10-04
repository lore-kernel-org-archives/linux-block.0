Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9026C433FE
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 18:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJDSeL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJDSeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 14:34:09 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A05766117
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 11:34:08 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id c2so1766101qvo.11
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SaIo47SBzdZWv7eviaRdxaNYgNxd6RGP4fIzEd8D8SQ=;
        b=YFV4aiH5nhA2s53TIm2aFzZ0tz9+c58+11edNM9pqQ8cFWbV4guJMzgFCx188E8esE
         t1tgX9GJodxQu0n9lcdjRCNY5d3x1JE38838NzQsZKmcKluNZ+Qi8IKZYUtRXVLUw0Nr
         Adq1jBliMVkLPimrwGduVqbiF5wOZnH1hQ/3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SaIo47SBzdZWv7eviaRdxaNYgNxd6RGP4fIzEd8D8SQ=;
        b=AOE3m0k0d8NqoPhgbkIceSWFe6zARTDRm1dFRcq9jn1UZxPqjy4WojHFth9oqvxNnX
         0XN7vm31AIQDjcBx5o44Ks2KYqY4Kbsklleava2fxHPx6p2KH0aO1Dah6fHARawKvyxu
         oM5rG3HFn4rF4I15JVI5dPv/GF5QkJ72Sph6VwEYL88A6Id6TOS1uyzGfSbtM8VXDYBI
         blq42B1CyLWPDITPaA3/I1MgJuze6sqOIEkYQgdkqduHdJPsyYiurE/soHDu+43ubzON
         bLnaOmI6tgX6PPs93sUYtSNtZLmK0SuaWgREcOadyIW2a3RJCBvgHPkzIRqPj5X9hrH3
         bftg==
X-Gm-Message-State: ACrzQf0TEKHo0fW0kySLPzSpAp0ReEcEzG/lGeNzdE6IeNayrNKmP7jE
        KfTvaqXt/ZnWmkJW8jDrgZH3ktNLZX2Ccg==
X-Google-Smtp-Source: AMsMyM5xZ9+P4TFccMcLV7jwBWy2SsTS+doojmoprEFlIb8c5Ih4gViXwsVYLULbiMneHub0TVi/gg==
X-Received: by 2002:a05:6214:2424:b0:4b1:8736:9d72 with SMTP id gy4-20020a056214242400b004b187369d72mr9997991qvb.8.1664908447417;
        Tue, 04 Oct 2022 11:34:07 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id dt39-20020a05620a47a700b006b949afa980sm15179229qkb.56.2022.10.04.11.34.06
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 11:34:06 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id s9so8900563qkg.4
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 11:34:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4111:b0:6cf:8490:fa7c with SMTP id
 j17-20020a05620a411100b006cf8490fa7cmr17099862qko.667.1664908446089; Tue, 04
 Oct 2022 11:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220926220134.2633692-1-khazhy@google.com> <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
In-Reply-To: <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Tue, 4 Oct 2022 11:33:54 -0700
X-Gmail-Original-Message-ID: <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
Message-ID: <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
Subject: Re: [PATCH] block: allow specifying default iosched in config
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 3, 2022 at 11:12 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> This will allow a configuration to specify bfq or kyber for all single queue
> devices
That's the idea
> , which include SMR HDDs. Since these can only use mq-deadline (or none
> if the user like living dangerously), this default config-based solution is not
> OK in my opinion.
I don't think this is true - elevator_init_mq will call
elevator_get_by_features, not elevator_get_default for SMR hdds (and
other zoned devices), as it sets required_elevator_features.
>
> What is wrong with using a udev rule to set the default disk scheduler ? Most
> distros do that already anyway, so this config may not even be that useful in
> practice. What is the use case here ?
>
>
> --
> Damien Le Moal
> Western Digital Research
>
