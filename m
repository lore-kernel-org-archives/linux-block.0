Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A535C43214
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 10:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4273260FC4
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 10:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhG1KyY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 06:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbhG1KyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 06:54:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC735C0613C1
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 03:54:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r23so2563502lji.3
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y7BSRF2BV2wKYMpkMU6AInonSJrtXWVBGV0wA+UfcSQ=;
        b=HvxZxKORsgd1u77vvKkzSHVmzDZnFgdXGSifvV+HmSIPnClkA6lYo7Qz7nvYlLjejZ
         PK9B0U1dzVIDM4JKLg5sSHucPcc5bP4ZeDpjmSTAFJSiF4x48AfpDxMdOGxhIAJqc77U
         oc7qawDYmcTBtp40SM72ZiIXxtcm1lp5rspVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y7BSRF2BV2wKYMpkMU6AInonSJrtXWVBGV0wA+UfcSQ=;
        b=hhhiMKmvX6FoZyMOOHNu9+jnOoA2c9VnEFgYWRowBrwiZpQS1BLfXIM16Y8aaGpDK/
         v3S4Z9BxnFYHB1ueQ2cmAzgXnmpfmpGiW8fZWOp7PZgB8kkcRpKOZfUEl5fMo57JbHvl
         SIN2s0BrayHwz/NPZVGMdaK4IRZ5Kd0DLYoAGl9OdN1GKGzmVAQHYoGfkQC4dHZhfSFe
         SNxCAPI7P95mwws1e+UiyybVRKzgflSNJt6+p/RUs73G2wE7qZG7HsCK02zy0tlnjn1g
         4BpcBPA+dSbZBjB1p6pt8Gbie6d+IbqUYyMhN72SytCjBnUKZ6LpE4vzZajKXHUC6PlR
         q/Ag==
X-Gm-Message-State: AOAM532wYR88qoaApMILWMLx1vIeqykjVJ9ID+W5qNiPl5bvqYiTn+Jw
        a5a2A+K1fJ/BkQv1BdMjnclVYQ==
X-Google-Smtp-Source: ABdhPJzsNcjtwcC6XUZJ5ZJ1M5kI8nrl9w1bOGQ6hWCdCY07r8K6xPGQ9TuYLQLsRgK+FjENio3Z4w==
X-Received: by 2002:a05:651c:1144:: with SMTP id h4mr18097576ljo.396.1627469659652;
        Wed, 28 Jul 2021 03:54:19 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o1sm555702lfk.298.2021.07.28.03.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:54:19 -0700 (PDT)
Subject: Re: [PATCH 04/64] stddef: Introduce struct_group() helper macro
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Keith Packard <keithpac@amazon.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-5-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <41183a98-bdb9-4ad6-7eab-5a7292a6df84@rasmusvillemoes.dk>
Date:   Wed, 28 Jul 2021 12:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727205855.411487-5-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/07/2021 22.57, Kees Cook wrote:

> In order to have a regular programmatic way to describe a struct
> region that can be used for references and sizing, can be examined for
> bounds checking, avoids forcing the use of intermediate identifiers,
> and avoids polluting the global namespace, introduce the struct_group()
> macro. This macro wraps the member declarations to create an anonymous
> union of an anonymous struct (no intermediate name) and a named struct
> (for references and sizing):
> 
> 	struct foo {
> 		int one;
> 		struct_group(thing,
> 			int two,
> 			int three,
> 		);
> 		int four;
> 	};

That example won't compile, the commas after two and three should be
semicolons.

And your implementation relies on MEMBERS not containing any comma
tokens, but as

  int a, b, c, d;

is a valid way to declare multiple members, consider making MEMBERS
variadic

#define struct_group(NAME, MEMBERS...)

to have it slurp up every subsequent argument and make that work.

> 
> Co-developed-by: Keith Packard <keithpac@amazon.com>
> Signed-off-by: Keith Packard <keithpac@amazon.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/stddef.h | 34 ++++++++++++++++++++++++++++++++++

Bikeshedding a bit, but do we need to add 34 lines that need to be
preprocessed to virtually each and every translation unit [as opposed to
adding a struct_group.h header]? Oh well, you need it for struct
skbuff.h, so it would be pulled in by a lot regardless :(

Rasmus
