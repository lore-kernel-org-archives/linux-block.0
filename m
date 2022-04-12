Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867EBC47082
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 10:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244605AbiDLKLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380842AbiDLIWn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 04:22:43 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13554F9C4
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 00:52:16 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so2020188pjk.4
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 00:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PdNJO9jKeiU6aIag2xubkGaXQwXjChJyaN34FakShGY=;
        b=VrgVy42r9B8rnlG+sgfQT+fQ3/G8oe1qHTrzX+hKiU1Tbd4bw68NxvBfOlBA0VorU3
         MWduohK5uNM53RSDrF/Hhhsbxd/ZylnA8PQPOsOqk2d9+nqokQcwZNj8U2QaUWK9Ul66
         fxC6uWgGeiuSSPBjaZWoUADu+pQMZrCksUeDGD/vY+L7kzgcCBUeKD+cq0Ewna0IVBzR
         ggEv0lU47EvzUaSMbyJp9uVWxa8/D92ybayu69bWlzNFeOOqEuguq1YOWyb67vxSOHnP
         t8/lf4Dy2SXChQY9SXdWA+5DnKVdMLWnpFQ1IEc/Wcjui59zvN5reiuCnVfhabIjwOTH
         KlWg==
X-Gm-Message-State: AOAM532PrtY2BopEsU3NgIYvMs631o6zJ5y7WjJlT9w8FEDoZeNzP/n2
        OjxmgNdIRHJT1f0K8PpSX/T8d5hVe5xayg==
X-Google-Smtp-Source: ABdhPJw3kPhCuAbQ5kwytznaF5rAWDrtwt4O2z2AZ5FETVqH+AjSQrIjZkQ9M2KwrcrdOTXs8Khxlw==
X-Received: by 2002:a17:902:7247:b0:156:9d3d:756d with SMTP id c7-20020a170902724700b001569d3d756dmr36508813pll.6.1649749935972;
        Tue, 12 Apr 2022 00:52:15 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id k187-20020a636fc4000000b003983a01b896sm1881676pgc.90.2022.04.12.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:52:15 -0700 (PDT)
Date:   Tue, 12 Apr 2022 00:52:13 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        tj@kernel.org, axboe@kernel.dk, dm-devel@redhat.com
Subject: Re: [PATCH] block: remove redundant blk-cgroup init from __bio_clone
Message-ID: <YlUvrXX2M3VqsgCQ@fedora>
References: <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
 <YkVBjUy9GeSMbh5Q@fedora>
 <YkVxLN9p0t6DI5ie@infradead.org>
 <YlBX+ytxxeSj2neQ@redhat.com>
 <YlEWfc39+H+esrQm@infradead.org>
 <YlReKjjWhvTZjfg/@redhat.com>
 <YlRiUVFK+a0DwQhu@redhat.com>
 <YlRmhlL8TtQow0W0@redhat.com>
 <YlUN2pVsIn1dbzHg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlUN2pVsIn1dbzHg@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 11, 2022 at 10:27:54PM -0700, Christoph Hellwig wrote:
> On Mon, Apr 11, 2022 at 01:33:58PM -0400, Mike Snitzer wrote:
> > When bio_{alloc,init}_clone are passed a bdev, bio_init() will call
> > bio_associate_blkg() so the __bio_clone() work to initialize blkcg
> > isn't needed.
> 
> No, unfortunately it isn't as simple as that.  There are bios that do
> not use the default cgroup and thus blkg, e.g. those that come from
> cgroup writeback.

Yeah I wasn't quite right earlier. But, the new api isn't in line with
the original semantics. Cloning the blkg preserves the original bios
request_queue which likely differs from the bdev passed into clone. This
means an IO might be charged to the wrong device.

So, the blkg combines the who, blkcg, and the where, the corresponding
request_queue. Before bios were inited in 2 phases:
    bio_alloc();
    bio_set_dev();

This meant at clone time, we didn't have the where, but the who was
encased in the blkg. So, after bio_clone_blkg_association() expected a
bio_set_dev() call which called bio_associate_blkg(). When the bio
already has a blkg, it attempts to reuse the blkcg while using the new
bdev to find the correct blkg.

The tricky part seems to be how to seamlessly expose the appropriate
blkcg without being intrusive to bio_alloc*() apis.

Regarding the NULL bdev, I think that works as long as we keep the
bio_clone_blkg_association() call to carry the correct blkcg to the
bio_set_dev() call.

Thanks,
Dennis
