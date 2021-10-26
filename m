Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB74C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 01:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6BE6023B
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 01:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhJZBp0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 21:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhJZBpZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 21:45:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB690C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 18:43:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m26so12708609pff.3
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 18:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3QNntbi6F0Q5EQIPy2H7a8oNts2Eyp4p/Xn7HNIof4=;
        b=6I9ExCZXDjetUnWB97k4kiOjvXsb46qPrDkZKZEtP0yYIvx8GFEPOVESL8tETTem0s
         uMxYAvOYuVABEFafvkY+CfHrJhIxDvRe9M262+xBUmx1zsVSJMhWgzgtccK5H3xfSZ7o
         nqVxXoJ3pAOGeWyevOLIbM9sU15/was3trfrEXpHPaDYMLU2qcUAvmVm4mBqoQGLVzZi
         kfAFaTlu5+s76CRog1FBM7RWYrJZnG+EpPLJFn0c0GIaBfRvNspnRLEG1zhgrofS4aPq
         BYBoyZ3XjCWaSCwQqT6mLEwFgtBemVUOklCfwWfOBv/l6vq27zpEUfcnSJZy+r/gt600
         nnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3QNntbi6F0Q5EQIPy2H7a8oNts2Eyp4p/Xn7HNIof4=;
        b=ynWlf7N3MpWPItLxx94c2GQQulDNS40jMTntVp2nspWYExA39645pye+g+RrU7aWnb
         7X2Wdb3HkB1JuDBj4J8N7bQASBNOeMAlO9VAuQlZSYMuXnlk7qT/G47YxcY9MnJMcKWQ
         3NXvJSUWzINqERwCPpA+wr6TCnFFDeUDqv/3WumW5YSYCODcSQ9S7+K/WKNcEpC5Su/9
         ax6oLAUp+rvrMuC5cXJGsc41W3MB+MVUFFVfspKXktTmXmO3GdkBAB78YlMxAl/ckCoG
         DjpaPJci1/crU2Hh6ueZ+NmpbEFG3lP9BhHy9b7WxwFd6VVEAboioM50YTQr0G4zflh8
         /njQ==
X-Gm-Message-State: AOAM532SM6s40kl/jJQOwVR0gXoOhDzQowBoPEdHtlqVnJy0J+QWdqup
        mAhHMMmuxTq/hcs9VteAKp81eOi5l6ZwMDQYMqaPpg==
X-Google-Smtp-Source: ABdhPJy1bgYCv5vnItFJsKHYvhi32488pwwKAHbT9aXBTMl76S4vhvH/WbPtblFWCNALYE4rFvqzmVg5ElJIAz3kVaM=
X-Received: by 2002:a05:6a00:15c8:b0:44d:9f7e:ece2 with SMTP id
 o8-20020a056a0015c800b0044d9f7eece2mr22508213pfu.86.1635212582401; Mon, 25
 Oct 2021 18:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211019073641.2323410-1-hch@lst.de> <20211019073641.2323410-3-hch@lst.de>
 <YXFtwcAC0WyxIWIC@angband.pl> <20211022055515.GA21767@lst.de> <CAPcyv4joX3K36ovKn2K95iDtW77jJwoAgAs5JSRMcETff=-brg@mail.gmail.com>
In-Reply-To: <CAPcyv4joX3K36ovKn2K95iDtW77jJwoAgAs5JSRMcETff=-brg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Oct 2021 18:42:51 -0700
Message-ID: <CAPcyv4gFCRs_OJ1TutBi-tmWWS2pU_D+bqJVwCcp=7dCMkhGEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] memremap: remove support for external pgmap refcounts
To:     Christoph Hellwig <hch@lst.de>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 22, 2021 at 8:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Oct 21, 2021 at 10:55 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Oct 21, 2021 at 03:40:17PM +0200, Adam Borowski wrote:
> > > This breaks at least drivers/pci/p2pdma.c:222
> >
> > Indeed.  I've updated this patch, but the fix we need to urgently
> > get into 5.15-rc is the first one only anyway.
> >
> > nvdimm maintainers, can you please act on it ASAP?
>
> Yes, I have been pulled in many directions this past week, but I do
> plan to get this queued for v5.15-rc7.

Ok, this is passing all my tests and will be pushed out to -next tonight.
