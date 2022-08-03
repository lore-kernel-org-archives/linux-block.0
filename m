Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFB9C19F28
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 17:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiHCRmx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbiHCRmw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 13:42:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F025551428
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 10:42:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id tk8so32735571ejc.7
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=g9TgnJ8HYGXt+3smvmb8gGic1k9yTJ/FR6hHBeRll+I=;
        b=d7fv5OEud+fIoI7jZPdTfriaDILpZeXyrcz5TDeFs0nOKpOCFB4IbgrA+H5CQAj/Be
         YLjxJ59LUriHkao9+8jfvcBp8GV8MRMJ4HAITJVeeTVIlelu0qKT4o+YM0vB/e7Jybgz
         hdq91S2iSheOijvyduJKa1KhYSfOS8/frjWK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=g9TgnJ8HYGXt+3smvmb8gGic1k9yTJ/FR6hHBeRll+I=;
        b=pwjqrJVJfmzAMTcQPwAhpCFo3sVpW/nzaWK4Vv5HrsFRqgS9VwOs/BAQmHXajc8EMK
         aOJ2Qc+o434cQ5SAncSY68PGvny0iw8JE1Atzc4sLLbHuTRz/OkNIXC3t9bgWMm+8FDf
         F6FKD1ZcIweIWDC/asHxj/s4RDb6JbnrpNLB+/Qwhshl9dCHoXGbcVeTrZOvt32pobQF
         Urlm3RVNHqNWXK4dRM62rEBOvJ3y3bAFOcxVCH2oIVukqR61sB4jW4kL2fi2H3nWP7Do
         Fke2ydi+iYnJ7Z5n9K/EG5/l+nZ/DPJWq5OqFPLJlvx5+E9TYKbsbOQGbWVi2agDKNEL
         d32g==
X-Gm-Message-State: ACgBeo2F7xuhPa791YcZexBsVJUopYCr7UHAiXwtE9JfZA8QvAhMynq6
        WW9GoMo135+j0Q6hnITe4/prOak0Lsp9K0wr
X-Google-Smtp-Source: AA6agR6ZGNuiODIYqzvGjOJFof09g/Y2t8QAt83tWpcJl8y/fnUpUQubYVFwu3SudSEDoxSyolOOiQ==
X-Received: by 2002:a17:907:7618:b0:730:869d:43de with SMTP id jx24-20020a170907761800b00730869d43demr11653433ejc.579.1659548569797;
        Wed, 03 Aug 2022 10:42:49 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id i8-20020aa7dd08000000b0043bea0a48d0sm9726033edv.22.2022.08.03.10.42.49
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:42:49 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id v5so9070220wmj.0
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 10:42:49 -0700 (PDT)
X-Received: by 2002:a05:600c:21d7:b0:3a3:2088:bbc6 with SMTP id
 x23-20020a05600c21d700b003a32088bbc6mr3518907wmj.68.1659548568795; Wed, 03
 Aug 2022 10:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com> <20220803173037.GA20921@lst.de>
In-Reply-To: <20220803173037.GA20921@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 10:42:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggzgFLY1CgLgBRmmpz6s3ZmktV+-sFfBYWeiiBb0VXsQ@mail.gmail.com>
Message-ID: <CAHk-=wggzgFLY1CgLgBRmmpz6s3ZmktV+-sFfBYWeiiBb0VXsQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 3, 2022 at 10:30 AM Christoph Hellwig <hch@lst.de> wrote:
>
> So while the complaint that we failed to get it into the same pull
> request is entirely reasonable, the statement that it cannot have
> gotten much testing at all is a bit ridiculous.  It's also not that
> "I does not compile at all", but rather that -Werror makes a useful
> but mostly harmless warning fatal.

Stop this idiocy.

Warnings are fatal. Deal with it. If you think it's ok to have
warnings in your code, go do another project.

The -Werror addition is not new, it's a policy that has been in place
for a decade or so. I just got fed up with people not noticing
warnings and using that as an excuse for their broken code.

The fact is, apparently -Werror _did_ find it, and the people involved
just never bothered to even tell upstream about it, so that two weeks
afterwards I got a TERMINALLY BROKEN pull, request.

Don't make excuses about "it wasn't that broken".

It was broken. Own it.

And something went very very wrong for that breakage to have stayed
around and then being pushed to me.

I want whatever went wrong in that process fixed. Why did you make a
pull request to Jens, and then never notified him about the problems
in it?

                 Linus
