Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAF3C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 16:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B762065F
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 16:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DElrh53n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgEVQlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 12:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgEVQlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 12:41:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22971C05BD43
        for <linux-block@vger.kernel.org>; Fri, 22 May 2020 09:41:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ee19so4988958qvb.11
        for <linux-block@vger.kernel.org>; Fri, 22 May 2020 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gic/1R/3waf7AEbQmqRilav4LMcZDIm9OqkrPl/dkdw=;
        b=DElrh53nseZZ1yD/ZQp65i6zsVsBBVHY12bldCdkwCt4iRHoIjs3Ih3IocvxPI7Be+
         T13Wj28LaLIE/ghO6OxYczOIO5PG7hDaPXclu9BTjpDQgQPDu8Bb+IMDpwkuQ9RFXPWl
         1DVGbvTNqX5BBzHwFqP2XdGX5ZXCUpxAVQuZNsWscvW/gqYFdE2q9J2iVT0uqfoqTuNr
         y/onfJxz+1nGbbNLO/oh5GBoYj6f0XKphOV6GzxhZrOvbi1jKZsi5OD3UPyUZsfSD5/t
         CTz7+RRHcmxa49u5/+SofSW0aSwudQKnUBjgtIXJ1rL1AWgOy6yTQ1hQtYnqwQZ4Qqb+
         ZETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gic/1R/3waf7AEbQmqRilav4LMcZDIm9OqkrPl/dkdw=;
        b=CDMHT+FGoUlsGCbUlPy1Wmlm8AMQeuurBA2TXmMJYyhL6Ai1MFmqx7QjiFzSw8QcAM
         BoyKvGc6/rtNDQZHELk+PFP77APmFfGhodF3tJt2EGYzW9MhJd8+aPfB6D85CVoQGJka
         GF8pHsjfxjRcrs5ho320GCbQ8Sgetd1KFbEnT4KU/wdALo7Ku5RNCKFjZpN9DB3iZltO
         1bxpFqPcP1/tcGbPSAR9XTxHVNCvNar4lj9Hi3mAZaL71SPgSr0fBHqjCjZ7PzkE4lCM
         umWIXiM547pdK1YAsrEsaYE6XH+JXUFSjG1ZShGlWXZtIqkajJmZI/5qhKiN9nCX+IhF
         +9yg==
X-Gm-Message-State: AOAM530tQq2+Y01aXUgrp315/Cc5ZU5kfdxc1OJK4qniqoLgJpt8ThRy
        2pPV/0PIO5EU4z4hRmr3FxJtKA==
X-Google-Smtp-Source: ABdhPJzfZmjxB95p6UPPpZEUJqs6F8nDa2qW9dBg6llK23fiXXCME4T1/ceTY4MQppy88PcB99Terw==
X-Received: by 2002:a05:6214:104a:: with SMTP id l10mr4584181qvr.98.1590165678134;
        Fri, 22 May 2020 09:41:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d6sm7573800qkj.72.2020.05.22.09.41.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 09:41:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jcAjV-0006cz-75; Fri, 22 May 2020 13:41:17 -0300
Date:   Fri, 22 May 2020 13:41:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] block/rnbd: Fix an IS_ERR() vs NULL check in
 find_or_create_sess()
Message-ID: <20200522164117.GJ17583@ziepe.ca>
References: <20200519120347.GD42765@mwanda>
 <CAMGffEnuk2WfWmwjKy_Sqcuf_xKwzrPpE_o8j3nHM30ADr8HVw@mail.gmail.com>
 <CAMGffEmC215iOmtT_iZizey=jnbgWneE5f5zapYvdJi5WYDM1w@mail.gmail.com>
 <20200522144831.GH17583@ziepe.ca>
 <20200522154403.GN30374@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522154403.GN30374@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 22, 2020 at 06:44:03PM +0300, Dan Carpenter wrote:
> On Fri, May 22, 2020 at 11:48:31AM -0300, Jason Gunthorpe wrote:
> > On Fri, May 22, 2020 at 07:13:08AM +0200, Jinpu Wang wrote:
> > > On Tue, May 19, 2020 at 2:52 PM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> > > >
> > > > On Tue, May 19, 2020 at 2:04 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > >
> > > > > The alloc_sess() function returns error pointers, it never returns NULL.
> > > > >
> > > > > Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
> > > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Thanks Dan,
> > > > Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > 
> > > Hi Jason,
> > > 
> > > Could you also queue this fix for for-next?
> > 
> > Uhh.. Yes OK, but if it doesn't get cc'd to linux-rdma I won't see it..
> > 
> 
> I suspect that we should update MAINTAINERS so that
> ./scripts/get_maintainer.pl gives the right lists.  Proabably all
> drivers/block/rnbd/ patches are supposed to go through you?

I think Jens will take then once everything is merged, it is just for
the next few weeks

Jason
