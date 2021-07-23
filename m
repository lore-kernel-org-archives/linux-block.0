Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C6C4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 22:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CF660EB2
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 22:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhGWVlm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhGWVll (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 17:41:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05843C061575
        for <linux-block@vger.kernel.org>; Fri, 23 Jul 2021 15:22:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id a20so4934070plm.0
        for <linux-block@vger.kernel.org>; Fri, 23 Jul 2021 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vYTn7+eGEI7Q1RMA/3vAFLMTCXFX8Sw72SaEzbA1bQ8=;
        b=V8v8yV910H1isJ5XsUEWBXTYWsOJ2rSQR7nS/ui+zSIfggH79Jz0nHagCxU0muqQcm
         JttIj9mM47GOQtuaCkUz0PdM6rv4stUaa5Gd+8SFgeaxz+uPcAmM1u2RuIlcbNy2pQUY
         MhkmLzKxElBo6mP+yWQljBaqw9zHg+M3fWs+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vYTn7+eGEI7Q1RMA/3vAFLMTCXFX8Sw72SaEzbA1bQ8=;
        b=LVdJ/wlDCvOK2/EkXvbGeAp5btm8qML0PS2qt6vXXa33OP7Get0Q9RCHSdXOqa7meH
         FW0yjAnno+qhdG/V3vi3FUNVTFfDp9vGovdAGo0/A1ryombqSxwVhCuVEC1TQ5uJ0LZp
         aAHGUTTB6fEbyx1GRnipelpe5Phy40x8WkW1LyoSfv+kNzKBGmNIwhhFSgoYZ+fBcktp
         2v90m71RaMDj8sqv+NF5lPD9cR9XvWcF7upNtLB53fxVfHPmSeECdnehQD0H2ghAblZ2
         BqG+1GeDjrGBWXP8Crlg2tv2grmDeQvJY7Wg8fgbQ5ZP7ChIBpxSxTa3uq1qAARilqje
         OH5Q==
X-Gm-Message-State: AOAM530O7t2w7Wyuz+zRdjA/cpqHGfUs5Z8tRtqkHL1tzlnE8eyrKVgY
        QIkBDzxG5mAzpJN5zdFIOYIQLQ==
X-Google-Smtp-Source: ABdhPJwGpoxHTO4J2/ehZrrS3qtHYMIaXCgBaMBERWm4W1J7IjUfFio6kzqtA0uhTGi9EX/Y5fMD9g==
X-Received: by 2002:a17:903:22ca:b029:12b:9109:4097 with SMTP id y10-20020a17090322cab029012b91094097mr5425468plg.54.1627078934265;
        Fri, 23 Jul 2021 15:22:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12sm28581207pjd.39.2021.07.23.15.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:22:13 -0700 (PDT)
Date:   Fri, 23 Jul 2021 15:22:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Denis Efremov <efremov@linux.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] block/floppy: Prevent
 kernel-infoleak in raw_cmd_copyout()
Message-ID: <202107231520.32B389411@keescook>
References: <20200728141946.426245-1-yepeilin.cs@gmail.com>
 <20200729115157.8519-1-yepeilin.cs@gmail.com>
 <20200729125820.GB1840@kadam>
 <f2cf6137-987a-ab41-d88a-6828d46c255f@linux.com>
 <CAK8P3a20SEoYCrp3jOK32oZc9OkiPv+1KTjNZ2GxLbHpY4WexQ@mail.gmail.com>
 <202007301056.D3BD1805B0@keescook>
 <CAK8P3a2oUgdaYicdHwWvCY-HqjrcBAEzYA5yc5Gw14RLLoLdug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2oUgdaYicdHwWvCY-HqjrcBAEzYA5yc5Gw14RLLoLdug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 30, 2020 at 10:45:02PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 30, 2020 at 8:10 PM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Jul 30, 2020 at 10:11:07AM +0200, Arnd Bergmann wrote:
> >
> > test_stackinit.c intended to use six cases (where "full" is in the sense
> > of "all members are named", this is intentionally testing the behavior
> > of padding hole initialization):
> 
> Ok, so I read that correctly, thanks for confirming.
> 
> > >
> > >    struct test_big_hole var = *arg;
> >
> > So this one is a "whole structure copy" which I didn't have any tests
> > for, since I'd (perhaps inappropriately) assumed would be accomplished
> > with memcpy() internally, which means the incoming "*arg"'s padding holes
> > would be copied as-is. If the compiler is actually doing per-member copies
> > and leaving holes in "var" untouched, that's unexpected, so clearly that
> > needs to be added to test_stackinit.c! :)
> 
> For some reason I remembered this not turning into a memcpy()
> somewhere, but I can't reproduce it in any of my recent attempts,
> just like what Denis found.
> 
> > > or the a constructor like
> > >
> > >   struct test_big_hole var;
> > >   var = (struct test_big_hole){ .one = arg->one, .two=arg->two, .three
> > > = arg->three, .four = arg->four };
> > >
> > > Kees, do you know whether those two would behave differently?
> > > Would it make sense to also check for those, or am I perhaps
> > > misreading your code and it already gets checked?
> >
> > I *think* the above constructor would be covered under "full runtime
> > init", but it does also seem likely it would be handled similarly to
> > the "whole structure copy" in the previous example.
> 
> I would assume that at least with C99 it is more like the
> "whole structure copy", based on the standard language of
> 
>   "The value of the compound literal is that of an unnamed
>   object initialized by the initializer list. If the compound literal
>   occurs outside the body of a function, the object has static
>   storage duration; otherwise, it has automatic storage duration
>   associated with the enclosing block."
> 
> > I will go add more tests...
> 
> Thanks!

Well, nearly exactly a year later, I've finally done this. :P

https://lore.kernel.org/lkml/20210723221933.3431999-1-keescook@chromium.org

-- 
Kees Cook
