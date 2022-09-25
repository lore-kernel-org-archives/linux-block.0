Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC249C6FA83
	for <linux-block@archiver.kernel.org>; Sun, 25 Sep 2022 08:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiIYImo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Sep 2022 04:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIYImn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Sep 2022 04:42:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC55371BB
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 01:42:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id 13so8480131ejn.3
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cJUTL4HFF5c6MSiqmCutUWIA1DXPBObRTJgFy/60YBM=;
        b=gdfFkPoy+sjSzheO281CK+V0J0F4BgcjkxUH6izI9WtHt54gKtFGD7QgkaysgXdJkC
         4auBIYerNe8lJFh9zx5/muqLer5XYM1/ECf05uNTE8yOC/v5z/DJIwsRgubImL/kz/i8
         B0EvknVrWdyZy3PIoAa+KrBbRwdwE9a2nyLFsS8Uxz2MLrNdgI28dj76lURnEDQftPiD
         2aGOzk7BDzThKsW0RnRZkUKnrhF1Pg86t7INqfzArAjlBLMvyiUR44naqq8ooM6kFUQG
         GBL8OyDSh9KT5NoPJch78q76RUHNcvBocR+HgHlGDHFZ1aVVB4chXYOasGhMe5bs36wm
         +wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cJUTL4HFF5c6MSiqmCutUWIA1DXPBObRTJgFy/60YBM=;
        b=Xs3Lm3CLE4PC9SBfzUEFv/hPPfPK6sDlm4o/H34P6VaC95xvAC0m8/ubGvW99lWEbr
         BoVTUCzj4/3tos2UqqT6ztRJuooQLiXlN292jgMN9GLb22UbKIP05Xmh3X28qbB7cgBZ
         mRfexgUZROMSE+DfyeHMfbu+1GcmTuCm2TNrxKGkN74L5V2Ov+IfAMxYotnMvW7h31dL
         p2+JBiQAWAPN1WWpdYMX3Pvo2R6L5AcfNfamCZN4YW91DS84rMg0lSFUglE0oTD8knBq
         nhK86PBdsYwufCuV+Xz1O1iu2MsyXPHUGy54zqRjuFrTSSZDrfKplc8wuSu42/eKzHsH
         so6Q==
X-Gm-Message-State: ACrzQf1JNX7gCG6XUOdbU7yXSZDA5Ld51VATQSqqLAwnl/gWevgJYqmY
        US5IK1ulqzq5oS+u+sFktlDtEzqnDEoAFazZEBoirwYsvYhoNQ==
X-Google-Smtp-Source: AMsMyM6OSFYOXBsFVMQ90Gb6cn0rRSQK1qfOqXfYNLMwlitCbmsao98abUnUIKfKNY/OUc8jwBDe10fcOBpM0McBlj8=
X-Received: by 2002:a17:906:da86:b0:740:7120:c6e6 with SMTP id
 xh6-20020a170906da8600b007407120c6e6mr13805697ejb.44.1664095360679; Sun, 25
 Sep 2022 01:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtt-921LH=fcVtaOkzfb-sA-0Qht4hrNhmGS5f_S0P+cg@mail.gmail.com>
 <YyytP71y2GosUOhr@fedora>
In-Reply-To: <YyytP71y2GosUOhr@fedora>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 25 Sep 2022 14:12:29 +0530
Message-ID: <CA+G9fYtLwCiJeVO1UeJSU5iTrz9MmX3VWZZVFZxFPeSyGWT98g@mail.gmail.com>
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual
 address 00000010 - PC is at mempool_alloc
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 23 Sept 2022 at 00:15, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Sep 21, 2022 at 08:11:42PM +0530, Naresh Kamboju wrote:
> > [Please ignore this email if it is already reported]
> > Following kernel crash noticed on qemu-arm with linked config [1] running the
> > Linux next-20220916 to next-20220921.
>
> Does this mean the test passed with next-20220916 and failed with
> next-20220921?

I mean to say like this,
GOOD: next-20220914
BAD:  next-20220916

- Naresh
