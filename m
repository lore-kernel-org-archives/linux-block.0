Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F411C433B4
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 03:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E03610CA
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 03:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhDIDB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 23:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhDIDB1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 23:01:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6263C061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 20:01:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso2453134pjh.2
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 20:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l4kWVydlQgtbWXguGGvDOO5ElHsvWebsW50A16IjvpA=;
        b=cfXLWGa0N0JcX+zcz5jXLT03LFbuVUerMFUfD4BH2e46vWnphGlljifyfJrcn/qWoC
         eCDYHc1db4HZl9RZhBK2u297LU0REAyATYor6pzeFD3kmjZDcAm6naQEo/aQgOfkXRgL
         A3c7UFPB3G35KQWgPgqzYbRJPY77XzVCz4Ffw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l4kWVydlQgtbWXguGGvDOO5ElHsvWebsW50A16IjvpA=;
        b=g7FBevtnatzNU7Pfw0dCQhwI/rBdH/vcmggAxhZzDk79JWiHqr/wDRcTrCArjCqCiG
         N46pJf+OEUZZnoWu449/BGqOIX29yCTOTTPn7NLd0rzvQI3E9rVrxu+XK12B7X7NqZi5
         nnGzucd0qZu+ZHJtSQqisq7OE5KbahT30Bqitztnxpvrg9vynwK8YT25QgEYA9GFUpp7
         1m9qjRwQbhMuzVjRs4vz5ixDgT2WzCgBD5eTUTkLPcst2no+n+C0IVPG+Ky4vLgBoSfS
         h1bhC14cNqfnJFJCX9D7IvUL7UHKDSNZUyQR3TZJ9/kyyvE3tClB07ThcwPZ+T9/fobQ
         7hUg==
X-Gm-Message-State: AOAM533H6QnqRv4N0UayjNtJR7f5/aXk4a6h6yx6ZbgEkB74a4IiV+EE
        Rt7+KBSoxZrikJZLMS7o9sXj0A==
X-Google-Smtp-Source: ABdhPJyt++GWL3TDKYLT7VVWWOFqNTu06C1X8nv/25cbh7hwf7ezYmVaJHTW9QPd9IILLGjgC1A1Gw==
X-Received: by 2002:a17:90a:db86:: with SMTP id h6mr6680675pjv.14.1617937273377;
        Thu, 08 Apr 2021 20:01:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e31sm614925pjk.4.2021.04.08.20.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:01:12 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:01:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>, dhowells@redhat.com,
        hch@infradead.org, mbenes@suse.com, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <202104081953.5A0D3923CE@keescook>
References: <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGbNpLKXfWpy0ZZa@kroah.com>
 <87blap4kum.ffs@nanos.tec.linutronix.de>
 <YG6fpgmYSg/PwOrU@kroah.com>
 <nycvar.YFH.7.76.2104080957580.18270@cbobk.fhfr.pm>
 <YG66OWzum5DGcSTn@kroah.com>
 <nycvar.YFH.7.76.2104081015340.18270@cbobk.fhfr.pm>
 <YG7FGRNhIfDTqgUz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG7FGRNhIfDTqgUz@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 08, 2021 at 10:55:53AM +0200, Greg KH wrote:
> Module removal is not a "normal" operation that can be triggered by a
> system automatically without a user asking for it.  As someone reminded
> me on IRC, we used to do this "automatically" for many problematic
> drivers years ago for suspend/resume, that should all now be long fixed
> up.

I know what you're trying to say here, but I think you're just completely
wrong. :P

We absolutely must handle module unloading, and it is expected to work
correctly. _The reason it doesn't work correctly sometimes is because it
is a less common operation_. But that doesn't make it any less
important. Disk failures are rare too, but RAID handles it. If there are
bugs here it is due to _our lack of testing_.

Module unload needs to work for developers loading/unloading while they
work on a module[1], it needs to work for sysadmins that would to unload
a now-unused network protocol[2], it needs to work for people trying to
reset device hardware state[3], it needs to work for unloading unused
modules after root device, partition, and filesystem discovery in an
initramfs[3], and every other case.

The kernel module subsystem is not "best effort" and removal is not
"not normal". If unloading a module destabilizes the kernel, then there
is a bug that needs fixing. I'm not advocating for any path to fixing
the technical issues in this thread, but we absolutely cannot suddenly
claim that it's the user's fault that their system dies if they use
"rmmod". That's outrageous. O_o

-Kees

[1] Yes, I'm linking to the book you wrote ;)
    https://www.oreilly.com/library/view/linux-device-drivers/0596005903/ch02.html
[2] https://www.cs.unh.edu/cnrg/people/gherrin/linux-net.html#tth_sEc11.2.2
[3] https://opensource.com/article/18/5/how-load-or-unload-linux-kernel-module
    https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/sec-unloading_a_module
[4] https://git.busybox.net/busybox/tree/modutils/rmmod.c

-- 
Kees Cook
