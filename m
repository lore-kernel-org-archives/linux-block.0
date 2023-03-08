Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ED9C6FD19
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 21:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCHVIn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 16:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCHVIm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 16:08:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111B7B9A8
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 13:08:40 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x34so175267pjj.0
        for <linux-block@vger.kernel.org>; Wed, 08 Mar 2023 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1678309720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQjAWnx5lQ/2cENFz0YdGZbVbhOf2bedNqDxQZfmLmE=;
        b=DC948+R6ch+RYEfp2Fh69Wc5fEuezDxGyjm5a2ojDEmAJabOsIgx14BASBdNePqbO7
         A1sw5VdAMlS5De8EQ1Mm1vUNzQNIf8mMGPmHf6r/y99zKv0JSCyUIT8mU6KxsnmQiIGd
         2B7JuvDg8ms78MFJG+iPG8At90jWfpGWObImE5SBbRydaL5IUtud20x8Y8wdTtN/9Z/W
         FzgSTkckrxVQvBO3vI9A4viY2HXPPIyGkYnjb7ahWkZxK/znzbWaSMEhWHYPxrHDOVw0
         dduyixO5zIoWd/R5IIIWgSjIMTiv4qyyJ8WE80iykm3ooAeKS7B1hW5TcRKXHes0mAAN
         iYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQjAWnx5lQ/2cENFz0YdGZbVbhOf2bedNqDxQZfmLmE=;
        b=iTRSdNBPegc8l4pap1K3AAcTVMq+LUGumEO09MVQyiTdZiZa6DqcqQP2Uputx2lwa5
         w0xEQYcjlodPCWVuaEdIA/Em67Frnv+wLYzegEA7BqGdbCUdwwuJsWe6zST337bGn6/F
         knCK69bHzY+2X8Q06Et6tcBIRFGtKd1K6m2tzvuFC9MVd+MOm25kHN0Frj5d7gaHfWt0
         hBYHLomK0Dz4iStS0153V1Flg50Nx1DTJeHpbLGDZchfE8QxrI6WoyEIlnzabNmuaHc7
         fFKlMAIbA39zo+vYvrG6c+OIW8EgjK4TNKz7gS0ZEW2PJ/2XdC6IVWQVZJf5lHFFoE+M
         4M9Q==
X-Gm-Message-State: AO0yUKUmwL4/8Tfpa/RRqMYicUuwE1s3bwvmhZgfkTl733Wkz26LetHg
        l1IRSJmba5rmS+AlzDNIME+dKg==
X-Google-Smtp-Source: AK7set8/nCJPbgdHyS22yS22YNGDj4za3NiHgaPgzaWsI9o9vVTaHqTsc2ZqcZJtvgEtszxlzM/WcA==
X-Received: by 2002:a17:902:d38c:b0:19d:16e4:ac20 with SMTP id e12-20020a170902d38c00b0019d16e4ac20mr18011067pld.63.1678309719618;
        Wed, 08 Mar 2023 13:08:39 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id kq3-20020a170903284300b0019b9a075f1fsm10217942plb.80.2023.03.08.13.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:08:39 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pa11Y-006QqV-6V; Thu, 09 Mar 2023 08:08:36 +1100
Date:   Thu, 9 Mar 2023 08:08:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v17 09/14] iomap: Don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
Message-ID: <20230308210836.GV2825702@dread.disaster.area>
References: <20230308165251.2078898-1-dhowells@redhat.com>
 <20230308165251.2078898-10-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308165251.2078898-10-dhowells@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 08, 2023 at 04:52:46PM +0000, David Howells wrote:
> ZERO_PAGE can't go away, no need to hold an extra reference.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/iomap/direct-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f771001574d0..850fb9870c2f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -202,7 +202,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -	get_page(page);
> +	bio_set_flag(bio, BIO_NO_PAGE_REF);
>  	__bio_add_page(bio, page, len, 0);
>  	iomap_dio_submit_bio(iter, dio, bio, pos);
>  }

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
