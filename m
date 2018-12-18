Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68CDC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 09:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EB2217D9
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 09:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="pqJbbzYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeLRJWI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:22:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53123 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLRJWI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 04:22:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so1875949wml.2
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=reJDQjip8OvNsd/j/JXEkcYjvOIxqRk/9WRj/efcj0I=;
        b=pqJbbzYfX/Z64Xtnn6yfO2dRE6W+8UI6mgWlIBlKZza21Kaufd/KWPbykdOXq6AWg/
         BNqxsQp+eU/T6tfI5w5meCpPSSnBpEUwQIxF8H3Ek5/MNATXbCv5Q6XSsJ0ZaPUVUcvL
         PJn7T+lTDWHbQIyphebcXE3p5V6rVDpDAPsshzOL4yhni+et2e+GjVd77jg14UFhL4Sr
         rf9daEn6qE9NBs8hwZqWpA9Yi+xwuztuGnAb6sSOOCIz13YzXv4sNkxdv40wC8Zgc7/2
         ZK6Oqre/7D/l+XskFeScwyMXmoQnyIS8J0nicff/a63xZCUI85nxef0sSYS/icnYNdNS
         nvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=reJDQjip8OvNsd/j/JXEkcYjvOIxqRk/9WRj/efcj0I=;
        b=aTfyXuwGCt5nlWlDPJXIE/DjEsVDXBMNU6Y3PCEZDXkr21jh4N5NJmuCryFJC2sX51
         gu/xL6cGNMLl2vMRwJDJYCunIj0WKMPL1pQXQkHtkLGL+sOqpfIsHnv2d//O+Z+e1oBS
         e4REOJyRX/w0b98N5C+7+FN7x+ABAj5dCtD39Gm8T1WaAfn8SnPM9WXPpsWsLuBB3ETY
         AMePiIDNdXKI/zIwBnpN1hOxAq60abiUb9dnw0AvEJMK8AAxVqisT1/07v2IQGUHATOv
         fWFDTe3omn2RsQEycCiGsc9/B4TAwCgE8nQmovlSsWNcfX2ID4LRJYvcBcf1mEn5I9qo
         BXBw==
X-Gm-Message-State: AA+aEWbU3h0ndSGoPf3zLHEdApnagTGRUSyAweCgiSEym0tgbj5V0tl0
        1wl3ha0wJMh/354YNmQkKliKLQ==
X-Google-Smtp-Source: AFSGD/XIEEU9DQlJqNvps/ObjEWsldN32cqEJGbpNvRVX/VpQ0Vtb6F269EHnMZdVyf/mT9Hz0uOqw==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr2293444wmb.98.1545124926061;
        Tue, 18 Dec 2018 01:22:06 -0800 (PST)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id w18sm1686607wru.54.2018.12.18.01.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 01:22:05 -0800 (PST)
Date:   Tue, 18 Dec 2018 10:22:02 +0100
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] drbd: Avoid Clang warning about pointless switch
 statment
Message-ID: <20181218092202.GJ5026@soda.linbit>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20181002171447.10765-1-natechancellor@gmail.com>
 <20181004200912.32348-1-natechancellor@gmail.com>
 <20181217172401.GA30635@flashbox>
 <0110d874-7595-1786-77e3-e2b0daec2327@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0110d874-7595-1786-77e3-e2b0daec2327@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 10:29:38AM -0700, Jens Axboe wrote:
> > Hi Lars and Philipp,
> > 
> > Could you please make sure that this patch and the other one I sent make
> > it into 4.21/5.0? I am not sure when you were planning on sending the
> > pull request to Jens that you mentioned in the other thread but I've
> > noticed most maintainers typically send their requests for the impending
> > merge window around -rc7 or so and I wanted to make sure it was on your
> > radar.

I'm sorry.
From my point of view, "fixing the pointless switch" is just "pointless",
so it (again) fell through.  I get it that it is important to others,
and getting rid of Clang warnings is a good thing.  So sorry again.

> It needs to get here now, but drbd hasn't really sent anything in for
> about a year,

Last actual fix was 2018-06-25 64dafbc9530c drbd: fix access after free
so almost six month, yes.

> so I'm starting to doubt how maintained it is at this
> point.

Oh, it is maintained.  It is just happens to be "stable".
We don't add new features there,
and I'm currently not aware of any misbehavior.

I'll prepare a pull request containing this,
the other Clang warning patch from Nathan,
and possibly other small stuff that accumulated,
if I can find any, and send that out later today.

Thanks for the reminder,

    Lars

