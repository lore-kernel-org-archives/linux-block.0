Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D65C55179
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 01:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDF12076D
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 01:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNA/hpF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgJ2Bap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgJ2B3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 21:29:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D646EC0613CF;
        Wed, 28 Oct 2020 18:29:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o9so511538plx.10;
        Wed, 28 Oct 2020 18:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5qS5USRrvbij0ydOHsLwR1E5fqhazw3/Mtfj6k5q0Ac=;
        b=mNA/hpF5JZ46Mp9cqsQHCB8NcFVJmVldNDHVeK7cYKe/++CoVVVQu+93/98gISEpqj
         GE1W4TclMYHsorN5daY1B5yHSPw/ZN51zm5tm4hMcVKpfRMbCnNMNx7HhRWK3V03/BaQ
         ZTesGkIt/oadNPkZI5gOeI9lmWWfhFovTSpePlJv56e9QLRVIsKc5N4OXUwwwDSl91fv
         fgTP1ZP59qwgdDXOug5tk/V/UjAkZHLTx0brEOQUsERZ/vIbWV16abw9hDSgTXzmNz3a
         juYj9amW1dyc5JHfNBXUTHdH5C0U0uCpnccQKlrYXOTHWZP2vCfqIJ/WekqHqokZ0KCn
         WUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5qS5USRrvbij0ydOHsLwR1E5fqhazw3/Mtfj6k5q0Ac=;
        b=p8+oeOYJRv8LxDDYXAu6Xh7ph7Dxc5dHUHItPAif+AbxcX9t+F4q4hFM6HtdZyYNsY
         oRVpBePKNM7Nj/2hivdUtELcYOklE1c4HwJ/rkTKVZYsOrLNjpZ5TMeYlWTyRzRODGar
         cM63zUTfCPNdFyaVAexlP+Fx/tc1ErD1aZd3fSzFPbGA+6G+P/vrP0toT0zFC4imAy3W
         fPTbOpJc+Q5Vn5Wpr0Uf6hlAQKtI2AgpGvWPVsxWr5zKaeQE3P43Cg1KDr+sbbJseKNX
         6b9agqd8tpla4aaILKfmVbOlmzzXRTzXJGYdm0TVBDFqYp193QKEQdbBtMIGcL7Zc4JO
         IqjA==
X-Gm-Message-State: AOAM532kRnnWVXNbuis+qo2GEWV1IveVAV244xZgwDTwzAdfMX76Fk1U
        hO4+MkECuXPBCIpyGGhvQaM=
X-Google-Smtp-Source: ABdhPJyuUUd9h1m4NUFXfAoZY7OemOPR8JOmS+whyQjiccT2S7mwD3/f6QJ49bYUfRMgMXunoyFNPg==
X-Received: by 2002:a17:902:8545:b029:d5:dbd4:4ab5 with SMTP id d5-20020a1709028545b02900d5dbd44ab5mr1716546plo.31.1603934956454;
        Wed, 28 Oct 2020 18:29:16 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id z26sm842646pfr.84.2020.10.28.18.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 18:29:15 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:29:13 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        minchan@kernel.org, ngupta@vflare.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3] zram: break the strict dependency from lzo
Message-ID: <20201029012913.GC128655@google.com>
References: <20201026085141.1179-1-rsalvaterra@gmail.com>
 <20201027012204.GD2412725@google.com>
 <CALjTZvbf4qK6SHEe7OhkTC_o7kaY4oOKQ+kk-D2OUq_ULsYAqQ@mail.gmail.com>
 <20201028101934.GB48825@google.com>
 <CALjTZvaTiAS1vMyrTNvrfy7KOjemy+tW5-hbTy5SHYfsbRE=_Q@mail.gmail.com>
 <20201028182158.GA128655@google.com>
 <CALjTZvZQyJb=y=XyUzpefEPL-XpK0gMwMW-+0GF1EUrW8Oapzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALjTZvZQyJb=y=XyUzpefEPL-XpK0gMwMW-+0GF1EUrW8Oapzg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On (20/10/28 23:11), Rui Salvaterra wrote:
> Hi, again,
> 
> On Wed, 28 Oct 2020 at 18:22, Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > Right, but well we also need to select ZSMALLOC and CRYPTO for
> > zram to become visible (the thing that I found out recently is
> > that you can always check the hidden/blocked items by hitting
> > 'z' in menuconfig).
> 
> Sure, I can fix that too. Should I do it now, or wait for
> Andrew's/Minchan's feedback?

Let's give Minchan and Andrew some time. It's still -rc1, so we have
plenty of time to land this patch.

> And that 'z' key… wow. Did you read the kconfig code?

By accident, "fat fingers" lol

	-ss
