Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A943C433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 19:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiBBTmh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 14:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbiBBTmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Feb 2022 14:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643830957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ll15QSD/t84/Hy62h63iGXwWFrEUBsyZcwen7Ur2tv4=;
        b=hBJvw3DuBe80zmhkFZistLfJ9mhgGRxU3crl6QSFAF6XzTTUhhzCkRFuRnIWXgfr863y5w
        2sIAmKljWKSjhtXmxqClBk78r1ceN3JBNcPBvW/m1D8tvzkkAh+0ACtvNtqzl5aOeDzYZU
        AhExsscTN5hogfJNkHTvo+xdwxrrDhg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-rbDbU8xqOuqOZCI5NEIvhw-1; Wed, 02 Feb 2022 14:42:35 -0500
X-MC-Unique: rbDbU8xqOuqOZCI5NEIvhw-1
Received: by mail-qt1-f197.google.com with SMTP id g13-20020ac8774d000000b002cf75f5b13aso152092qtu.11
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 11:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ll15QSD/t84/Hy62h63iGXwWFrEUBsyZcwen7Ur2tv4=;
        b=CbdrBUYJpINxImtan629khi5mo33JjVcTNTyFBQcYFnBfms+4i1E3SWF0Y3o6mxcgb
         7DKgmAuB/bfPwIJj3bIetLI6Bf6AAGrQEbpRNNLWRUpV7oK0LbUM1CYi4+RGI5fs9i0T
         8yOhVPRwcnQHzJJh9tvm9KxE9+x2W3bWmdi+IcTwRMv4igGy6Fn/pUtvfJBEl3bZRfAL
         IVuyr+SBCCfITtpv7MUoxarirzb/A6iNUmlISHb2cH5VTN0keOFw2VzRVjhuhHznhxBn
         tsH2wm0+Myz0PP9eIpsAxm4FKLtXjLWRBlYnUU2JDQlOzE1HInUpSJ5Lc46k8QxqH5Vj
         aBXw==
X-Gm-Message-State: AOAM531LH7J4XD//Piu3U+Cv2DibtDeMYByPHRusvyDxdyJXnuQIr4N7
        vUwx7rrSzoe1YynIXTqjxQidpARP2yAh77Tr7dJ31+INtgmXYmotCJE6d6NbZPp2AJBq3eSIYvd
        vwksaX3PV9myMeJ/T5FipOw==
X-Received: by 2002:a05:6214:1d0b:: with SMTP id e11mr28129208qvd.50.1643830955516;
        Wed, 02 Feb 2022 11:42:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzd2HY0NfWrAJF52rEsggSv2Saz5rMDX7hMk30XVxVEf046yTiVaBhX0lsvYwv7x9JpaXU/Wg==
X-Received: by 2002:a05:6214:1d0b:: with SMTP id e11mr28129197qvd.50.1643830955330;
        Wed, 02 Feb 2022 11:42:35 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h6sm14065391qko.7.2022.02.02.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 11:42:34 -0800 (PST)
Date:   Wed, 2 Feb 2022 14:42:33 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: Re: improve the bio cloning interface v2
Message-ID: <YfreqbCOPYFrQm73@redhat.com>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 02 2022 at 11:00P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Hi Jens,
> 
> this series changes the bio cloning interface to match the rest changes
> to the bio allocation interface and passes the block_device and operation
> to the cloning helpers.  In addition it renames the cloning helpers to
> be more descriptive.
> 
> To get there it requires a bit of refactoring in the device mapper code.
> 
> Changes since v1:
>  - rebased to the lastest for-5.18/block tree
>  - fix a fatal double initialization in device mapper
> 
> A git tree is also available here:
> 
>     git://git.infradead.org/users/hch/block.git bio_alloc-cleanup-part2
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bio_alloc-cleanup-part2
> 
> Diffstat:
>  Documentation/block/biodoc.rst   |    5 -
>  block/bio-integrity.c            |    1 
>  block/bio.c                      |  106 +++++++++++++-----------
>  block/blk-crypto.c               |    1 
>  block/blk-mq.c                   |    4 
>  block/bounce.c                   |    3 
>  drivers/block/drbd/drbd_req.c    |    5 -
>  drivers/block/drbd/drbd_worker.c |    4 
>  drivers/block/pktcdvd.c          |    4 
>  drivers/md/bcache/request.c      |    6 -
>  drivers/md/dm-cache-target.c     |   26 ++----
>  drivers/md/dm-crypt.c            |   11 +-
>  drivers/md/dm-zoned-target.c     |    3 
>  drivers/md/dm.c                  |  166 +++++++++++++--------------------------
>  drivers/md/md-faulty.c           |    4 
>  drivers/md/md-multipath.c        |    4 
>  drivers/md/md.c                  |    5 -
>  drivers/md/raid1.c               |   34 +++----
>  drivers/md/raid10.c              |   16 +--
>  drivers/md/raid5.c               |    4 
>  fs/btrfs/extent_io.c             |    4 
>  include/linux/bio.h              |    6 -
>  22 files changed, 183 insertions(+), 239 deletions(-)
> 

Looks good, for all:

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

I have some DM core changes for 5.18 that I need to make and this
patchset offers enough DM churn that I'd like to base my changes
ontop.  So I'd appreciate it if this patchset could land in block's
for-5.18 ASAP.

Thanks,
Mike

