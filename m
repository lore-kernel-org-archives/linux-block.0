Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA908C433E0
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 02:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D01664F8E
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 02:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCLCPO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCLCOo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 21:14:44 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74892C061574;
        Thu, 11 Mar 2021 18:14:44 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a188so834368pfb.4;
        Thu, 11 Mar 2021 18:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DLypqHmd9Wl8adDWo2RyhZBE8XSLiDUVzOC9qvznIU8=;
        b=B3oWOI+K2T5zV/Md7TadfLAmGLPu+uD1roU9mISoVp8QM6Lton5aFPivU8QWfVxj4j
         5zfvtkNN2yjCDsDAt27yTASwV8QOfEq5cT58TNhxWU0dL/g/6DYGP47z6dSqzhPsI2I+
         BDc9thgGofUPaS4GbYAqm6nR0VgRjU7LiWtACxjR0TddbJFDRvZXvIVbt1JCUrcL0bhe
         8F1E+XSbMT5jQZ1E331ImgIUYr7nQe4+a78GtAqAUe8O9PKjDC/eOiAIhkd0btitmR98
         BQmrgY3a74lrgjv3kSNGf+FLhv9Sl7ncAUKrwi2BgvO8kuspQm3smpflI/pZ6a2MHJ+9
         xj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DLypqHmd9Wl8adDWo2RyhZBE8XSLiDUVzOC9qvznIU8=;
        b=YKapaVX+tC4G7bELxBX9uIeYbJAwfaMB+0DA1Vh+PqDPEch0roKT18qX5uiAlFptwN
         7kKqNqxOO+WiI1pnhy/zAS2yO0UgSzI97fj29CXG4rOb+jD/UVqnvkAEE8YgBHdAxL+S
         j8D9TXj7LYCZizYjIUgFMKuvHe3IZPUnhnskn/Ii4vSlTDWO9blZYIj0xtZyBsmCQ26o
         RwzM7l2VX5Y4uIleCQgZoNZR9ibBZW+E1FIg72/eVI/v5nOnA1e+HALo9UXTpQcI4lyb
         7LLckPfATZK1aHm8P1H0GrBU6Qqd3KgfKSKY97tATlqi9zPji5z4HPsSBpudGzbc9dd/
         8hCw==
X-Gm-Message-State: AOAM531YAWFWKtyhptMqqHC/UQC+l66bSvl42C6MTQhQAdehqe/+IfyO
        dJxGJ0jf2nWYzxsAmdam8uU=
X-Google-Smtp-Source: ABdhPJz33tsfuzaXaKHm7Wr7SIqzZWngowKHicIKhIrkJ5ud501aWmDCFj1D/XjPCwgckpPdOhrnMQ==
X-Received: by 2002:a63:fb18:: with SMTP id o24mr9404191pgh.55.1615515283833;
        Thu, 11 Mar 2021 18:14:43 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id l22sm371771pjl.14.2021.03.11.18.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:14:42 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 11 Mar 2021 18:14:40 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>, gregkh@linuxfoundation.org
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YErOkGrvtQODXtB0@google.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
 <20210310212128.GR4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310212128.GR4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 10, 2021 at 09:21:28PM +0000, Luis Chamberlain wrote:
> On Mon, Mar 08, 2021 at 06:55:30PM -0800, Minchan Kim wrote:
> > If I understand correctly, bugs you found were related to module
> > unloading race while the zram are still working.
> 
> No, that is a simplifcation of the issue. The issue consists of
> two separate issues:
> 
>  a) race against module unloading in light of incorrect racty use of
>     cpu hotplug multistate support


Could you add some pusedo code sequence to show the race cleary?
It would be great if it goes in the description, too since it's
more clear to show the problme.

>  b) module unload race with sysfs attribute race on *any* driver which
>     has sysfs attributes which also shares the same lock as used during
>     module unload

Yub, that part I missed. Maybe, we need some wrapper to zram sysfs
to get try_module_get in the warapper funnction and then call sub
rountine only if it got the refcount.

zram_sysfs_wrapper(func, A, B)
    if (!try_module_get(THIS_MODULE)
        return -ENODEV;
    ret = func(A,B);
    module_put(THIS_MODULE);
    return ret;

> 
> It is important to realize that issue b) is actually a generic kernel
> issue, it would be present on *any* driver which shares a lock used on
> a sysfs attribute and module unload. I looked to implement a generic
> solution on kernfs, however we don't yet have semantics to enable this
> generically, and so for now each driver needs to deal with those races
> on their own. That sysfs race is dealt with in the second patch.

It's unforunate. Let me Cc Greg who might have some ideas or
find zram mess on zram sysfs implementation.

> 
> The first patch only deals with the cpu hotplug races exposed at module
> unloading.

True. Thanks for the clarification.
