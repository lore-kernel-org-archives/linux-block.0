Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988B9C19F2D
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 18:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiHFSKD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHFSKC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 14:10:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB51ADEB7
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 11:10:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id m4so10047637ejr.3
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kjtebnWpuVmRvt/UMpUPrQsoSPrunFHPAFg6ElFU0RU=;
        b=AyZvnlsjZna+Mv+Pc+G2iyBElVMtudd/krRNuQYxPwhWU2NK9J1AAwRRnZsr6dYAIe
         Pyy1CGQDl42xpa5kWP0F+1+UoutOdj8EvGhPXODVFWNKmYRxM7PGa6KDi5LxwxaJ3Njm
         hGv2lAosyQ2bQYFcqNt/PuRoHNsNXn/ofr/qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kjtebnWpuVmRvt/UMpUPrQsoSPrunFHPAFg6ElFU0RU=;
        b=PD620xYUhNrhkYru2qEL2bc1DST3bzPXEN96nKo+PQzZMKi6RoNM7SYzfAUMYmYf6J
         z3xFD+GPpj9h8R746QO7Hb32zM1geGS8dpco+Vho7POElyVSoRbEpvVOEriAOom9z7Ib
         PC7ESwnnAVNFZ3IsaTqQLmKVd+7knubM5MLZV/6XXN2imu1DODKNw7YcVKcX8HxFW2iU
         OvOf0ydGLJdxNIUJvP7Tgs57O3hqUvh9eeoaTQoRt1XSccEgrCAR7Nh+E8/Ewbhv8jfn
         ftoi1ODFqzqTFiEHMHktvSoio3Jo1Ci9juYV0eCNpGAvi6KKhlmsmiI7hyL+opVS8g9y
         hq6w==
X-Gm-Message-State: ACgBeo269Wwon0OHU2NKnkXtCDy01G1J6zxzoGhDSF3lCF3FQrzt1AuG
        SoxFpb/Y4Yx/uM4oKGNL/XQfVAea3xyxWMDV
X-Google-Smtp-Source: AA6agR5RDfjuqfXTCrO2ipo4hk1l8Acok3XkltgXvUnZFhLJfKZM8zGjA3txLAsh2pHUQAXyUUUb+Q==
X-Received: by 2002:a17:907:2c41:b0:730:a07d:c720 with SMTP id hf1-20020a1709072c4100b00730a07dc720mr8938579ejc.102.1659809399887;
        Sat, 06 Aug 2022 11:09:59 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b0072af890f52dsm2861116ejf.88.2022.08.06.11.09.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 11:09:59 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id z17so6506928wrq.4
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 11:09:59 -0700 (PDT)
X-Received: by 2002:a05:6000:178d:b0:222:c7ad:2d9a with SMTP id
 e13-20020a056000178d00b00222c7ad2d9amr112963wrg.274.1659809398767; Sat, 06
 Aug 2022 11:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <YugiaQ1TO+vT1FQ5@redhat.com> <Yu1rOopN++GWylUi@redhat.com>
In-Reply-To: <Yu1rOopN++GWylUi@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Aug 2022 11:09:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5w+Nga81wGmO6aYtcLrn6c_R_-gQrtnKwjzOZczko=A@mail.gmail.com>
Message-ID: <CAHk-=wj5w+Nga81wGmO6aYtcLrn6c_R_-gQrtnKwjzOZczko=A@mail.gmail.com>
Subject: Re: [git pull] Additional device mapper changes for 6.0
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Milan Broz <gmazyland@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 5, 2022 at 12:10 PM Mike Snitzer <snitzer@kernel.org> wrote:
>
> All said: I think it worthwhile to merge these changes for 6.0, rather
> than hold until 6.1, now that we have confidence this _optional_ DM
> verity feature is working as expected. Please be aware there was a
> small linux-next merge fixup needed:
> https://lore.kernel.org/all/20220805125744.475531-1-broonie@kernel.org/T/

Well, more importantly, the verity_target version numbers clash.

I used the newer "{1, 9, 0}" version number, but if you want it to be
"{1, 9, 1}" to show that it's a superset of the previous one, you
should do that yourself.

That said, the best option would be to remove version numbers
entirely. They are a completely broken concept as an ABI, and *never*
work.

Feature bitmasks work. Version numbers don't. Version numbers
fundamentally break when something is backported or any other
non-linearity happens.

Please don't use version numbers for ABI issues. Version numbers are
for human consumption, nothing more, and shouldn't be used for
anything that has semantics.

               Linus
