Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FC9C433E0
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391DC64F73
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhCLUWU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbhCLUVz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 15:21:55 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FFEC061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 12:21:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso11608124pjb.4
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 12:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3li0CQoM1DKxd4umvJ/g/99kyUUfysNkRC1QzROPL1U=;
        b=2KCdiaViu/2/3I7wu5hMrfydbImj7wzHWqnydySPD1iKu8LlxSa2PgADPSkoLsQ/7L
         RhAYHmR2J1RdPexNY6D+8cFlJWXPzenryODNGABbPUa8xaVnllZ1351W2X3kZPpbD9LR
         NcuhiWKE8W8OHbr3JGjtEONOIiIvbgYCqzUuAhVz5JVLi5ghIiEivWpD08Km2PbQ8sg3
         YY1CTnL4zATFgbzMJIskxJzj80pEzci2YRE+2Y3y3qmU4POlhXWI3f4r2wIbl4kwY0sp
         fIYNSDCiKGhNPw1gw2DTgnV0ECZS8Zjyd1BhjNjLhDlmdLJUupjEJAdlwIjMLnPEwIWX
         P2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3li0CQoM1DKxd4umvJ/g/99kyUUfysNkRC1QzROPL1U=;
        b=Y9L2K5755Oy0+eKIo7kTAgp12ZDkGFuSiA4DogX9zLHRiYyCC+GfsyyNuZp8Z6yJq0
         ze+U6fH74s20JzAigyGUVid+gHoDzkS/q0hjlbH70VXy8QnoYHA8lJQhpK5uVQLJa+OQ
         r8W9SItKeFSp3j6mFME3aj50/Fdg3uAzrlXoN27i89dVT75JcbzuyShmnx9CuQUvsRWz
         jvp6/lDy+G3lsDi6Fxurua/y5ZuxAK6iTbpWKaaxTz9pUlSDLt1Od4TWP4itnvinas1U
         ilBYBJssBSe3WgI75IJUVmn6OP/RUrczMypZLSLozb2guQZf+XGGbGRRxu0bDVfE44Gb
         NIMQ==
X-Gm-Message-State: AOAM533hclpYsCiiDyiQ60GXBopILjpNSQiPl8cOCV2oJCYW8XFszqhP
        0yZF17kIXuCN3WKLa61RbZlbhCDse0diKphe
X-Google-Smtp-Source: ABdhPJwj9MMNRxoYpRJ5PNpNuyHLAUICiKtG9oIFhMWlUOX+FxlWhfewgsqtJqun2ekuV/5wsw038w==
X-Received: by 2002:a17:90a:df85:: with SMTP id p5mr42910pjv.204.1615580514096;
        Fri, 12 Mar 2021 12:21:54 -0800 (PST)
Received: from ?IPv6:2600:380:b46b:1540:2a49:5dda:db8:a2f8? ([2600:380:b46b:1540:2a49:5dda:db8:a2f8])
        by smtp.gmail.com with ESMTPSA id d16sm5586541pgb.12.2021.03.12.12.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 12:21:53 -0800 (PST)
Subject: Re: [GIT PULL] Block fixes for 5.12-rc3
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <fc1d6ba8-9245-dced-6a64-eaf7baf69be7@kernel.dk>
Message-ID: <76c62d95-9838-8bc9-1980-8729b0e67da7@kernel.dk>
Date:   Fri, 12 Mar 2021 13:21:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fc1d6ba8-9245-dced-6a64-eaf7baf69be7@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/21 12:48 PM, Jens Axboe wrote:
> Hi Linus,
> 
> Mostly just random fixes all over the map. Only odd-one-out change is
> finally getting the rename of BIO_MAX_PAGES to BIO_MAX_VECS done. This
> should've been done with the multipage bvec change, but it's been left.
> Do it now to avoid hassles around changes piling up for the next merge
> window.

The changelog was correct in this one, but it was the wrong pull request
attached (the one from last week).

I'm going to resend it.

-- 
Jens Axboe

