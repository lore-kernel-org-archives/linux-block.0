Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74286C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 09:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA652076E
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 09:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exdMY4zA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgG2JqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgG2JqG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 05:46:06 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19905C061794;
        Wed, 29 Jul 2020 02:46:06 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y11so7575667qvl.4;
        Wed, 29 Jul 2020 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qKqsPY+0Cr+gMXTjgMZqIkPYuBQVt0J989rAmnFgmeU=;
        b=exdMY4zALaxlGmXURUoiL4WbHOj/tNkzH0Kx4srdUzkOqbr3CT19pZFQkU2LdAMebo
         7rCDri0qfWSXkeEAs7m/zfUD9Xmi5dd8uHpKLlL0Msk4rSk+HcQz2eygACEcYa8XIO6p
         1HtUVDavfa/4dFho4htY+pTGJgwqdrMliIILol9FWMlICuSI9gAopyGXGQNWABScT5dZ
         WTx5e/JOToAMvj9xej5K+J93URQYNzEF8Z1vtCfONKCq40WzXwPiOfyuhWhWyTBH7pv7
         SdsOz+t94s+MuPGEs/w30Plpxb+McqrZHne+GLkXFKtBCKpV+wbXr+wZ8//fIHhGg4ux
         XrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qKqsPY+0Cr+gMXTjgMZqIkPYuBQVt0J989rAmnFgmeU=;
        b=Q80uku5nBAsgH8WJG5OKrKhjrYxmI/dK12YnkcJYR7NkDfN6ajPiUiwEXmDUvq+tTq
         wKKfMbawvaKW2/wVUuREko5hXvxqmctKr1kIfTSXe89AvFe1B7t2SbnGI4HcX4s2YSf1
         ZRNhQD/sXMpsrIAjPOfp820vf8clrimRfsLBDpSlm+EVacyyN0s0TFzY9sorOVjnJCBH
         4b7LDj4R/ShgQ0TYQo8WhJkJDki6H6GF5lzSOdBrUo4RzhZgyv0A7UAgys033Z7avzIw
         qMj1ILtji+u2Klf/xtMbIMkodaZAL+Rmjz51/zOpK6KCf/krVJGYTtKspkOaVrru8i3T
         noxQ==
X-Gm-Message-State: AOAM532V32yOF5OB+rnP9Wup2V4qu9ihnB75xPbU2QVThzX1JaLwdSvG
        Cy+uSRaSx83maDfuyMfgDUDsmGM=
X-Google-Smtp-Source: ABdhPJz+gwQhzTK7TSgsm4aDXkBGBvswsQhlOnR4n29OVW7eRUNdrmqXogHXIenVoNs6xjdhNdG3Nw==
X-Received: by 2002:ad4:4645:: with SMTP id y5mr32679485qvv.163.1596015964876;
        Wed, 29 Jul 2020 02:46:04 -0700 (PDT)
Received: from PWN (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id c70sm902307qke.109.2020.07.29.02.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 02:46:04 -0700 (PDT)
Date:   Wed, 29 Jul 2020 05:46:02 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] block/floppy: Prevent
 kernel-infoleak in raw_cmd_copyout()
Message-ID: <20200729094602.GA6026@PWN>
References: <20200728141946.426245-1-yepeilin.cs@gmail.com>
 <f80acf0f-3e7e-89c5-a00e-d5a89553f0b4@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f80acf0f-3e7e-89c5-a00e-d5a89553f0b4@linux.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 29, 2020 at 12:18:42PM +0300, Denis Efremov wrote:
> 
> 
> On 7/28/20 5:19 PM, Peilin Ye wrote:
> > raw_cmd_copyout() is potentially copying uninitialized kernel stack memory
> > since it is initializing `cmd` by assignment, which may cause the compiler
> > to leave uninitialized holes in this structure. Fix it by using memcpy()
> > instead.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 2145e15e0557 ("floppy: don't write kernel-only members to FDRAWCMD ioctl output")
> 
> Nitpick, I would say this fix is not related to commit 2145e15e0557.

I see, I will send a v2 soon. Thank you for reviewing the patch!

Peilin Ye

> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
