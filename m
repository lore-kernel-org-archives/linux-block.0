Return-Path: <SRS0=0UXK=Q7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57184C43381
	for <linux-block@archiver.kernel.org>; Sun, 24 Feb 2019 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208E420652
	for <linux-block@archiver.kernel.org>; Sun, 24 Feb 2019 15:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/Ppn11A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfBXPvF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:51:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35818 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBXPvF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Feb 2019 10:51:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so7265500wrx.2;
        Sun, 24 Feb 2019 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+daz3/t6diyQbRxSaNmxyitK0+xCgefRfieCdYWCQE=;
        b=D/Ppn11AP1NWq+qmffmSjc3LhPIXemb5keXpmyFVMsu5U9WUOjwwV8GGA/Q3D0Y1Fq
         mc3gzjfhpKUPdfigZsw4PwMfJ6MwhMcRivqKSP2xS3zxvoEP3RmRtF0xqQ0Js1J31lVK
         b3JXAoPxGjp3uths/VCR5CiLqLzmeIqgA2ybIE1QouvR6SeMoyNW9x8Q6WWqqIvalNXN
         U1zjrWWJLtTLmcxdRwiYVhdnS/l1DGuNkMIYQ3kV/MW7tk4iMQndlV8AWnfeLFGFajKd
         cVrVOMOUxJny6YiMBoPHlHstihnP933kGHmFy/wMfmNLv/vlcCuLvrdJa0yAouKnWqQF
         Gd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+daz3/t6diyQbRxSaNmxyitK0+xCgefRfieCdYWCQE=;
        b=aTZrLvoT60mLIGFfdUVHVwTpQfBJRh0blTKL/pqFRt2Ev9oaaEzwCIO7Fc9eaSopkQ
         2nLYhXa6JY8t7oY/f7i1zzj3CrGjGs6Z0MINO0u/BhJhKVdvjoObEgx/1fYxxISLDeuT
         cbm8ytZXeSL3L4kd45PXa7/ZEQmKPdU2EtMLrH17lW0eJFdIABzrsmO+eB7ZH3az+uFn
         Q7UGLen/1T+sSY9SK/yvs20ULSHVYCMy+11I+zm2dqD/m1U4gOE5rusZdUgzKfltTrgM
         Bmq1BMDO7YMhhISE0iRFZgKYCh4WeRdLgQ7tuHB5iU7Ht9g3izdsa0gCWCSwVMWeXWYh
         NLPg==
X-Gm-Message-State: AHQUAub0WalF9ExEV2Sb4XfUSVouEWrebEaQOzfPeN/zTZwj8RpgzMHQ
        117SAqxTV3bVynKOM6jfxZv1XNZKIUTLPnrPFLXEYG2F
X-Google-Smtp-Source: AHgI3IaMD5TX1E/KOGAnRAV4bqAu3lDDtpClYmREKc3C1yXDaR+KVvw/qHgwVoj2ihsvaQiFjrwBms8nVtaUrqpxQYg=
X-Received: by 2002:adf:e50e:: with SMTP id j14mr9339916wrm.262.1551023463132;
 Sun, 24 Feb 2019 07:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20190224141952.GA3653@bharath12345-Inspiron-5559>
 <b96f9ac8-639c-adfa-e0a4-5ff537bc9db4@kernel.dk> <20190224153712.GA11981@bharath12345-Inspiron-5559>
In-Reply-To: <20190224153712.GA11981@bharath12345-Inspiron-5559>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 24 Feb 2019 16:50:51 +0100
Message-ID: <CAFLxGvy1fKXEwZJwhD=aCbQ67HO+eK8T27KEfMrLu13ABvO1Wg@mail.gmail.com>
Subject: Re: [PATCH] badblocks: Prefer unsigned int over unsigned
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Feb 24, 2019 at 4:38 PM Bharath Vedartham <linux.bhar@gmail.com> wrote:
> I understand. I am starting out kernel hacking. I have been working on
> fixing checkpatch.pl warnings. If you have any tasks for me in the
> kernel, it would be great.
>
> I have also noticed a lot of warnings to replace printk with subsystem
> specific warning functions. Is that a valuable change?

This is a very good start:
https://lists.kernelnewbies.org/pipermail/kernelnewbies/2017-April/017765.html

Happy hacking and welcome! :-)

-- 
Thanks,
//richard
