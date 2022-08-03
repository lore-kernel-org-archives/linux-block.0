Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4827C19F2C
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 17:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiHCRzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiHCRzM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 13:55:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA63F491C8
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 10:55:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j8so7558666ejx.9
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o87E+SV2UIzAz3s+EsvwV12ye0YHqLyv8nHd4iOPpu8=;
        b=SGF0ncnTouMjq3zBYmCMp779RnZ8PwEnMrbg8ILR8Y4ffIOHZ7wKRsq3MFrGyzMCER
         dGVf4CuBZGuCMufdGhLw5LLS45I5A6+E5YjHEWyL6jMt6Vbny8bA7n6pgjNKhU0iGPyo
         Jk5pMZ83FR6JMEkKGWZzV0RE+v0v2GlXhmm8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o87E+SV2UIzAz3s+EsvwV12ye0YHqLyv8nHd4iOPpu8=;
        b=6ZFLBN3SR75tIKrRMM59FsxTRyK+uGEqPsTQbkPS/GIXOwWqFKgkdtUknag2moAiut
         RFRVf43knbLr7T+XE1g/bO/JjATUmcWFvEF/Vtk3XRyiBilw5u25XIqB0n5J228N6SiS
         vQY57bcEeSKDLmCHvRCweReDlSqEev3NB5kOSTJ1M8yD05xFoKzGccXwORB2JZrThP41
         3MlRn4uZnne3R+5juXAapKUncl6bEGHHY5YU67I9zkS0u+s7RaVSghQT6L50JLAplnHU
         bSkmrNo+9xCjR7CFg67e7X1XSPD0yHDKwxklmFvST0Wmg+llnQfw1+h4/pPPqNB5a/Zu
         jYWg==
X-Gm-Message-State: ACgBeo0/1H2GQ9KdFk9Brdj1QcyGt6rFFMFaCH0PciloERiwzGUmnTWP
        FyVjCSQoe8IgmJfM8RO7V9ivKjmG/rmvZ9HP
X-Google-Smtp-Source: AA6agR7dQsaDkPWzQqbJMGm/DPs+sm0Qo5TtERfnoKxU1tfY0t5ekcNOofmEc9JD7XJxWu+aKaLHuA==
X-Received: by 2002:a17:907:1dcc:b0:730:80c1:fc77 with SMTP id og12-20020a1709071dcc00b0073080c1fc77mr11954875ejc.414.1659549308202;
        Wed, 03 Aug 2022 10:55:08 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id g36-20020a056402322400b0043d4fe7f8e5sm6945027eda.73.2022.08.03.10.55.07
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:55:07 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id l22so22464856wrz.7
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 10:55:07 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr6276905wru.193.1659549307022; Wed, 03
 Aug 2022 10:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <20220803173037.GA20921@lst.de> <CAHk-=wggzgFLY1CgLgBRmmpz6s3ZmktV+-sFfBYWeiiBb0VXsQ@mail.gmail.com>
 <20220803174959.GB21218@lst.de>
In-Reply-To: <20220803174959.GB21218@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 10:54:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjoTqRLnmNVKvtCth7WCtCLXem9y4ZHx2tnsEcK01TToQ@mail.gmail.com>
Message-ID: <CAHk-=wjoTqRLnmNVKvtCth7WCtCLXem9y4ZHx2tnsEcK01TToQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 3, 2022 at 10:50 AM Christoph Hellwig <hch@lst.de> wrote:
> Because so far we've never made a big fuzz about a configuation
> so obscrube that it takes build bot more than a week to find it.

That "obscure" config was a bog-standard "build the code".

It literally happens with "allmodconfig". I found it immediately after pulling.

This is literally why I do full builds after every single pull request
I do - I don't want to have build warnings in my tree.

And I do expect people to make sure that their code has been
sufficiently tested that my smoke-testing doesn't find immediate
problems.

           Linus
