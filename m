Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF44C43217
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 20:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiEWUQ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiEWUQQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 16:16:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C91FCC5
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 13:16:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i27so31127476ejd.9
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EA3FIBNNDoj02Qd5UyhoYbcYuhDKnQDkuCoIXsHPGWY=;
        b=Nfn7ww9o3d0ammGcjT3qgI9xxfAGwUBtkBtWkmxyujjnhZ5owJd6qJrN9TUYSY4B0G
         C8sS56B0FTy0zY8TGSBy7mCZaTgAYNDgfE2spXBFYauQ0VIko+BXGY6hGxZXyllmvji6
         JZ9lWCVYiTDJz49RoARM4qI73Jd0TIJVA2Yow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EA3FIBNNDoj02Qd5UyhoYbcYuhDKnQDkuCoIXsHPGWY=;
        b=oo7y/aa/duHDlFXwlN0o3v2YOITjjVnL3MkfRTp8e/sCNUTBy5K72UalxEV7zPmvpa
         WWoELKOtTpK5MXwiw6eI+I6Q9gm6sGFNFWLKojsCjpW1f6jwmpawO9NAs9yTDCn4Ghsf
         b32cUxdnZIIiwOqQ+KZaJdnnOo8wVKqqEjEAOwVfJtvlR2/OuRWjaCyD5PhTaewjInEY
         RlAOdG0t361hknr1xKvmcVCMS2i7F5lAdMUiW2H+gi6mNoKW1Zs/cP+zWhCEaOVx2cBs
         IetELaafzIZ6bMBeQR91yODGWJMY1PBj/cauND863LI8o4wLh6VBrAsU4SBGSV+hNKn6
         bV+g==
X-Gm-Message-State: AOAM533zfhz0/WPPsO298xvDUHetSrSGY5zAINVrK/TYc9FQ/uBxLRxe
        6SldD0r3rCx3uJUoXR9Oddd0xZ4oqRmzGr6H3Os=
X-Google-Smtp-Source: ABdhPJz1M+GDgLgeMlWXtBf0TVJlvhEvurL1poHK9PWOUD0HS/TMgiPdam/eoR8z8lJinV+vifeLNg==
X-Received: by 2002:a17:907:c21:b0:6fe:e94b:3a52 with SMTP id ga33-20020a1709070c2100b006fee94b3a52mr5134515ejc.171.1653336973033;
        Mon, 23 May 2022 13:16:13 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id md17-20020a170906ae9100b006feaf472637sm3986713ejb.53.2022.05.23.13.16.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 13:16:12 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id t13so3730975wrg.9
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 13:16:12 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr14025325wrs.274.1653336971796; Mon, 23
 May 2022 13:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
In-Reply-To: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 May 2022 13:15:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfi3FE3O7KrziqPbyGvAmNFas3xxLz2O+ttzBkCOQmfw@mail.gmail.com>
Message-ID: <CAHk-=whfi3FE3O7KrziqPbyGvAmNFas3xxLz2O+ttzBkCOQmfw@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring passthrough support
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 22, 2022 at 2:26 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> This will cause a merge conflict as well, with the provided buffer
> change from the core branch, and adding CQE32 support for NOP in this
> branch.

Ugh, that really hits home how ugly this CQE32 support was.

Dammit, it shouldn't have been done this way. That io_nop() code is
disgusting, and how it wants that separate "with extra info" case is
just nasty.

I've pulled this, but with some swearing. That whole "extra1" and
"extra2" is ugly as hell, and just the naming shows that it has no
sane semantics, much less documentation.

And the way it's randomly hidden in 'struct io_nop' *and* then a union
with that hash_node is just disgusting beyond words. Why do you need
both fields when you just copy one to the other at cmd start and then
back at cmd end?

I must be missing something, but that it is incredibly ugly is clear.

                 Linus
