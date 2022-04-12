Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5341BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 17:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiDLRRy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358054AbiDLRRi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 13:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 634A33B556
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649783719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQSg+fcGgsIovBMSED5kWUrqeIxltHs9zhn3+V43E5w=;
        b=dQP2uZCzY1PHHfrVmblWr8wgpCGavDEoYKaPww9NTRV97uBJHzH7Xf2I02ijLeTIMYGj//
        ZBqW9+/5J9e1TYscRWSgOz1D8RvyM0JU0InJQXy7nL0jDom4L61VvFDraEG2QjIBjYL5i0
        RVxxCquIc4c7sidWe+4XSBQeuwK3lrQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-DLYIMxcMMiKNua67Smfm7Q-1; Tue, 12 Apr 2022 13:15:17 -0400
X-MC-Unique: DLYIMxcMMiKNua67Smfm7Q-1
Received: by mail-qk1-f199.google.com with SMTP id v14-20020a05620a0f0e00b00699f4ea852cso10064118qkl.9
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 10:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQSg+fcGgsIovBMSED5kWUrqeIxltHs9zhn3+V43E5w=;
        b=7y5Yuzuj7mSf7LXjdNIwE1jdN7Kxc1ceHugZZoXU2cp3h5qvBRZdqSE/gQURbHubwz
         1cOq3SIZBTLa+HGh7QsVOEPqDtW0PbvHIVFgqvsOjTi57B7ETmiLoTqAvp63hZ1Kkg3W
         2RjFUZjW2LA6zb6nicP5wdUuObpFW/nh8kshS/BhQE4hm0dW7BD3hffKPKgSzq787bBy
         BYCCQMm1BpIZej2N6Uc/He71Wl52ea2O501wamhT2NwGWovY7HtQzPGYyJvcf38+RwK/
         jyuUxsFSDR93zGZ0MBNsTj3lzWVEMGQTTthGNWyrqgnk2QlGLvzrIm8C+df4wWCjbL04
         LvYA==
X-Gm-Message-State: AOAM532q3w8tyKu3CpTJv5V2YFCki6CRdBqBtsWyqEm62YCZRbjjd4Zg
        7cUVZQrMy5fcFO6I5xEl1+bMmuVC6CidRyjjz9DnMht9pGfUgaoLFQVQV7qWhJpAnhD5mUI7BIb
        e4HrsZyKD8leVTVJFRNT84w==
X-Received: by 2002:a05:6214:1d23:b0:444:4d2d:e377 with SMTP id f3-20020a0562141d2300b004444d2de377mr7107837qvd.116.1649783716799;
        Tue, 12 Apr 2022 10:15:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbgL0jHo2bPMSrSx0VpwBt3GfTFFXXN6q9xlEpCtbK4KzVbZUTCV64ELttOITi2TjcTROl4w==
X-Received: by 2002:a05:6214:1d23:b0:444:4d2d:e377 with SMTP id f3-20020a0562141d2300b004444d2de377mr7107810qvd.116.1649783716520;
        Tue, 12 Apr 2022 10:15:16 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a01e500b0069c42d12378sm901453qkn.18.2022.04.12.10.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:15:15 -0700 (PDT)
Date:   Tue, 12 Apr 2022 13:15:14 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/8] dm: io accounting & polling improvement
Message-ID: <YlWzoj+M1ykUubH+@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412085616.1409626-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12 2022 at  4:56P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> Hello Guys,
> 
> The 1st patch adds bdev based io accounting interface.
> 
> The 2nd ~ 5th patches improves dm's io accounting & split, meantime
> fixes kernel panic on dm-zone.
> 
> The other patches improves io polling & dm io reference handling.
> 
> 
> Ming Lei (8):
>   block: replace disk based account with bdev's
>   dm: don't pass bio to __dm_start_io_acct and dm_end_io_acct
>   dm: pass 'dm_io' instance to dm_io_acct directly
>   dm: switch to bdev based io accounting interface
>   dm: always setup ->orig_bio in alloc_io
>   dm: don't grab target io reference in dm_zone_map_bio
>   dm: improve target io referencing
>   dm: put all polled io into one single list
> 
>  block/blk-core.c              |  15 +--
>  drivers/block/zram/zram_drv.c |   5 +-
>  drivers/md/dm-core.h          |  17 ++-
>  drivers/md/dm-zone.c          |  10 --
>  drivers/md/dm.c               | 190 +++++++++++++++++++---------------
>  include/linux/blkdev.h        |   7 +-
>  6 files changed, 131 insertions(+), 113 deletions(-)
> 
> -- 
> 2.31.1
> 

I'll review this closely but, a couple weeks ago, I queued up quite a
lot of conflicting changes for 5.19 here:

https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19

