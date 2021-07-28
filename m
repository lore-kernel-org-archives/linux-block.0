Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C7C4320A
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 11:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFF060FDA
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 11:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhG1LUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 07:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhG1LUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 07:20:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84075C061757
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 04:20:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a26so3179875lfr.11
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WRpAt4Qf30VQcI04z59j1Xhna4kVm3ZAFQjWCiFVzII=;
        b=ZITf0JJkY6siA6zuTWx/S+3I3pJ92j2lsEWHCAUrQgybgq2nu7vMyrV5yFzPnr0ASF
         zQnwOwgLaX1f2Ag8AdE3Zoi+yryD69qxehZj3Axp0G1SI8NHWpwdtRD/AWfB8hXTTU+w
         7JIntZBgXB7V3Bx+KAGMmd0eo1ehu7YXfBEGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WRpAt4Qf30VQcI04z59j1Xhna4kVm3ZAFQjWCiFVzII=;
        b=WUyKXjCTr/rdKF+1YrSLfQeXMRJ7leLJFwvOhU2KSvagK1qQHVTtCXz8O9sRABwUtQ
         MSwHIhyo6IMsMP0rmYP/gLA1RQoFxBayrxUD7qJbzYoah41PzYeQv0tRueNpl5vlaN1k
         M/j0+n9/ChGzmznWcjFHP2TxBZXlaB61SANlXQhI0XBIZeO0frrllm9z+53ynwZTQf7d
         l7clPxMfRryvdS56v82F/JYOPuDoiumKS+f32tn6sc+jK5ry6oGZaPSIGuJz7SfqjjRK
         Obwgrq9RN+Kyfmg8N4QRjm+dojTN7e7hRyzYxI6yaVD+HSXQY737LpwfSq7BUBhvo7hj
         /J4A==
X-Gm-Message-State: AOAM531pz/kh09WMPeEVmEUF8xakpCVv+/cET9vtuLNQ/8XKXv1H65f8
        sf5o/gAifNFLhHIAT5fMHeC0xg==
X-Google-Smtp-Source: ABdhPJwtX9cWcqS+T2RXR4asd80U6YfWCrWHQPG0xseFJRRyUcQAZvx3wnyU+2xS6u5f7adx+ZAvkA==
X-Received: by 2002:a19:dc5e:: with SMTP id f30mr20474709lfj.318.1627471200888;
        Wed, 28 Jul 2021 04:20:00 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z4sm564853lfe.274.2021.07.28.04.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 04:20:00 -0700 (PDT)
Subject: Re: [PATCH 34/64] fortify: Detect struct member overflows in memcpy()
 at compile-time
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-35-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d2f9f21c-4d6e-9458-5887-ca5166d07942@rasmusvillemoes.dk>
Date:   Wed, 28 Jul 2021 13:19:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727205855.411487-35-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/07/2021 22.58, Kees Cook wrote:

> At its core, FORTIFY_SOURCE uses the compiler's __builtin_object_size()
> internal[0] to determine the available size at a target address based on
> the compile-time known structure layout details. It operates in two
> modes: outer bounds (0) and inner bounds (1). In mode 0, the size of the
> enclosing structure is used. In mode 1, the size of the specific field
> is used. For example:
> 
> 	struct object {
> 		u16 scalar1;	/* 2 bytes */
> 		char array[6];	/* 6 bytes */
> 		u64 scalar2;	/* 8 bytes */
> 		u32 scalar3;	/* 4 bytes */
> 	} instance;
> 
>
> __builtin_object_size(instance.array, 0) == 18, since the remaining size
> of the enclosing structure starting from "array" is 18 bytes (6 + 8 + 4).

I think the compiler would usually end up making that struct size 24,
with 4 bytes of trailing padding (at least when alignof(u64) is 8). In
that case, does __builtin_object_size(instance.array, 0) actually
evaluate to 18, or to 22? A quick test on x86-64 suggests the latter, so
the memcpy(, , 20) would not be a violation.

Perhaps it's better to base the example on something which doesn't have
potential trailing padding - so either add another 4 byte member, or
also make scalar2 u32.

Rasmus
