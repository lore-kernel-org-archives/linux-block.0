Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3523C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 20:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiCVURp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCVURo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 16:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E39F245B5
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647980175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SMIp8B08FhcwythTG96yiDlyPxpSOrWGy+SCbNXTRzE=;
        b=QKYtm5cMvFXzRyponkxzJNZv6WTgd8CgK8VdDDpFKSZYz61M4Ko7WT/XZ2aM3FyOKBGMVB
        fMjMdv3XLq43aGDRcMQHE4xSW4knompUueENxXsRbDaqz93WiKSWfwFjefUStcnXDJedZL
        kmRFVH9Pcfp2BeqS/MDLrVioVl13dm8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-8e7Vbiu0NjivuJOBHlkcnA-1; Tue, 22 Mar 2022 16:16:10 -0400
X-MC-Unique: 8e7Vbiu0NjivuJOBHlkcnA-1
Received: by mail-qt1-f199.google.com with SMTP id t19-20020ac86a13000000b002e1fd2c4ce5so9278356qtr.5
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 13:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMIp8B08FhcwythTG96yiDlyPxpSOrWGy+SCbNXTRzE=;
        b=RowPTWiLiSJWxY656sGBiKktK50vNeRxS+jmjj4gs1Vhllt81bjujyQOlruyBRYusV
         v680RmoEPz1UOl11R208RDOHAZnxecnLxwIWcA7YMxgRNwk4/jG9lclJVkyrpfh3FvaC
         9qv27QG4Sw9RulT0QDC6SfJ+Heo61Xd+3Xs9d82lpRHm+MvoNMj3ABS5QDpc+JxEbepr
         w6xfHNqqQeDh+Sbnh96I/t7MKRxFO9aIEVkra7F7n2aNeYcQHGrWBfhUMdh7k4dfmRK1
         PBhw5AyOHhNWqmHreK6ijaBr+OxDN5lPpdTTfS3CUznmOd8NVsn384ustEQ/ZMuGDpyS
         T8Wg==
X-Gm-Message-State: AOAM531zHa32B5tyNXuKz7QzVdTdyqWTcDgApXv8jkI8CiTpTZ0fOUAe
        xclpofX+v8oGgS1ia0c/X9QAy3dYfLrpQ6jv8YRX0/H4FZTeKh4bGh9Qa4Gfq3Ztd0I+JTe5VNM
        Ll+SE2rf53Pax/FxST3Orog==
X-Received: by 2002:a37:a709:0:b0:67b:2dcc:d5dd with SMTP id q9-20020a37a709000000b0067b2dccd5ddmr16435884qke.597.1647980169558;
        Tue, 22 Mar 2022 13:16:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy4M1xgu67X23+CzQE3qXZ4axFIbR/sutU3hs8It5LtcZhX/53Fs9XBKlHWYcaLv5svtBBsQ==
X-Received: by 2002:a37:a709:0:b0:67b:2dcc:d5dd with SMTP id q9-20020a37a709000000b0067b2dccd5ddmr16435868qke.597.1647980169349;
        Tue, 22 Mar 2022 13:16:09 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id bp31-20020a05622a1b9f00b002e21e80ecd8sm2736443qtb.45.2022.03.22.13.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 13:16:08 -0700 (PDT)
Date:   Tue, 22 Mar 2022 16:16:07 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: allow BIOSET_PERCPU_CACHE use from
 bio_alloc_clone
Message-ID: <Yjouh9C7MaVrTnLh@redhat.com>
References: <20220322194927.42778-1-snitzer@kernel.org>
 <20220322194927.42778-2-snitzer@kernel.org>
 <20220322195414.GA8650@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322195414.GA8650@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 22 2022 at  3:54P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Mar 22, 2022 at 03:49:25PM -0400, Mike Snitzer wrote:
> > -	bio = bio_alloc_bioset(bdev, 0, bio_src->bi_opf, gfp, bs);
> > +	if (bs->cache && bio_src->bi_opf & REQ_POLLED)
> > +		bio = bio_alloc_percpu_cache(bdev, 0, bio_src->bi_opf, gfp, bs);
> > +	else
> 
> I don't think we can just unconditionally do this based on REQ_POLLED.
> We'd either need a flag for bio_alloc_bioset or (probably better)
> a separate interface.
> 

I did initially think it worthwhile to push the use of
bio_alloc_percpu_cache() down to bio_alloc_bioset() rather than
bio_alloc_clone() -- but I started slower with more targetted change
for DM's needs.

And yeah, since there isn't a REQ_ flag equivalent for IOCB_ALLOC_CACHE
(other than just allowing all REQ_POLLED access) there isn't a
meaningful way to limit access to the bioset's percpu cache.

Curious: how do bio_alloc_kiocb() callers know when it appropriate to
set IOCB_ALLOC_CACHE or not?  Seems io_uring is only one and it
unilaterally does:
kiocb->ki_flags |= IOCB_HIPRI | IOCB_ALLOC_CACHE;

So like IOCB_HIPRI maps to REQ_POLL, should IOCB_ALLOC_CACHE map to
REQ_ALLOC_CACHE? Or better name?

Open to further suggestions on which way to go with these details.

Thanks,
Mike

