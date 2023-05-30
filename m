Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C36C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 16:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjE3QLg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 12:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjE3QLd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 12:11:33 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D338D13E
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 09:10:17 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6261367d2f1so15133526d6.3
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 09:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463017; x=1688055017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irk/8GUWmwLYWfm2Lio5fOal+y0GOgImfVphQa7iGfs=;
        b=BNn9ZAJK0YsIXvcFrSgb6JZ0YVHLtGJZJCSUDYV3WdYt37yCZQN8u0oBXwVT5tcJEN
         CLs2cr7jMuPEqyBe39lT0d9iRXHVbxZg7HvvStel9+2YrAFM+y8e+13rnXXL5wgk2wCB
         lHz47DRmu/nuoupPkTi2NUi595FqTe06UT6NswPXT6OMhYe0yb99WzHfWI9xo/yETHQz
         n5y8SQmEk99Rs7tUM53G4bz3/CK8daa7Pkd0PFsyg8pXYnDtUrYK6iIOP8wwxJWJMEue
         5d1tI0EpEQckV3FnRFiNmF04JafKn52ouAuSYtNBjvjuMMbahd/QV9QjHU/2aMQYKJfF
         bwpQ==
X-Gm-Message-State: AC+VfDxALyre+17sxkJFvZzMt5EGmUGA/hy0z+w6IhG8Gna/DDzSi/Rv
        WBBIvigxpxWEbD9T+jl0juJc
X-Google-Smtp-Source: ACHHUZ56MECtsjcewLbFVxD7Rkez1npKixqOW82Zsid/kEpDsAmjiM2JZkfOYT0pMaVRxjwqyQggQQ==
X-Received: by 2002:ad4:5b8d:0:b0:625:af4b:4162 with SMTP id 13-20020ad45b8d000000b00625af4b4162mr2721624qvp.14.1685463016980;
        Tue, 30 May 2023 09:10:16 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id w20-20020a0562140b3400b0062381fa97c5sm898935qvj.92.2023.05.30.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:10:16 -0700 (PDT)
Date:   Tue, 30 May 2023 12:10:15 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, Song Liu <song@kernel.org>,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-raid@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>, gouhao@uniontech.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 16/20] dm-crypt: check if adding pages to clone bio
 fails
Message-ID: <ZHYf5+ocDL0hsud6@redhat.com>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
 <e1c7ed59e2d2b69567ef2d9925fa997ecb7b4822.1685461490.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c7ed59e2d2b69567ef2d9925fa997ecb7b4822.1685461490.git.johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 30 2023 at 11:49P -0400,
Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:

> Check if adding pages to clone bio fails and if it does retry with
> reclaim. This mirrors the behaviour of page allocation in
> crypt_alloc_buffer().

Nope.

> This way we can mark bio_add_pages as __must_check.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The above patch header doesn't reflect the code.

I also think __bio_add_page should be used, like my racey reply to
Mikulas vs your v6 patchbomb said, please see:
https://listman.redhat.com/archives/dm-devel/2023-May/054388.html

Thanks,
Mike

> ---
>  drivers/md/dm-crypt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 8b47b913ee83..0dd231e61757 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -1693,7 +1693,10 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
>  
>  		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
>  
> -		bio_add_page(clone, page, len, 0);
> +		if (!bio_add_page(clone, page, len, 0)) {
> +			WARN_ONCE(1, "Adding page to bio failed\n");
> +			return NULL;
> +		}
>  
>  		remaining_size -= len;
>  	}
> -- 
> 2.40.1
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 
