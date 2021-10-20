Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158E8C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6609610A3
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhJTGlD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhJTGk7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634711925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PrOFEvqhNQrQ0/ExACfaN4BBMFTlowBIDO0/wNK/PGI=;
        b=PoMinisIlENjtV23IhOMvbpBLah8wxjwdjn5rP8xZ+wo9VG8J45LBHAk9Fs7hbc0lzpm+s
        PWWnH5ab608WFXYURopCjgNBetS4FDQtoAqgK15/QoQfULTkwz36mH2zM3yVOkN8oikeRW
        /XM9YBOWpdDfHzGoHltb2Ejwcfi1i64=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-n2s1kz6jO3mBLJpFzxBGUA-1; Wed, 20 Oct 2021 02:38:44 -0400
X-MC-Unique: n2s1kz6jO3mBLJpFzxBGUA-1
Received: by mail-yb1-f197.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so29065704ybb.4
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrOFEvqhNQrQ0/ExACfaN4BBMFTlowBIDO0/wNK/PGI=;
        b=JwLscdVX+V5iwcB1Z7wnZ73yhOsQnQEdl/dLLl4Kg/t8uIDWsdn6VSAexGf+No672T
         hL9IJ1a97zS00PntXNVmLXpBEBuAIJ7XKVW8KWTEhWdFwvktF1gpRHFlCfMHeyuQSyaO
         zzf96ya6c6qMM2gSI+nCTKhcM4qqEirYkB1mVUjxREZLmtWIz23sQeEC4rwAItTAOvpN
         izZxwi834HNlKY/x5J5ZfKWQyc8pxLxaMbUeJ+BNT6tcooh84hRKZFwzl7pZzYdMGhYL
         2s0+W1b8rvoVHBUSWAHxAK3dWyXJr/df+hTQihaPscXgJolyFOii5JeoHVc5tKk4136t
         oxTw==
X-Gm-Message-State: AOAM530HhB/q30s4ITV0OSIvX9AacLQqWbMkz6TXWCeIFPmIM6UzRjSu
        yO57mlznkgse0F14aBvscNB86AFH6cavGB8vLBos+RoOVr4k9UdASo27c5rhoXQ7BvW6ztZmVnU
        8LzprbMomePQKbLGjs+1f2J8GRU9AzoHh+uTU4NI=
X-Received: by 2002:a25:3104:: with SMTP id x4mr40913559ybx.512.1634711923714;
        Tue, 19 Oct 2021 23:38:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIZmVt4b8AgEMPxIzXR7HjibNCLFoFON5qfINqUWjmWY1rYZGs5qe6fNCsg2PkDEFW2ZrVeNuo6RpgxFciEWQ=
X-Received: by 2002:a25:3104:: with SMTP id x4mr40913541ybx.512.1634711923514;
 Tue, 19 Oct 2021 23:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211019073641.2323410-1-hch@lst.de>
In-Reply-To: <20211019073641.2323410-1-hch@lst.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 20 Oct 2021 14:38:23 +0800
Message-ID: <CAHj4cs-osb2QuuCV2PW8xhefc3ATReur=b0tVf6ogTkMFmVi=A@mail.gmail.com>
Subject: Re: fix a pmem regression due to drain the block queue in del_gendisk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Verified the issue was fixed by this patchset.
https://lore.kernel.org/linux-block/CAHj4cs87BapQJcV0a=M6=dc9PrsGH6qzqJEt9fbjLK1aShnMPg@mail.gmail.com/

Tested-by: Yi Zhang <yi.zhang@redhat.com>


On Tue, Oct 19, 2021 at 3:37 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Dan,
>
> this series fixes my recently introduced regression in the pmem driver by
> removing the usage of q_usage_count as the external pgmap refcount in the
> pmem driver and then removes the now unused external refcount
> infrastructure.
>
> Diffstat:
>  drivers/nvdimm/pmem.c             |   33 +--------------------
>  include/linux/memremap.h          |   18 +----------
>  mm/memremap.c                     |   59 +++++++-------------------------------
>  tools/testing/nvdimm/test/iomap.c |   43 +++++++--------------------
>  4 files changed, 29 insertions(+), 124 deletions(-)
>


--
Best Regards,
  Yi Zhang

