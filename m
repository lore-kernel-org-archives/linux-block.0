Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97A8C4332F
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 18:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiC3SIb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349748AbiC3SI0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 14:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CC023DA4B
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648663590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWSt8FFFTI4rhck3dPnwbJuLsSit8PUXxQiArFyosm8=;
        b=WEK//vBvxC37iXc3DA9hZctU8Z54IiLfgECTawzCJcEpeKzVTrMOBl8wyyw7l92iUMM3EN
        HmJMTVHs/045r/tyVIVehFYEtwULNvJ382IAKK1HyDPyOq8SO0DC5+JxiABkBPvPlbcxBf
        kBnEmrWPMpC7eNUynP0K5V8URs9oDRk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-lRM0IlUsPv-MC-E-ViBk5g-1; Wed, 30 Mar 2022 14:06:29 -0400
X-MC-Unique: lRM0IlUsPv-MC-E-ViBk5g-1
Received: by mail-qv1-f69.google.com with SMTP id h18-20020a05621402f200b00440cedaa9a2so16635205qvu.17
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 11:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWSt8FFFTI4rhck3dPnwbJuLsSit8PUXxQiArFyosm8=;
        b=i1DBgWmnVlk+U1pBBov53SP8jjEj0dFUh14Dr5/jW43xiFuwrUDFHvd6SEUolhFsUT
         KhoD3RyvRCgk2LVRALC7Xh/mEAWPP3vFYTgStcf4Pp1o01zQcSPLMDleS6XtHx3NcwQF
         Uh3Paiy2H1QAn84LvRns4e0Q0BKw1Q87/7wg3vFTyOxk4tZez1f39qMLtXshWVAo9Qes
         cXj0pTPFG+zB/LaxdgvuSu+0vvvMBJ7GGWiCETS8OIoW9Hx5I7dGc9zA+/m91Mx+4ifd
         BL/nGjme685jWIPcMVOn+i7Z2/HZ2yPV8Xu1F0v5z4qRjf9NKUtuo/bXgv/HeiVYD1fB
         UAkQ==
X-Gm-Message-State: AOAM533t8/ic3XNQH4gFyhgLFE5kTU3Gtc/Nk7Iy1OhfthWpe1gfFb6B
        UcJ/9gpJNeyvE1+fi8S8YQfmoYRXucQQbUO/D3+XjYsm/nVJ/xIHOU6rNn+Kkp8G73F5ixca9AM
        0Iut0rDpeCy/YgFdKPZW+Aw==
X-Received: by 2002:ad4:5be3:0:b0:441:7bd1:29bd with SMTP id k3-20020ad45be3000000b004417bd129bdmr733374qvc.14.1648663586921;
        Wed, 30 Mar 2022 11:06:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkima55vXfIXB4/YhL8vxRAGITI8NXaa0gII7X9gZDBJaWlIZfDnbZH36cgG+Ixq8NEncA6A==
X-Received: by 2002:ad4:5be3:0:b0:441:7bd1:29bd with SMTP id k3-20020ad45be3000000b004417bd129bdmr733356qvc.14.1648663586730;
        Wed, 30 Mar 2022 11:06:26 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u20-20020a05620a455400b0067ec0628661sm12639056qkp.110.2022.03.30.11.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:06:26 -0700 (PDT)
Date:   Wed, 30 Mar 2022 14:06:25 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: state of drbd in mainline
Message-ID: <YkScIas+/Ev0trcZ@redhat.com>
References: <20220329070618.GA20396@lst.de>
 <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de>
 <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
 <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
 <CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
 <3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
 <CADGDV=WcTSSC70yG61dazo-WyoLOzp3r+nOk-Eg2x_Ncx=3nRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGDV=WcTSSC70yG61dazo-WyoLOzp3r+nOk-Eg2x_Ncx=3nRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 30 2022 at 11:23P -0400,
Philipp Reisner <philipp.reisner@linbit.com> wrote:

> > > Jens, my intention is to keep it in-tree, and at some point update it.
> > > Regarding your questions:
> >
> > That'd be great, but it's been years since there was any significant
> > updates to the in-kernel drbd... I would strongly suggest that the
> > in-kernel be brought closer to what people are mostly running, as it
> > stands it's basically unmaintained.
> 
> The changes we worked on over many Years in the more recent drbd-9.x
> branches are just too fundamental to do them in small chunks, we could
> upstream bit by bit.  We need to get that reviewed in a big series.  If I
> started to dump them on linux-block right away, nobody would look at it
> seriously, since it would be too much.  I intend to get people from red
> hat/suse assigned to do such a review. Then we will do that on linux-block,
> so that everyone who cares sees what happens.

Why do you think Red Hat, SUSE or any other distro vendor's engineers
should be made to review what amounts to be a massive dump of changes
you developed over years?

Presummably you have heard of "upstream first"!?  Why do you think it
doesn't apply to drbd?

It'd be one thing if drbd never went upstream but _it did_.  As is
your development model is completely wrong.

Mike

