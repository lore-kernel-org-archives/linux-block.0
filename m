Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A17CC433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 12:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiDNM6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiDNM6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 08:58:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CE091573
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 05:55:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso9236056pju.1
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a1WHEshc8jeSg/2FZoXCliVSaLfU+TecDSEXuYNpIHU=;
        b=FEvVolRTVpTd9jHS1vWAUgfWi1guzRPZNfru58p/RNcqtOoWuG+r76K2fNT2eJAodj
         v6rUZk4p6FI5yWa0R3fW1akqGZGZlSQWYFIYP4IQpz2sJ6PEegCbgun9ipWzdkT36PYM
         JCZEpdQOT0jsSLza/eDsGTUZgJhTFn5b3PsqSy3668rbPJFYzQkN1D0Z4KmB9CU6768J
         M5l8kXVk9ivE6HKogfwkGuCelTgzvY6ioFK1OI1Md144E2ztTRZ+RlfPiwdasB0sLbay
         ovteG7JPRyHF2qEJO3xY3yNSbIe/W5KBiKQ0Ur5HVlaRhCzzLHTOLiYOAO7y4CBQD/46
         QBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a1WHEshc8jeSg/2FZoXCliVSaLfU+TecDSEXuYNpIHU=;
        b=zTmc4Eu665Fgj8RZUTbWSq7DVk8xJxSBzxjhXTlXyXr/saN4vvY4GnGpeSG26nzYD4
         B3XETjGsGxQZOvFmiwenhlHVl2KjCXWvZdQqLi5MkPZ58JqPx2U0MCAsNdBXhTfLma/X
         ZyemA89va4yinpIq+kT+VPHwYeltUX5SXtH43edvIhfsIyZCNJY83zRSHOQ1uqHF6k0v
         g55+ex+1czUrQwbc5SnBlq9D2FYueo1XcyI0iY2huVE4QREQ6ewaddJryY9KO+YHGgj9
         4u4RAF91w3TIK8PTFJlcZYbSRB+nb0trVynxFvqzjdmXU6hraeL2wmEStsqM5Pf2+YH6
         3DAQ==
X-Gm-Message-State: AOAM530rQlC6PsWYZuQLThYq8dkzbg0KFdZJkO/NNFifsAOtVrNaNM92
        Tu0iQjIXk5Ej+8QDePhhW/6uPg==
X-Google-Smtp-Source: ABdhPJxIwaMPBAWFG5eyy1DGvCp5HnYBStbqAKm6DdTBA7mu4nNnzhbvqcy8fKq1oBK53eo1gTDFuw==
X-Received: by 2002:a17:903:240f:b0:158:b871:33ac with SMTP id e15-20020a170903240f00b00158b87133acmr3234662plo.135.1649940949984;
        Thu, 14 Apr 2022 05:55:49 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a000acb00b004f35ee129bbsm2395408pfl.140.2022.04.14.05.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 05:55:49 -0700 (PDT)
Message-ID: <4c5803a4-4e69-e107-c2b8-7a3e7733fae2@kernel.dk>
Date:   Thu, 14 Apr 2022 06:55:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] Revert "make: let src/Makefile set *dir vars properly"
Content-Language: en-US
To:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org
Cc:     Paymon MARANDI <darwinskernel@gmail.com>
References: <20220414063651.81341-1-stefanha@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220414063651.81341-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/22 12:36 AM, Stefan Hajnoczi wrote:
> This reverts commit 9236f53a8ffe96cc2430f7131bbcba5756b97bc2.
> 
> "make install DESTDIR=..." specifies a root directory where files are
> installed. For example, includedir=/usr/include DESTDIR=/a should
> install header files into /a/usr/include.
> 
> Commit 9236f53a8ffe removed the includedir=, etc arguments on the make
> command-line in ./Makefile, leaving only prefix=$(DESTDIR)$(prefix). It
> claimed "prefix suffice for setting *dir variables in src/Makefile" but
> this is incorrect. "make install DESTDIR=..." now has no effect and
> files are not installed with a DESTDIR prefix.
> 
> The GNU make manual 9.5 Overriding Variables says:
> 
>   all ordinary assignments of the same variable in the makefile are
>   ignored; we say they have been overridden by the command line
>   argument.
> 
> This explains why it was necessary to set includedir=, etc on the make
> command-line in ./Makefile. We need to override these variables with
> DESTDIR from the command-line so they are not clobbered in src/Makefile
> when config-host.mak is included.

I think this should have gone to io-uring@vger.kernel.org, the patch had
me confused for a second.

-- 
Jens Axboe

