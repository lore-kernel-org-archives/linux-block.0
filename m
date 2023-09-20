Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0574BC04AA9
	for <linux-block@archiver.kernel.org>; Wed, 20 Sep 2023 15:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjITPiT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjITPiT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Sep 2023 11:38:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D6A9
        for <linux-block@vger.kernel.org>; Wed, 20 Sep 2023 08:38:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c3bd829b86so52909145ad.0
        for <linux-block@vger.kernel.org>; Wed, 20 Sep 2023 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224292; x=1695829092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIlfnzN64vt0Db75ZI9wrazd3l6cBizkwl03TscBFBU=;
        b=grIImtQWNBz4O3VZ8lBD2vfKB4PkQhfq/SxGc4hh3b9cS059J/+CIL/SfhGDckO18j
         vUKBsiJHfHzbhNnjP5GedhmDEYVqVNdloYwGyBEAUxs1HCe5WXekkWk/adPF7kijc7TK
         bN3/duva0WtrtsjRijft6xB4S44bSthUrbxco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224292; x=1695829092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIlfnzN64vt0Db75ZI9wrazd3l6cBizkwl03TscBFBU=;
        b=Z6PAsgb8f1d7ePsPYVUNFRHlnfRG0Xo0EqDdDMzdYhDy2B37OEOmd1PR9m7LDBZjB1
         kfIzeI4+Q66f34urt1uXLMjFEFu3D/ibkxqXZyQSzRrk38iIt6wYLX/UIt+Rwmjq6QbD
         PyuLCR6dBgk40eMavt647GWTsNOKg6kHgf8LPvwmcCeszNmvJI9jvjw4f77UOt7OtWFM
         cb497sYi80PedMTd2RBaA/ob5ux5LzIuTID11bXu5Azt4lwtT9iRfTmUV8UDj0Z5Dp7R
         4Nd5t1LWdJkDn4cY8MA1RWs+tBfju6NSMVLp4SorpT5oZ0lxBLMfok2xIXpXmpRQXGfP
         Ye/A==
X-Gm-Message-State: AOJu0YweIOPyHyS+yLAfWo3YI8p/dZZI8iCGt0yG43pMNbSoSEROvTaB
        ovckEXWy9qsUtA4j7kTM7CUFaQ==
X-Google-Smtp-Source: AGHT+IE1DOyr9yY663BmjzKsqSYI/feK+DfQZwVOtqnpy/SKQBvmI6yXpFyHjBuRMaZeq4tzMyk7/A==
X-Received: by 2002:a17:902:9344:b0:1bc:5924:2da2 with SMTP id g4-20020a170902934400b001bc59242da2mr2463874plp.56.1695224292381;
        Wed, 20 Sep 2023 08:38:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001bc445e249asm8993425plg.124.2023.09.20.08.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:38:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:38:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3] null_blk: replace strncpy with strscpy
Message-ID: <202309200837.FAE2C061FB@keescook>
References: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 19, 2023 at 05:30:35AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should favor a more robust and less ambiguous interface.
> 
> We expect that both `nullb->disk_name` and `disk->disk_name` be
> NUL-terminated:
> |     snprintf(nullb->disk_name, sizeof(nullb->disk_name),
> |              "%s", config_item_name(&dev->group.cg_item));
> ...
> |       pr_info("disk %s created\n", nullb->disk_name);
> 
> It seems like NUL-padding may be required due to __assign_disk_name()
> utilizing a memcpy as opposed to a `str*cpy` api.
> | static inline void __assign_disk_name(char *name, struct gendisk *disk)
> | {
> | 	if (disk)
> | 		memcpy(name, disk->disk_name, DISK_NAME_LEN);
> | 	else
> | 		memset(name, 0, DISK_NAME_LEN);
> | }
> 
> Then we go and print it with `__print_disk_name` which wraps `nullb_trace_disk_name()`.
> | #define __print_disk_name(name) nullb_trace_disk_name(p, name)
> 
> This function obviously expects a NUL-terminated string.
> | const char *nullb_trace_disk_name(struct trace_seq *p, char *name)
> | {
> | 	const char *ret = trace_seq_buffer_ptr(p);
> |
> | 	if (name && *name)
> | 		trace_seq_printf(p, "disk=%s, ", name);
> | 	trace_seq_putc(p, 0);
> |
> | 	return ret;
> | }
> 
> From the above, we need both 1) a NUL-terminated string and 2) a
> NUL-padded string. So, let's use strscpy_pad() as per Kees' suggestion
> from v1.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the analysis in the commit log, and yeah, this looks right to
me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
