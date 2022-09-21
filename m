Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE47C6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 15:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIUPIw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIUPIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 11:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6231379A4C
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663772926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ptp1oLSt177eSTGNW8YxvUlUM4rs67KrLKfl9pj1Lys=;
        b=iXwIAMIZtd1F+2omRf5mhg+42DheRLbxGcX2NBPrfqqGiGgePj2TAZqid8EYSBNq7mzZDT
        LL3ZDp3tVWo3egM3nc1s3k2KlSV9+7eokMLR7sELWEWf6v02VMGcd6CDW55qRuVKoV0IHa
        L5uIX/9Z5lw0yWLWrzzlF8rlzohiapc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-mKR6JKTLOiCkV_YZHq5sJg-1; Wed, 21 Sep 2022 11:08:45 -0400
X-MC-Unique: mKR6JKTLOiCkV_YZHq5sJg-1
Received: by mail-qt1-f200.google.com with SMTP id ay22-20020a05622a229600b0035bbb349e79so4371906qtb.13
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 08:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ptp1oLSt177eSTGNW8YxvUlUM4rs67KrLKfl9pj1Lys=;
        b=1J33ZKov77u9O5Sv7K8/eIaT8740aKZufEiB8KjAEdB6RaULl48bR766YdHKN6FlgT
         iCvkZOZ5YtD0tv9hmxPsd6vyMjvJ1upGvZL2/DB95ns4uN5+y+HRElcbi9LBUq4vUBVU
         H2fTIMx74AiEnNxacvcFdFEaWPxmm2tpWYObLV/tGYE65+qTQiAtTulQOOA+PLhjCOAD
         pLKOD5r/FMky7HEY7Psuu9RyoDzOD6YRB3pJfa5Sa9ZfkIu53N39Ka7t3+LeHbawwVHs
         9slcW+gqymhkRbGLQdexIPJJLWad2BgDHHuCyQkL0AKskdT9E+sKtbqw+x1Ky5o22s/y
         OA7w==
X-Gm-Message-State: ACrzQf0br2u3RLZnoiBC2h+uEAKvNBSwslYvkoxJdm5o6XXmyQOdWgsG
        hFOT6Q+4Ozci5FLRRkAdBOyFYiZoJ6SWk5r8gAvg//7H1KnztEbky4Wlube91TKDSFenlM5Z4pZ
        PrplSP1pNWdTY+yJqh3zLLA==
X-Received: by 2002:ac8:7d85:0:b0:35b:f5b1:63df with SMTP id c5-20020ac87d85000000b0035bf5b163dfmr23884647qtd.113.1663772924839;
        Wed, 21 Sep 2022 08:08:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4EexL7l8DWx+8oreUyHWUiCWf8NA2huyVubxlwg6z5TXJwF+130R2NsOA173MiJm0z6yEZRA==
X-Received: by 2002:ac8:7d85:0:b0:35b:f5b1:63df with SMTP id c5-20020ac87d85000000b0035bf5b163dfmr23884597qtd.113.1663772924537;
        Wed, 21 Sep 2022 08:08:44 -0700 (PDT)
Received: from localhost ([217.138.198.196])
        by smtp.gmail.com with ESMTPSA id w7-20020ac857c7000000b0035bbb6268e2sm2041812qta.67.2022.09.21.08.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:08:44 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:08:43 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Daniil Lunev <dlunev@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Stefan Hajnoczi <stefanha@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Message-ID: <Yyso+9ChDJQUf9B1@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora>
 <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
 <Yylvvm3zVgqpqDrm@infradead.org>
 <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
 <YymkSDsFVVg1nbDP@infradead.org>
 <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 20 2022 at  5:48P -0400,
Daniil Lunev <dlunev@google.com> wrote:

> > There is no such thing as WRITE UNAVAILABLE in NVMe.
> Apologize, that is WRITE UNCORRECTABLE. Chapter 3.2.7 of
> NVM Express NVM Command Set Specification 1.0b
> 
> > That being siad you still haven't actually explained what problem
> > you're even trying to solve.
> 
> The specific problem is the following:
> * There is an thinpool over a physical device
> * There are multiple logical volumes over the thin pool
> * Each logical volume has an independent file system and an
>   independent application running over it
> * Each application is potentially allowed to consume the entirety
>   of the disk space - there is no strict size limit for application
> * Applications need to pre-allocate space sometime, for which
>   they use fallocate. Once the operation succeeded, the application
>   assumed the space is guaranteed to be there for it.
> * Since filesystems on the volumes are independent, filesystem
>   level enforcement of size constraints is impossible and the only
>   common level is the thin pool, thus, each fallocate has to find its
>   representation in thin pool one way or another - otherwise you
>   may end up in the situation, where FS thinks it has allocated space
>   but when it tries to actually write it, the thin pool is already
>   exhausted.
> * Hole-Punching fallocate will not reach the thin pool, so the only
>   solution presently is zero-writing pre-allocate.
> * Not all storage devices support zero-writing efficiently - apart
>   from NVMe being or not being capable of doing efficient write
>   zero - changing which is easier said than done, and would take
>   years - there are also other types of storage devices that do not
>   have WRITE ZERO capability in the first place or have it in a
>   peculiar way. And adding custom WRITE ZERO to LVM would be
>   arguably a much bigger hack.
> * Thus, a provisioning block operation allows an interface specific
>   operation that guarantees the presence of the block in the
>   mapped space. LVM Thin-pool itself is the primary target for our
>   use case but the argument is that this operation maps well to
>   other interfaces which allow thinly provisioned units.

Thanks for this overview. Should help level-set others.

Adding fallocate support has been a long-standing dm-thin TODO item
for me. I just never got around to it. So thanks to Sarthak, you and
anyone else who had a hand in developing this.

I had a look at the DM thin implementation and it looks pretty simple
(doesn't require a thin-metadata change, etc).  I'll look closer at
the broader implementation (block, etc) but I'm encouraged by what I'm
seeing.

Mike

