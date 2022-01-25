Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70271C433F5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jan 2022 11:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377564AbiAYLly (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jan 2022 06:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381990AbiAYLi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 06:38:28 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F389C061751
        for <linux-block@vger.kernel.org>; Tue, 25 Jan 2022 03:38:20 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id 2so36840802uax.10
        for <linux-block@vger.kernel.org>; Tue, 25 Jan 2022 03:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ix6kgvVL8Nx/8c4lClNn1uhhNmlmsg5FomNs+dQrm8=;
        b=TcL2zqIFyGmrSBGXnAzZyHWTQCUfrOmoLawiiEfG/DbKVQHFUwvWQhFmaP3z4heST0
         D7lj5aDTwFmiZ4fv86t6Au3RLSY9DsKr9q3CsLn8uNbYuCVU4OUTML/1JuvNyJ+tL21G
         pWsYQScqliIvmP5FQH94O68/Caosku1u4aLNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ix6kgvVL8Nx/8c4lClNn1uhhNmlmsg5FomNs+dQrm8=;
        b=aBKDHotU7sCnMj3iIrhPOH0z272UuGAQAJq6dxg98Dtyco7gjYGlkK5CpOfKhu9bnZ
         KZkYnWZ6T3+Ik8iQpZnRs7QEui0w6/FdlibbNDsnsAARwxwk993XQRqWF5/Z6icn6l2r
         e2JA/k8gSr1dod2zu1RUxw1D564knQK1ll9geqzMuf+yRa2fyTjtaWkiauKH7vW+PODP
         vi1BEw9g4KQCY1vD7QX6Iml5tbzyPsII2oYzWIuqnM/gUMo+4Gd7jqgCWnp4QTy5jeGP
         39WoHnwsoEO6/PCyecAY9vToMFbIkEWRskVFCFCy8we13P7iDoVGo62SKDCGYSf7vkfm
         lx/A==
X-Gm-Message-State: AOAM533YICs5Os42JJo/eDNt+c9eOcInjtPTuFZpGJvfBw8gZgNazyHH
        LtV3xYwAA0HLb7jl7dvEzsuA2JguG7UChZLAC8YEow==
X-Google-Smtp-Source: ABdhPJxUdxt1YoKPBp18HqqmTSJHdv14fBYM59nqNk9gfC62QoUo/N5B+/KzsQ+U3nKBgwu/DraVMQvVj57wkIiQCSw=
X-Received: by 2002:a67:26c1:: with SMTP id m184mr6848398vsm.48.1643110699766;
 Tue, 25 Jan 2022 03:38:19 -0800 (PST)
MIME-Version: 1.0
References: <1643040870.3bwvk3sis4.none.ref@localhost> <1643040870.3bwvk3sis4.none@localhost>
In-Reply-To: <1643040870.3bwvk3sis4.none@localhost>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 25 Jan 2022 20:38:09 +0900
Message-ID: <CAFr9PXk0XxXN4rWhwe_hVc8npXcVc=vb7QEmiwYaydMhXrjquQ@mail.gmail.com>
Subject: Re: "blk-mq: fix tag_get wait task can't be awakened" causes hangs
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Laibin Qiu <qiulaibin@huawei.com>, axboe@kernel.dk,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-block@vger.kernel.org, john.garry@huawei.com,
        ming.lei@redhat.com, martin.petersen@oracle.com, hare@suse.de,
        Andrew Morton <akpm@linux-foundation.org>, bvanassche@acm.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Alex,

Same issue here. I just spent an hour bisecting the issue and hit the
same commit you did.

If I try to dd from a USB card reader to null I can see a few commands
wake up the thread that usb storage uses and then nothing more.
The user process then blocks forever waiting for the data it asked for.

Cheers,

Daniel
