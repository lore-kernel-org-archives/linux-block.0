Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974EAC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5EC610E6
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhJSXAz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJSXAz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 19:00:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB964C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 15:58:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v127so14901756wme.5
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 15:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4HwbWBH225HUegq6mrkFmlBuKIdIZ25jayh+Q4kqZ0U=;
        b=belqAhkm2UmhptLkjinblyXyn7KKIVal2VvTUhoGDaJgu+R/CbvNlJRBLYYDOl+hfK
         khohVEJMt01PB56ofv8ssfh32VmXOeYKyJXcn/RLnz9uC4jio1YJDAGWNR6cResDomWv
         J3WrvGHwvyJBDjzKR/zWuFQn/6QZGF8Ju9Eutlr3ca55xgKmuS2ZUJEgCd9P+zKUyceq
         Gtw9Cz5JMSK1TE795qwj898v371GS7khCoGe6rFMdmIvzTIb3wRz3cUpYvexOu028P2s
         w8ITW18UK+1B4NxAO2cpnhpJQrv9gLTlmQApTyQmo/jN/1FaWGcFxAMiiXjvBoUM0Wg7
         bNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4HwbWBH225HUegq6mrkFmlBuKIdIZ25jayh+Q4kqZ0U=;
        b=QFgdi6ETCyOATVFusm0uDad/ONUwTSELe7T4XTcVHw7pL5GdQj1dwmvUE+Ng3DZrJ1
         VkoC3qGi/H8ZwfYWqtLps9D4TGbDN8QYMabmOmMUHLyOvX2fpeVhbqHibv5xjQPyMkcG
         EP54JbKIM1QIrpiSHEpT4h44p9KuLhPvyZm8X9H7CEUhk1dU2INzgnIp5wa6uX/eQGSl
         k4h9LOxMMwgWcn3IEOtyNuOA3YH3v7kny2ZU5u706b3f8PgJMtTO44TcIb5yameve0+Q
         SPGD1WagDaf8+5z2QyPn4DTEeFJqXZn+oDPnWQn/+GsNfXHZGHaSGXsKSQAp/UHGdIfY
         C77A==
X-Gm-Message-State: AOAM5301hxTjoetXYurqq2gCnLRf8Nm6FXZXSOeRQOXD3l9yp8wqiwR1
        LW9Uhl7AHydKJvEfruU+StRA8w==
X-Google-Smtp-Source: ABdhPJzSFjbS7MYurq/B1EWMO7XAyz1tVlukSLB4j3ZSsuxt88CjWo9079Rw2KtENGSYD6CCwXf4zA==
X-Received: by 2002:a7b:c447:: with SMTP id l7mr9453917wmi.56.1634684320531;
        Tue, 19 Oct 2021 15:58:40 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id n7sm273042wra.37.2021.10.19.15.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 15:58:40 -0700 (PDT)
Date:   Tue, 19 Oct 2021 23:58:38 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     luo.penghao@zte.com.cn
Cc:     cgel.zte@gmail.com, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn, linux-block@vger.kernel.org
Subject: Re: [PATCH linux-next] cdrom: Remove redundant variable and its
 assignment.
Message-ID: <YW9NnuSZ5aWZrcm2@equinox>
References: <YW4C4A5S+mjHzKN2@KernelVM>
 <202110191004079619787@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202110191004079619787@zte.com.cn>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:04:07AM +0800, luo.penghao@zte.com.cn wrote:
> > We no longer need the inner-most set of parentheses now, as we are> checking the result of the expression:> cdi->ops->generic_packet(cdi, &cgc)> rather than the result of the assignment expression:> (ret = cdi->ops->generic_packet(cdi, &cgc))> Please resubmit with this change and I'd be happy to approve the patch.> Many thanks.>Regards,> Phil
> 
> 
> Thans for your response. Actually I have found several such writings, 
> 
> 
> when I looked at the kernel code.such as
> 
> 
> > (drivers/video/fbdev/sis/sis_main.c  2498)
> 
> >       if((result = SISDoSense(ivideo, svhs, 0x0604))) {
> 
> >           if((result = SISDoSense(ivideo, cvbs, 0x0804))) {
> 
> > 	     printk(KERN_INFO "%s %s YPbPr component output\n", stdstr, tvstr);
> 
> > 	     SiS_SetRegOR(SISCR, 0x32, 0x80);
> 
> > 	  }
> 
> >        }
> 
> 
> I thought the doubel parentheses was a special expression，which I cannot understand(just for me).
> 
> 
> So I didn't modify it easily.

Dear Penghao,

So the reason assignment expressions are wrapped like this when used as
if conditions is that compilers will often by default issues warnings
otherwise - the compiler will warn to check that you didn't mean:
if (x == y)

rather than:
if (x = y)

which is a common mistake. Using the extra parentheses lets the compiler
know we really did mean to do an assignment, not an equality check.

Semantically however, there is no difference between:
if (x = y)

and:
if ((x = y))

in terms of the ultimate evaluation of the expression.

Another reason for wrapping in my opinion is good practice, as later on
one may wish to add additional operators to the condition. For example,
if we wanted to check if the result was less than another value:
if ((x = y) < z)

has a very different meaning to:
if (x = y < z)

due to the assignment operator having a much lower precedence than other
operators. The extra parentheses therefore enforce precedence here, and
add clarity as well. Hope this helps.

Since your change removes the assignment entirely, the extra
parentheses are therefore not required. Hope this helps. As mentioned,
by all means resubmit with this tweak and I will happily accept the
patch.

Regards,
Phil
