Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BDAC433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 16:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiB1Q2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiB1Q2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 11:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EBDA31529
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646065668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qkqO4WyPsrXQ7pdah2RqVsOYeXGLOr/c/Kjxy3SJ4Tg=;
        b=QTKjMBQUnAaoqAc02j9m5gekHK7sjHMNUO6YIAuJNZnd1fe7Uzpmak7AoHhfS+fzNemjhB
        nWHdaAaKzU8ctdt3/CKDlCJ5OZPLEoJkv7R8vSo2Rql5hUeXjEfRN/lzTZvb0s2gd7jHKI
        OpTW0UkIiiTtrLs9zr6CuzutYVsUPx8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-8IjkmhJuOjak85did-tbug-1; Mon, 28 Feb 2022 11:27:46 -0500
X-MC-Unique: 8IjkmhJuOjak85did-tbug-1
Received: by mail-qv1-f71.google.com with SMTP id h7-20020a0cf407000000b00432843fb43fso12502713qvl.7
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 08:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkqO4WyPsrXQ7pdah2RqVsOYeXGLOr/c/Kjxy3SJ4Tg=;
        b=fVNMO9A3Mi8brGK1P3Lb5q7BzckkG4bv5zwZbzSDqAX1emoZO3p4U7ykCB5OobBsaL
         BArDXJz5qM8ijKcpiGU5mYJhreIYWaEA0UW2eXpbIzheYGudAhcbimRXqQKSb3YTDEDQ
         D+iCBMAdlP2yhYhRPO0RJ4Y1LgQIFDnL6znGLUOBSPiTvddDc64hCxCZJVCYqwDVRE1g
         JPUFvHqHiiyC3B9a9Zt9SKYfDvIxaiGXwhRk/OrVJAJIKqnDgN4kVF22zrJSAzgCZ/ON
         8jRow5xSlFv27Z7zo2rZSLb5gdyx5qMYtDPKLbnPHTGVkdtyHOng4fprO+ZSpezpqrXS
         iusA==
X-Gm-Message-State: AOAM531GQlKtHIVIRDFWh4XTXqhi00wj8q289F+SeIqp3oZsXaP1R5Vk
        3+T2aRYrPNZvMIpmg5KRdW7zc2xeuGT6jQBj5R7dOb680W9rqdOfFuVgfGXsJm/Ewv00OqU06qT
        SWVXgPM0NMMbaV+7AGoYj5w==
X-Received: by 2002:a37:a2ca:0:b0:47d:8c2f:c3d3 with SMTP id l193-20020a37a2ca000000b0047d8c2fc3d3mr11162125qke.287.1646065666424;
        Mon, 28 Feb 2022 08:27:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwA60xCEtiITWiusl7AJY0rzXeBFgfRODZ5ofroFmbcGfRe3sjw1d3qMMbiZc0x9vEX0ccabg==
X-Received: by 2002:a37:a2ca:0:b0:47d:8c2f:c3d3 with SMTP id l193-20020a37a2ca000000b0047d8c2fc3d3mr11162121qke.287.1646065666206;
        Mon, 28 Feb 2022 08:27:46 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id c6-20020ac87d86000000b002ddd9f33ed1sm6847024qtd.44.2022.02.28.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:27:45 -0800 (PST)
Date:   Mon, 28 Feb 2022 11:27:44 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 0/3] block/dm: support bio polling
Message-ID: <Yhz4AGXcn0DUeSwq@redhat.com>
References: <20210623074032.1484665-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623074032.1484665-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 23 2021 at  3:40P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> Hello Guys,
> 
> Based on Christoph's bio based polling model[1], implement DM bio polling
> with one very simple approach.
> 
> Patch 1 adds helper of blk_queue_poll().
> 
> Patch 2 adds .bio_poll() callback to block_device_operations, so bio
> driver can implement its own logic for io polling.
> 
> Patch 3 implements bio polling for device mapper.
> 
> 
> V3:
> 	- patch style change as suggested by Christoph(2/3)
> 	- fix kernel panic issue caused by nested dm polling, which is found
> 	  & figured out by Jeffle Xu (3/3)
> 	- re-organize setup polling code (3/3)
> 	- remove RFC
> 
> V2:
> 	- drop patch to add new fields into bio
> 	- support io polling for dm native bio splitting
> 	- add comment
> 
> Ming Lei (3):
>   block: add helper of blk_queue_poll
>   block: add ->poll_bio to block_device_operations
>   dm: support bio polling
> 
>  block/blk-core.c         |  18 +++---
>  block/blk-sysfs.c        |   4 +-
>  block/genhd.c            |   2 +
>  drivers/md/dm-table.c    |  24 +++++++
>  drivers/md/dm.c          | 131 ++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/core.c |   2 +-
>  include/linux/blkdev.h   |   2 +
>  7 files changed, 170 insertions(+), 13 deletions(-)
> 
> -- 
> 2.31.1
> 

Hey Ming,

I'd like us to follow-through with adding bio-based polling support.
Kind of strange none of us that were sent this V3 ever responded,
sorry about that!

Do you have interest in rebasing this patchset (against linux-dm.git's
"dm-5.18" branch since there has been quite some churn)?  Or are you
OK with me doing the rebase?

thanks,
Mike

