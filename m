Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B2AC04AA9
	for <linux-block@archiver.kernel.org>; Wed, 20 Sep 2023 15:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjITPhC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbjITPhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Sep 2023 11:37:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C24E0
        for <linux-block@vger.kernel.org>; Wed, 20 Sep 2023 08:36:53 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c0d6fef60cso4558695a34.1
        for <linux-block@vger.kernel.org>; Wed, 20 Sep 2023 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224212; x=1695829012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEqOVsBfHNygg8CIdhGnCqNhF4RLjlnuHSz1CJHC5ok=;
        b=gfb0x5RPkwjsO6E5uQGEJ/gGgzoFgjRyRWwj4KbQ3uFBen15i19BWd6Hrpng8HZlTu
         /9PCwEkCxTCpugQjy6PI6hyIqUskzUJd0rbdnxuqVjGh2f+FEWI6RCfezgFEcrCVcmIv
         OoY4b/9XSeS+wXIWkwpG/laIX49C69xcsXXWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224212; x=1695829012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEqOVsBfHNygg8CIdhGnCqNhF4RLjlnuHSz1CJHC5ok=;
        b=rmq4jYxYxfEtHkZb8PLttxs3geGl6vPZnc4ptVs4CCCcl9OkoiGvzeJW6BcXmadEnQ
         hp1Pr/edmHTEqjsrm3xGAQH8kQiULcJM6tbBcO48ZN2j2YIxVaRDe9gRzMHu6MsHaGzv
         M5xdgZCcv4A6mp6czlCX+1iroQfOK57l+e8VEtvuDyTsdSAZxn8XihzfXnPX2zzv9G6P
         X87aNU9eo/7lOXM/oJ65e4uohBOjuVte+FTee1LOSIbl+E8pEueSfignTFQGuctYeGWf
         ONNpXxgfIa71LL/NqqMgmeWJJFUcxJ9Gzsk4XxMBCRzX0kE2+eEKVReZPaYZinRLIAOu
         HvMQ==
X-Gm-Message-State: AOJu0YwJMPfpoorKG+eEuDVsn/sSPedJqQfSSCtJYPoivVPJmqxFSJiR
        xl01pB2Q7UQyRtkk4jvIPNxOkA==
X-Google-Smtp-Source: AGHT+IGWSCopskarNhSyAkg0IaQsmJYsTyHTBcKn23oo3w5SI0EhhW3Si5DpZmqWvoMoEIJfEqxaPA==
X-Received: by 2002:a05:6358:52cb:b0:142:dfc2:a441 with SMTP id z11-20020a05635852cb00b00142dfc2a441mr4203742rwz.8.1695224212579;
        Wed, 20 Sep 2023 08:36:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j24-20020a633c18000000b00565009a97f0sm1133706pga.17.2023.09.20.08.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:36:52 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:36:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>
Subject: Re: [PATCH v2] aoe: replace strncpy with strscpy
Message-ID: <202309200836.372F9757@keescook>
References: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 19, 2023 at 05:27:45AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `aoe_iflist` is expected to be NUL-terminated which is evident by its
> use with string apis later on like `strspn`:
> | 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);
> 
> It also seems `aoe_iflist` does not need to be NUL-padded which means
> `strscpy` [2] is a suitable replacement due to the fact that it
> guarantees NUL-termination on the destination buffer while not
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Xu Panda <xu.panda@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks right. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
