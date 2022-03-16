Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E3BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 00:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352698AbiCPADn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 20:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbiCPADm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 20:03:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8005576A
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:02:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hw13so880853ejc.9
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZUG3daTjBSNeQ09LqP7cMF4OOdcfPX1L9Gvauwm3p4=;
        b=cNgJESNNXO6CVxh1c4d+IFacASUh8b8hgVKzMhf0/q+zag5BY3uZQIOsYYfoyq5v8o
         IhePtWh0pGptQ8qaIWEZ9Z/zv09alp3AXeFV1V4XZ2OoY8X6MAwlF5HKMjpar3uNPtFm
         ygSfHnZ8QD0cB6Yj7WRQ3IHzNH/l3OyZSY/3fCDCpwVIfWYy/6jA4VassSG4GsJUrTwo
         zXqIviTwFJiQf8MjjTwCtIREDtGBO5h4bt40DxwnQmmDI9mV99EdLYSG+eHM4Cv3gicF
         ZYzHFnrWPAIcDyFPZvWnIybAMgGlcum3r7hvW6j9MY0MFkON9H2SBXz5gtlzGLYN0KbE
         uGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZUG3daTjBSNeQ09LqP7cMF4OOdcfPX1L9Gvauwm3p4=;
        b=y4kM12kzmlXJ0LD0V5IlcDx9aqhVVLRJAr4V465iO9aUaZIXnhQ+cwAQHWuuigoRa0
         /c+LLTq0JrlnfawmTRIhEjFzT1Inz69iCWPHNpN8GMZ1JdLgzr3FMuLm9l4eSlv3S/lk
         JoDGMotpmnTUfsGI2Yd8D7FealHX8IlazUn5/ofRrmauNlUe1CM0y1eMyy3BAkwr9mJ2
         +z0mbilF5gzOMeV075q3SLp0tQe4TN9Jgd0V+ZNb23/Gab01tgec1vWGYqIdDDb1QKIz
         28kLsh6KKNU0GUbvqA8VSxnAHTsC646H1rypXmP1Vg6zcKpx857fqrxd79LJI7FQ0yoI
         FczQ==
X-Gm-Message-State: AOAM532v91ewUQdBROdeQ8ZRruPfXXCfhKQrTXahBAH4c45iWBf7yXtO
        zdu5hls0FbAj3l66QjqkVP3odWPufIpJThK52cN2GA==
X-Google-Smtp-Source: ABdhPJwOS0I4hArhmI83705iboyKEE6Janp7V5RBBNVLVBJ2XiVer4+vbsGzg4VWhvkr9vEvKQ8DOpavrHz0PqdnhEM=
X-Received: by 2002:a17:907:8692:b0:6da:866c:6355 with SMTP id
 qa18-20020a170907869200b006da866c6355mr25354574ejc.174.1647388947747; Tue, 15
 Mar 2022 17:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220315172221.9522-1-bgeffon@google.com> <YjDMo35Q/cvPLkxu@casper.infradead.org>
 <CADyq12yK+qODV2ut1acjwkyXKDbh_YS3MHpRoJaq_g9G1HAyEw@mail.gmail.com> <YjDQj9dr34Jpw3cU@casper.infradead.org>
In-Reply-To: <YjDQj9dr34Jpw3cU@casper.infradead.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 15 Mar 2022 20:01:51 -0400
Message-ID: <CADyq12y32GFr9FmJ2-u1rarozb_JegJPeQB8L9q1E3LZJ20zbQ@mail.gmail.com>
Subject: Re: [PATCH] zram: Add a huge_idle writeback mode
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 1:44 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Mar 15, 2022 at 01:34:21PM -0400, Brian Geffon wrote:
> > On Tue, Mar 15, 2022 at 1:28 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Mar 15, 2022 at 10:22:21AM -0700, Brian Geffon wrote:
> > > > Today it's only possible to write back as a page, idle, or huge.
> > > > A user might want to writeback pages which are huge and idle first
> > > > as these idle pages do not require decompression and make a good
> > > > first pass for writeback.
> > >
> > > We're moving towards having many different sizes of page in play,
> > > not just PMD and PTE sizes.  Is this patch actually a good idea in
> > > a case where we have, eg, a 32kB anonymous page on a system with 4kB
> > > pages?  How should zram handle this case?  What's our cut-off for
> > > declaring a page to be "huge"?
> > >
> >
> > Huge isn't a great term IMO, but it is what it is. ZRAM_HUGE is used
> > to identify pages which are incompressible. Since zram is a block
> > device which presents PAGE_SIZED blocks, do these new changes which
> > involve many different page sizes matter as that seems orthogonal to
> > the block subsystem. Correct me if I'm misunderstanding.
>
> Oh, so ZRAM's concept of huge is not the same as the "huge" in
> "hugetlbfs" or "THP"?  That's not at all confusing ...

I do not disagree, but there isn't much that can be done about it at
this point given the sysfs file takes an argument called "huge"
