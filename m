Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F78FC4361A
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5554206CB
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 17:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgLCRsM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 12:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgLCRsK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 12:48:10 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A868C061A4E
        for <linux-block@vger.kernel.org>; Thu,  3 Dec 2020 09:47:24 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so3496423ljj.6
        for <linux-block@vger.kernel.org>; Thu, 03 Dec 2020 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+/34BW6LzHF6hZqDfON22QZfOwULMcJz5mgoFc2n/kU=;
        b=MsWsYuKNvKACORS8E1s6T8larMX8mUsiP9GStx4+PH4R/8GKanJ7dmyxFt2sOejpvg
         lJYFBzL5o8xNmk+X0wFulbuSDXgwNrOaXIagjg37+KIoGO9/xwvWN9Ycq3yYVYbgnQ/Z
         53K8yeK7Vith5UFq1DQvSKASmjvGeDSn3t91g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+/34BW6LzHF6hZqDfON22QZfOwULMcJz5mgoFc2n/kU=;
        b=UYn7oXGK4XT6u45yJ0f7g9DV46yt446VRsMP7ZnpWWsDB82Rxz5U2AdgwuCnp1/cEI
         +2QNs7XYe7DNRD8PecWKfl82mzmHdEQGqjuf5wuPUdZ8qVhgcBvd6l7ylr3ID+9jRUBy
         /OVx9S76QbeXWSTh/c1zh721jBU82FboN/dM4NJolRJ4jzLUmywASrHI1Z7sf3fdL3p5
         sYEQENX9g61v9ueRBDuvjm0wvELTEx/FgfAqDCtNTeB4ta98GDXvaJVEz2K/dUoV5vYz
         Rhd0rfOgRWBJ3m6gvDzgqGR9IdZwJfRkv4K32ZRkwxcQzmUoh+FSWDCcrlagj9xoODSD
         ln1g==
X-Gm-Message-State: AOAM533kj04dvaGJp9hcrh8KcxLlUFOLpR2Vbd57sK0cLU2vzW1TA4fi
        LxPbosK/n4GKZgHnHjG3m4FrbAklK4qbFg==
X-Google-Smtp-Source: ABdhPJxcbYZjOoEbkoC1UDS+8HTSv5WavYkhf+hlYhdmh6Q+nC8cyRsl+8rAtTv8MFrrtnsKQUwpOA==
X-Received: by 2002:a05:651c:1246:: with SMTP id h6mr1738770ljh.187.1607017642079;
        Thu, 03 Dec 2020 09:47:22 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 1sm746106lfq.129.2020.12.03.09.47.20
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:47:21 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id t6so3934616lfl.13
        for <linux-block@vger.kernel.org>; Thu, 03 Dec 2020 09:47:20 -0800 (PST)
X-Received: by 2002:a19:f243:: with SMTP id d3mr1702463lfk.534.1607017640414;
 Thu, 03 Dec 2020 09:47:20 -0800 (PST)
MIME-Version: 1.0
References: <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <20201203064536.GE27350@xsang-OptiPlex-9020>
In-Reply-To: <20201203064536.GE27350@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Dec 2020 09:47:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wif1iGLiqcsx1YdLS4tN01JuH-MV_oem0duHqskhDTY9A@mail.gmail.com>
Message-ID: <CAHk-=wif1iGLiqcsx1YdLS4tN01JuH-MV_oem0duHqskhDTY9A@mail.gmail.com>
Subject: Re: [iov_iter] 9bd0e337c6: will-it-scale.per_process_ops -4.8% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     David Howells <dhowells@redhat.com>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 2, 2020 at 10:31 PM kernel test robot <oliver.sang@intel.com> w=
rote:
>
> FYI, we noticed a -4.8% regression of will-it-scale.per_process_ops due t=
o commit:

Ok, I guess that's bigger than expected, but the profile data does
show how bad the indirect branches are.

There's both a "direct" cost of them:

>       0.55 =C4=85 14%      +0.3        0.87 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.__x86_retpoline_rax
>       0.12 =C4=85 14%      +0.1        0.19 =C4=85 14%  perf-profile.self=
.cycles-pp.__x86_indirect_thunk_rax
>       0.43 =C4=85 14%      +0.3        0.68 =C4=85 15%  perf-profile.self=
.cycles-pp.__x86_retpoline_rax

The actual retpoline profile costs themselves do not add up to 4%, but
I think that's because the indirect costs are higher, because the
branch mis-predicts will basically make everything run slower for a
while as the OoO engine needs to restart.

So the global cost then shows up in CPU and branch miss stats, where
the IPC goes down (which is the same thing as saying that CPI goes
up):

>  1.741e+08           +42.3%  2.476e+08        perf-stat.i.branch-misses
>       0.74            -3.9%       0.71        perf-stat.overall.ipc
>       1.35            +4.1%       1.41        perf-stat.overall.cpi

which is why it ends up being so costly even if the retpoline overhead
itself is "only" just under 1%.

           Linus
