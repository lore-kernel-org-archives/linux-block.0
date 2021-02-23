Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E552DC433E6
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 22:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B333064EC9
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 22:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhBWWmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 17:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhBWWka (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 17:40:30 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBEC06174A
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 14:39:48 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id e7so123029lft.2
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ee4pFk6jWgrY2YJbXXX7SSyhDpedfC2qAYauzov/YXE=;
        b=p82Kj/jPd2Wm4DBhMyVkhbKfZPLeCC6Jts3dsXC6Jf7Uz3+ilUDTNDX+rV0dHkbtHi
         pX/7BHqVFuVcJ6oVQeh01ZFhtmZpSSNj9Pi580ma1ytrmP62+R1aqD97gPc3upEd/7Dp
         C7n4Q8Phn/hITZxbhU4FwKOelNHscQLBxKh7ocijKaoxh6bInc9Apuojx9x4uGjFraI2
         OmwN+mHLgtyVbA/7rpdAtyp23/x0rZ9zu2duUEpZhptGcVtoyMW4qtGss9gogjEZgfk5
         KLYvVWxO93thSERhZ9EkJ2KpwN8ZNZ3fJC7LRHtU9+D+pS/nDyYqkz0NGoLBVDM/z1f1
         CwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ee4pFk6jWgrY2YJbXXX7SSyhDpedfC2qAYauzov/YXE=;
        b=TotbSCplqBUfBXZskZhYPIbYvE8JcZzunWGgsEWdkUZJI4fqP5+dyFoDa4i+PcLkgx
         7UjBBso6TS5JO2Am3223x0OoAj7UnH8F2sc9m7oDWTs48qn1zDr/RD7Za/p+focm6UYk
         Fq61bApQMvuaZhvy6j2gag3NwiqERTSAapa1A/zXYT2ceNT3Cz3HSVrm6S5w5r6LPHUI
         13Xtm2PxgsJHsKzIOGfSDYovaivwpanXnEbmtpXPV/6jVtl8lK9iG+cRx1ohnZxEWwvU
         wU13CEztLYYtQdKdwSCmafdhK1lTBaDsfdw9xzNwcpyT/n/SMt8lwSjP6G/CD/lI88xQ
         KVRw==
X-Gm-Message-State: AOAM531kkIfNOmM349WeyPt90yXslSo5tuuV2YAd2U7YUxVwZCFMY6tO
        Ur1a6NOrSJ5BP7hsJxdJ4Mgm82Nem2S/vaJQHBsV5g==
X-Google-Smtp-Source: ABdhPJzBSxGooRO1g4kr2Y4/POPmP/l99/Ytc8DCrMYJtzvi39yx0zr0KGUpIzlCpVkif/7+ZRL5ggYY8cW4jQ0ooRU=
X-Received: by 2002:a05:6512:33b8:: with SMTP id i24mr17363663lfg.7.1614119987273;
 Tue, 23 Feb 2021 14:39:47 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLU3B8YcS_MTnr2Lpasvn8oLJvD2qO4hkfkZeEwVNfeHXg@mail.gmail.com>
 <20210223063130.GA16292@lst.de>
In-Reply-To: <20210223063130.GA16292@lst.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 23 Feb 2021 14:39:36 -0800
Message-ID: <CALAqxLVtM0PKSen8eo_bud+NmBEamEJjK7qZTT49pTX5QtqvrA@mail.gmail.com>
Subject: Re: [REGRESSION] "add a disk_uevent helper" breaks booting Andorid w/
 dynamic partitions
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
        linux-block@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 22, 2021 at 10:31 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Please try the patch below:
>
> ---
> From 85943345b41ec04f5a9e92dfad85b0fb24e2d2eb Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 23 Feb 2021 07:28:22 +0100
> Subject: block: don't skip empty device in in disk_uevent
>
> Restore the previous behavior by using the correct flag for the whole device
> ("part0").
>
> Fixes: 99dfc43ecbf6 ("block: use ->bi_bdev for bio based I/O accounting")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yes, this seems to fix the problem! Thank you so much!
Tested-by: John Stultz <john.stultz@linaro.org>
