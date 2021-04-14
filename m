Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E7C433ED
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 20:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F81761179
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 20:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhDNUM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhDNUM4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 16:12:56 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3FCC061756
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 13:12:31 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id b18so5803003vso.7
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZylcG8gLvFNIkglYp5Xb+SZrmXw8uOYOYoFsEhIqSSQ=;
        b=tBCuUu5ebtiahNV5/ZHRzBlNBI4dgYJSEuBfVp5V3JQjWXsSc30TA4UPEw2Brzr/LW
         AV7r9dz7+13mXvZ9xgsgDFD4i4Dv7Kv7AiLEgF6PKbmLOAXD2ng6iN1nWyc9ve8eiijV
         6SmIBLUJzkbrEgFNq9Bo1ak4ZmEAJPFQRWxqd7E+e7JkYvL5i4vD3tPw6i3PJISx/bLe
         u63EuKeujieZnQ1SNAiwMnpFCbbx/eAV5Co3E53rtZR+n9BOk0HFNyd98kv84yauUumm
         gepP8hpz22Ih6JFBcPOSouGNQq86s34o3ngNTP1rkrfJNWcPnpfYvB+C6Z4wTTol/SKu
         0g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZylcG8gLvFNIkglYp5Xb+SZrmXw8uOYOYoFsEhIqSSQ=;
        b=cjELpHIIBwrtr6J/2a0WHkralwkzzorYwSEQEqvU0k+gUbH4T0ZqQ/IIEmIzE8lsPu
         lLUaq9V/OOpO9uvneiijdpLFqYw2kq2/QyIJ2JuMdkthazlL2m1w8ejJG7DJaGxNxsDR
         m9Xx8fF0fD5JbEV80zxSQ0fPEQsfYZ/3lf1MhS2M8KFaCJvQlHmVdniuXCHbXk42ETYO
         xj3B564R+l4vauGjaxGXfL5p/2CQls9XQZL/BbK8psW/rNby1S72WxFfFjPxxKKPq4hb
         IHXD3R8GT9i4JA8jtoOPxO5HoDSDT0Sfotv4EvioTLQvGzM46w8AXBpxFQUrHI3yyJWE
         Rnpg==
X-Gm-Message-State: AOAM5333VTrotj1YPVI7Mofl3PBZEP24iLCvzGp1suLU8B0MnmaMo2QJ
        7071Nxx/230IJR7X9x/OTzn3n4SQ8kXaPJ3jrIKH1w==
X-Google-Smtp-Source: ABdhPJwLuFC3/ivusJFFCYZE8w7wGONyToV7VTx2K0XSE0kGS8JhAn0X+tITyQ5qUOIF6DA4wWzcwKi/ka/Ysdc0n9U=
X-Received: by 2002:a67:ee48:: with SMTP id g8mr11738347vsp.23.1618431150228;
 Wed, 14 Apr 2021 13:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210330231602.1223216-1-egranata@google.com> <YHQQL1OTOdnuOYUW@stefanha-x1.localdomain>
 <20210412094217.GA981912@infradead.org> <YHarc5gGgjyQOaA+@stefanha-x1.localdomain>
In-Reply-To: <YHarc5gGgjyQOaA+@stefanha-x1.localdomain>
From:   Enrico Granata <egranata@google.com>
Date:   Wed, 14 Apr 2021 14:12:18 -0600
Message-ID: <CAPR809uOOsULgAA647=g+GTY32KbevqytsUfQACCfuuztqdSzg@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: Add support for lifetime feature
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

First and foremost thanks for the feedback on the code. I will send
out an up-to-date patch with those comments addressed ASAP

As for the broader issue, I am definitely happy to incorporate any
feedback and work to improve the spec, but looking at embedded storage
devices both eMMC and UFS seem to me to be exposing the attributes
that are included in the virtio-blk lifetime feature, and the same
data is also used by the Android Open Source Project for Health HAL.
It does seem like this format has a lot of practical adoption in the
wider industry and that makes it fairly trivial to implement in a lot
of common embedded systems. Having this immediate path to adoption in
a variety of scenarios seems to me in and of itself valuable.

Thanks,
- Enrico

On Wed, Apr 14, 2021 at 2:44 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, Apr 12, 2021 at 10:42:17AM +0100, Christoph Hellwig wrote:
> > A note to the virtio committee:  eMMC is the worst of all the currently
> > active storage standards by a large margin.  It defines very strange
> > ad-hoc interfaces that expose very specific internals and often provides
> > very poor abstractions.  It would be great it you could reach out to the
> > wider storage community before taking bad ideas from the eMMC standard
> > and putting it into virtio.
>
> As Michael mentioned, there is still time to change the virtio-blk spec
> since this feature hasn't been released yet.
>
> Why exactly is exposing eMMC-style lifetime information problematic?
>
> Can you and Enrico discuss the use case to figure out an alternative
> interface?
>
> Thanks,
> Stefan
