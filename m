Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0E6C6FA82
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 15:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIWPPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiIWPPT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 11:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4E940E12
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663946108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/7qErjHQwpjdxeuxG56UOY53/Pb3ceXUixswzrpqTk=;
        b=bFBFyrGJUWMRmMxQa1IWFql0ZOi36fAqmXNFYBD2AqxN0IGNlLlB6ZsBVYjErT8abruYl4
        hs8yrfeK/BXujeLGn3BX+RPGUGW5sx5lfESinS/GuarSlOoYTJ65+S6z6H3uk1OtnZCeWo
        onUxdw3ygOUJUFcp0wQi3kjVr5agmE8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-393-iZbvzTXaNQe2-E0RKUUTvQ-1; Fri, 23 Sep 2022 11:15:07 -0400
X-MC-Unique: iZbvzTXaNQe2-E0RKUUTvQ-1
Received: by mail-qt1-f200.google.com with SMTP id fe14-20020a05622a4d4e00b0035cc376b1d5so173732qtb.4
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 08:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=i/7qErjHQwpjdxeuxG56UOY53/Pb3ceXUixswzrpqTk=;
        b=dPKzJ13D5PapzHwQa/O1pn6tzA2zerzwgdBGUyiZa+pgt1Ff1+c5ZcVqhGxpqr5ziL
         VE4zPurqIYrsT0eZX01iKZ9j0YMx7/gy738FpuvGxBz5UVt/6IGDTKGWXM2635/Gns4s
         WMnShXY+TYIoA8smNTQLTo0n+ehm6SIDc4O3ohwjD1wBUBu7Ch2b5DHlkv7TZXLF0DZo
         GBLPD/DHHLJuixVUrwETNkGPRvalP8iEBprzKBR4w8rF9TzfwKpnfBP8AffQFj0GX8vO
         JUmyG3y1A8DKo9n1seOUtUkzXegyRus4DnUELEV6oRncow4qe1tEI1DCZwEs3tYh8cUu
         FBCQ==
X-Gm-Message-State: ACrzQf33NDJJjItornMNs2gmwXpQ8aeIbUpSnKNsPdxUob/OPhGPuZBG
        Br/bPePRsTsbBCMR5gI+kdzAvU1k3v0aS37CyUsDP0jsV7E2MzUAlxEQAjnitliKrScIPi87bdo
        rSb85+Ge5tTGd5yEIzYBDYA==
X-Received: by 2002:a05:6214:76b:b0:4ac:be62:d2e5 with SMTP id f11-20020a056214076b00b004acbe62d2e5mr7176241qvz.91.1663946106772;
        Fri, 23 Sep 2022 08:15:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Jg5JqThdy0P5kS2uSLUoQ3+kfdp9Ppg4QGXjxFRDk5XYyybGVmtH43Lh/lTr6N1EDYoCkpg==
X-Received: by 2002:a05:6214:76b:b0:4ac:be62:d2e5 with SMTP id f11-20020a056214076b00b004acbe62d2e5mr7176213qvz.91.1663946106592;
        Fri, 23 Sep 2022 08:15:06 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id g12-20020ac8468c000000b0035cb9531851sm5432876qto.65.2022.09.23.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:15:06 -0700 (PDT)
Date:   Fri, 23 Sep 2022 11:15:05 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 1/8] block: Introduce provisioning primitives
Message-ID: <Yy3NeY02zEMLTdsa@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-2-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915164826.1396245-2-sarthakkukreti@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 15 2022 at 12:48P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> Introduce block request REQ_OP_PROVISION. The intent of this request
> is to request underlying storage to preallocate disk space for the given
> block range. Block device that support this capability will export
> a provision limit within their request queues.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/blk-core.c          |  5 ++++
>  block/blk-lib.c           | 55 +++++++++++++++++++++++++++++++++++++++
>  block/blk-merge.c         | 17 ++++++++++++
>  block/blk-settings.c      | 19 ++++++++++++++
>  block/blk-sysfs.c         |  8 ++++++
>  block/bounce.c            |  1 +
>  include/linux/bio.h       |  6 +++--
>  include/linux/blk_types.h |  5 +++-
>  include/linux/blkdev.h    | 16 ++++++++++++
>  9 files changed, 129 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8bb9eef5310e..be79ad68b330 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -57,6 +57,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->misaligned = 0;
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
> +	lim->max_provision_sectors = 0;
>  }
>  EXPORT_SYMBOL(blk_set_default_limits);
>  
> @@ -81,6 +82,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
> +	lim->max_provision_sectors = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  

Please work through the blk_stack_limits() implementation too (simple
min_not_zero?).

