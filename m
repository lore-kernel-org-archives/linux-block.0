Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A0E728D9
	for <linux-block@archiver.kernel.org>; Fri, 29 Sep 2023 19:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjI2TVX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Sep 2023 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjI2TVU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Sep 2023 15:21:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917FBE7
        for <linux-block@vger.kernel.org>; Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c735473d1aso21514205ad.1
        for <linux-block@vger.kernel.org>; Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015278; x=1696620078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+9SXcyvjGd+Gta4/O6IN/DD1n96uskx63gniN4z8Ko=;
        b=J9o9b/NjYmsjgtuyStYQHP/wbSF1A3ASaehD6RrX2TWAk5QqQJR86JzC+/fQuIUEC5
         8Tf6b0COysH4GrEmrRrOX4+Hu1Su6zAxCWTKs0yDcj1oMxjFdIV65lnWINXGWHr6BSO3
         XYtRwID9EFXsI3hZpKSLgGfuu6vbNT2yeO7E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015278; x=1696620078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+9SXcyvjGd+Gta4/O6IN/DD1n96uskx63gniN4z8Ko=;
        b=DjH99+4BuudrEKFZSbf6ZQMs9kmlXjEJRT1Ed/YA4auHxf2mm5abyLdqr6VuEz0b0t
         dVDZjuRRMXrOpoc0CWeQYa/surffVVHN810zSMT/ATEdlhXp3/mslRjBn+EL5UyOJR6b
         hc8LpiK3o+ROL+qi/JvoIx7ExYUGwjvU2I2xok5xndeQSkkAo8jDigl2QrF3dLMsL+GE
         eya81ZkuZG3nghtLB8UW14JQMI4dzX+P1dZif/LeUHw+nu8sY3vQmedhed6hycNpf1tm
         +G6cV0zBb/qNja5iIDJ9i4r6QoqtlGtbG6Dx8nlIubWVJv4UPgUeKzjPi4s0OLLIKHe1
         uj4A==
X-Gm-Message-State: AOJu0Yz9hoGeUw9nYEvDZ0xHdMT405cNaWZBUSk6aqVKKKUuznHxyD0C
        4BxP65wIITki3mPn7TtINnlEkA==
X-Google-Smtp-Source: AGHT+IEL4QFJkNtYGTd3LQFr4m9MDVzMcU8D/M+Brl5u7rqE/vHdG8ltVoVEVCzLGwOap+25wTol5Q==
X-Received: by 2002:a17:902:bc4a:b0:1c4:486f:5939 with SMTP id t10-20020a170902bc4a00b001c4486f5939mr3964184plz.3.1696015278078;
        Fri, 29 Sep 2023 12:21:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001b54d064a4bsm17218730plg.259.2023.09.29.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drbd: Annotate struct fifo_buffer with __counted_by
Date:   Fri, 29 Sep 2023 12:21:08 -0700
Message-Id: <169601526972.3013632.16591134753215081850.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915200316.never.707-kees@kernel.org>
References: <20230915200316.never.707-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 15 Sep 2023 13:03:16 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct fifo_buffer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] drbd: Annotate struct fifo_buffer with __counted_by
      https://git.kernel.org/kees/c/f246956ca8f3

Take care,

-- 
Kees Cook

