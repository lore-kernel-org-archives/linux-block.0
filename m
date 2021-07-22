Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03560C432BE
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 22:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3E160EBD
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 22:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhGVV7L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhGVV7J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 17:59:09 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351EAC06175F
        for <linux-block@vger.kernel.org>; Thu, 22 Jul 2021 15:39:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a20so1203706plm.0
        for <linux-block@vger.kernel.org>; Thu, 22 Jul 2021 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=464kg1T68pC5HwMKv9Atpe0ec1sq9kytcANNnpthBek=;
        b=yS/hsbwawQ19QCicvuWG6QDZq0p315I7hOo/EtTmA9IHLQNCHUWlv+iOFl/Ly8W4T5
         0At4dkxFnyw1F5/AMAwjsjEFAkxOfYyPOBGS68vy6pk+r1+FsG+aiaoCRqPDaUOgvOYR
         umlEpbfBd0uf4HJQW1eWcFo0U/E7ZEKM7dhGKoTKtOhLFRsvJuzYzCPTTHqUDYYn3v0w
         eQJ/PNeDz9gPOhSvqVHwbuSjw3XMo39aqPtmFh5bz0IRu7dxG1b4MNwJXV98y3vClhJL
         CBDYyPrdKoijtYt2L8LNvOzvKuOX8msDMvBPxhomXUOhvDxXbB9/YJjywRsXe0l8PMht
         Q3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=464kg1T68pC5HwMKv9Atpe0ec1sq9kytcANNnpthBek=;
        b=rzm1RabK29exLXJfeKJyStEWnPrXsY8RQZaMRyRoZauEN0GphChG/lhyH1DCqygrM4
         HUe2b4+5xSsySlNz4O2hwI0gUketJTWD/pyMdYHOpgzJMC+Si7vccrhl3EsGkbydKO2I
         +VPa87NWoX4n9oQrRK6j/svsqVPs+TqMHb/OjxtFKcuwenChVn3XuRwcvUGDOgofkkWF
         NdZYREyYyyxkV5o/Rfo59eKLjVhVeL/l2WUMKbSDXuQD6TXsT4NBGryWX69Gp+5ArXbS
         LNGXA899UQdbqzJFmjlePXECvHxc1WpQV+S0I09lM8JwkXPfSMX/bDqmTtCm07rdMs7k
         K+ZQ==
X-Gm-Message-State: AOAM531hrpn2MEa61y7KdnEmONkcdnQZvJXN/1cZsyMdYDr345g8R6JL
        vWDlADvZg2zcjGPOIZ3vxPOK3w==
X-Google-Smtp-Source: ABdhPJyDUgyzv99y/lDZIzirOw2rLLLDML8ftb5T/FAs9qRdcruNT4j6gmNAEv7kfBkJ19Tk0Oil2w==
X-Received: by 2002:a63:1718:: with SMTP id x24mr2084278pgl.416.1626993583767;
        Thu, 22 Jul 2021 15:39:43 -0700 (PDT)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id g123sm30673812pfb.187.2021.07.22.15.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 15:39:43 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:39:39 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, shuah@kernel.org,
        akpm@linux-foundation.org, rafael@kernel.org, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, andriin@fb.com,
        daniel@iogearbox.net, atenart@kernel.org, alobakin@pm.me,
        weiwan@google.com, ap420073@gmail.com, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        minchan@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: add documentation for try_module_get()
Message-ID: <20210722153939.08a6853c@hermes.local>
In-Reply-To: <20210722221905.1718213-1-mcgrof@kernel.org>
References: <20210722221905.1718213-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 22 Jul 2021 15:19:05 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> +/**
> + * try_module_get - yields to module removal and bumps reference count otherwise
> + * @module: the module we should check for

You have the right intentions, but this patch needs some work.

This looks like a docbook comment format but isn't that format.

The first couple of lines need to be reworded to be a complete sentence like
the rest.

In general best to make new comments the same as existing comments
in the same area.

It would be better to put this description in the header file where other
docbook comments for module API are. See example around module_init() and module_exit().

Ideally, all the api's around module reference counts would be documented there.
