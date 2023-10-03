Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03362E8FDC0
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 23:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjJCX6M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjJCX6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 19:58:11 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0810FA9
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 16:58:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c735473d1aso11813115ad.1
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2023 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696377487; x=1696982287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0ejyvO1VmyNmqGZR0peDZ1Ss5kJZ8OUA5dfHpOPqQw=;
        b=csmvCMLpA+Sm01Ahvo1CG8z9n5RWPHkd96+5EslNwuXEQqK/WcEGSK44oKuG67GdI3
         r9n5iKIr2uhmhXRb3050p15JGN6MBDIIV7PqsFaOqN4uNdxIgAeE07DQ4yz9uv8XhNfA
         AeUfwKCpka5UKdu78syLA6h1nLJtN8clrCl6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696377487; x=1696982287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0ejyvO1VmyNmqGZR0peDZ1Ss5kJZ8OUA5dfHpOPqQw=;
        b=cR7U44NSj4eavEgkUJLc9LDFyu2xBrIsvi8niG3dpTT06N68h2K8bmpAeaOLqEJvSl
         uBYHO2EfcqL1rot4a3+f6rgTWl6AyqLASSBxy6lxy615Hmonyl9TcfwYKhupntHrKzdE
         2vZlYCvpqBcGCrZdQNub5lAKF3WT/3zIklgSKE1cDxgymna8F6QjTQyGvVMuVXv1JKA+
         U1EZNMg5RuROrerEqPcu6LyIUXTyCPMDq4seDGLF8sjoX4MvY0NC2kOwXW6osNRU/E/o
         HX8sS0KJu5EQLXIk7+FZsRYxHrRYwwMgTwzs7Tn22bsvnEDV0jA9gDPMoPgcHdd1JDbs
         jIfQ==
X-Gm-Message-State: AOJu0YyjoBMWI+hABwylHEY+pvqBRl6l8xTYevNtna2QQsm0nyQgQpmm
        OsFpT7gptUAJuntPVogAJobW7A==
X-Google-Smtp-Source: AGHT+IECXb9VSq6vwoIn3tL2WBUXitXZEtZMFEEeusPgmWy8lRWL5m7VZnSdjHnAJKpQp+xgxWZ8bQ==
X-Received: by 2002:a17:902:e852:b0:1b8:af7f:6331 with SMTP id t18-20020a170902e85200b001b8af7f6331mr1037553plg.55.1696377487516;
        Tue, 03 Oct 2023 16:58:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b001b567bbe82dsm2207537plg.150.2023.10.03.16.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:58:07 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:58:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Justin Stitt <justinstitt@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>
Subject: Re: [PATCH v2] aoe: replace strncpy with strscpy
Message-ID: <202310031657.79DC1C570F@keescook>
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

Friendly ping on this patch. Jens, do you want to pick this up?

-- 
Kees Cook
