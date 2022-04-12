Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4033C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 20:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiDLUoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 16:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiDLUoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 16:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B97A910EDEA
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649795532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OJbqnKkqep0Vk4w4W/zomWoOZ4tiSsZA9fVw+SRqOiQ=;
        b=d3M9983OFdbFCwM9ejQ0oj0QDkm2xjPzcCpwQNM9vQomQpD+r9jF7uCf92/q49AaJCjp8f
        9N8NIE/acFL/kA66aC5ggWSExMJH+zbVDWZ6BkxWXKyVjbP/t5MTBz0OktzumSB0+m4EWH
        XNwA0hHrlfdfDot90BhSyRYCJg6QEyY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-AxNGirS3NKWB6oM6scDiqA-1; Tue, 12 Apr 2022 16:29:02 -0400
X-MC-Unique: AxNGirS3NKWB6oM6scDiqA-1
Received: by mail-qt1-f199.google.com with SMTP id m3-20020ac86883000000b002ed8d29a300so5373615qtq.11
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 13:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OJbqnKkqep0Vk4w4W/zomWoOZ4tiSsZA9fVw+SRqOiQ=;
        b=QNr+Z2fTqWkMAQ3eOVqNY4hQFU1pDS0DZPxAMrepVX5+oIvObITkEtJ6zoMXlOXFEl
         SYvtO/TMUcEYc6vwTKxED9QQJQcYQx4pZrSikRiEi8w2FsWpAmtNyUExmhE7Jy+fIV+z
         0/piPlXGKQqkjIxJxm2O3C/13eo9lF8y6h25sFDvM8XrAx7AGhyMgr9xKbv7cdDwXLNj
         o5Y7h/6DhqNECfq4xp03boUI6zQ5VaG4JgSGo7gMeP7qC1NDCX43tZppEY1WlwRZZcZB
         BUGmyhJ9rK7r4zsiqtqS/qwa6e1ZPBeRywOHzF0TyI2eQV0XBr6cZHvrtPzqD4CFywQE
         l5MA==
X-Gm-Message-State: AOAM531VX9uFS7i5oebE3t6gKRX12I/rfzIkp6VkaNg66ZqsAOQQg4eF
        W2sO7uot8si03fEx82wgg03R2WXZhSXbTbUnWURBkxlCt8JvggAuVlWQ6TdmwEQcQAkMLTrVGi+
        O19fRBIZrWF6DX256L5WG4g==
X-Received: by 2002:a37:947:0:b0:69a:d9e:ed4a with SMTP id 68-20020a370947000000b0069a0d9eed4amr4443505qkj.457.1649795341601;
        Tue, 12 Apr 2022 13:29:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSGcXhtVeIYxdDfTCCnoFxp3d0501Nzl6W6dCig7McULYIVbXGd7o4+Fr8zRE6JaX85sfaTg==
X-Received: by 2002:a37:947:0:b0:69a:d9e:ed4a with SMTP id 68-20020a370947000000b0069a0d9eed4amr4443496qkj.457.1649795341336;
        Tue, 12 Apr 2022 13:29:01 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w22-20020ac87e96000000b002eb8e71950csm27179053qtj.71.2022.04.12.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:29:00 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:28:59 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 3/8] dm: pass 'dm_io' instance to dm_io_acct directly
Message-ID: <YlXhC1tHYYyCQxdI@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412085616.1409626-4-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12 2022 at  4:56P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> All the other 4 parameters are retrieved from the 'dm_io' instance, so
> not necessary to pass all four to dm_io_acct().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Yeah, commit 0ab30b4079e103 ("dm: eliminate copying of dm_io fields in
dm_io_dec_pending") could've gone further to do what you've done here
in this patch.

But it stopped short because of the additional "games" associated with
the late assignment of io->orig_bio that is in the dm-5.19 branch.

Mike


> ---
>  drivers/md/dm.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 62f7af815ef8..ed85cd1165a4 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -498,9 +498,12 @@ static bool bio_is_flush_with_data(struct bio *bio)
>  	return ((bio->bi_opf & REQ_PREFLUSH) && bio->bi_iter.bi_size);
>  }
>  
> -static void dm_io_acct(bool end, struct mapped_device *md, struct bio *bio,
> -		       unsigned long start_time, struct dm_stats_aux *stats_aux)
> +static void dm_io_acct(struct dm_io *io, bool end)
>  {
> +	struct dm_stats_aux *stats_aux = &io->stats_aux;
> +	unsigned long start_time = io->start_time;
> +	struct mapped_device *md = io->md;
> +	struct bio *bio = io->orig_bio;
>  	bool is_flush_with_data;
>  	unsigned int bi_size;
>  
> @@ -528,7 +531,7 @@ static void dm_io_acct(bool end, struct mapped_device *md, struct bio *bio,
>  
>  static void __dm_start_io_acct(struct dm_io *io)
>  {
> -	dm_io_acct(false, io->md, io->orig_bio, io->start_time, &io->stats_aux);
> +	dm_io_acct(io, false);
>  }
>  
>  static void dm_start_io_acct(struct dm_io *io, struct bio *clone)
> @@ -557,7 +560,7 @@ static void dm_start_io_acct(struct dm_io *io, struct bio *clone)
>  
>  static void dm_end_io_acct(struct dm_io *io)
>  {
> -	dm_io_acct(true, io->md, io->orig_bio, io->start_time, &io->stats_aux);
> +	dm_io_acct(io, true);
>  }
>  
>  static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
> -- 
> 2.31.1
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 

