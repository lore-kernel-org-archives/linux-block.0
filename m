Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF38ECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 09:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIUJJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIUJJo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 05:09:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9FF583
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 02:09:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so8053485lff.13
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CJumgeBihgLxngSicS7NE5vjfcZmDSi/RxXboW9qUWM=;
        b=EKWIc9WL+Aypz9wJXzJw8JHL9CZ0ILYl4+bnCYIciz4j4D8wWj+OQCImhdOF8PeE3e
         8cyNN/7NX9YqQStAMETz9Qa0d1ylCPNQumAXvSZaB0kDHRXCmP1j1uTvxv3vxSMxLDXJ
         H9jFgc8NAEbHUVGhderkegtDM6hiBgAxkrQQOsvDk+pC7Cv2XEFIDj5UPhwYtkhh9fy/
         LuJhDBEkEkMELXOABWaisxGrflz11mLFYD7GPs79JYoIBEySsuzKX/FTlgcI/xL2cawc
         AVnxyQAHo6TieTPRuiqJ3YqfJHjKgO9Jkvc9nsnUw7etR40kOGot9DyvKGBsm61GYuNl
         GPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CJumgeBihgLxngSicS7NE5vjfcZmDSi/RxXboW9qUWM=;
        b=gLSDqBe3BnobQ6lsX1rhaja9fctamcFnF8UqUVHIaGeQ96mk9DyFY9yX+6jEbMVm45
         O5kdKu33+/oWKSpv8Afp6pqbxyR9v0PefhqddQNC/GMjpmpxWL2PbNKNxtObO80LJQdI
         dt/2UMalMIVdSOTNnLpJte5Xc6d3drt3Rva7BILfdWgtNtFaKLLLj4uI/SB8IRlT6QzK
         vyW4EcYVzuXjrlIM5kc0V2kDUS/p4Dpy8BqS8pP1U1OGquQCrYVKXVxZV/a625saSV2d
         3eh0/jdGd+AMOThC1PD6/SnKT9cikD/taUxiMfUzbO0rKRQxEc0CmcW7ccubKCQ45iw2
         My/Q==
X-Gm-Message-State: ACrzQf2LB6dUMWRk3QEJg1e/7RRjr7dKilj6m/TEdhyvXQP+1lrBX4Hp
        hOjII8bbPnvsV4LYNuGlNIw=
X-Google-Smtp-Source: AMsMyM78QjYWwhFLJE3RBK+mf1B8gSuLs5C2lsPiD6VXHdS7GXnjk0nvF1D3N60TEIuzwOsVYeu7OA==
X-Received: by 2002:a05:6512:1313:b0:49a:1194:bbab with SMTP id x19-20020a056512131300b0049a1194bbabmr9164791lfu.623.1663751380788;
        Wed, 21 Sep 2022 02:09:40 -0700 (PDT)
Received: from localhost (80-62-117-68-mobile.dk.customer.tdc.net. [80.62.117.68])
        by smtp.gmail.com with ESMTPSA id u24-20020ac24c38000000b0048afbe8a6a1sm340722lfq.241.2022.09.21.02.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:09:40 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:09:38 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 4/4] brd: implement secure erase and write zeroes
Message-ID: <20220921090938.5o6yimq7vvl7ihpv@quentin>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209201358580.26535@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209201358580.26535@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> @@ -330,7 +344,9 @@ static void brd_submit_bio(struct bio *b
>  	struct bio_vec bvec;
>  	struct bvec_iter iter;
>  
> -	if (bio_op(bio) == REQ_OP_DISCARD) {
> +	if (bio_op(bio) == REQ_OP_DISCARD ||
> +	    bio_op(bio) == REQ_OP_SECURE_ERASE ||
> +	    bio_op(bio) == REQ_OP_WRITE_ZEROES) {
>  		brd_do_discard(brd, bio);
>  		goto endio;
>  	}
> @@ -464,6 +480,8 @@ static int brd_alloc(int i)
>  	if (discard) {
>  		disk->queue->limits.discard_granularity = PAGE_SIZE;
>  		blk_queue_max_discard_sectors(disk->queue, UINT_MAX);
> +		blk_queue_max_write_zeroes_sectors(disk->queue, UINT_MAX);
> +		blk_queue_max_secure_erase_sectors(disk->queue, UINT_MAX);
>  	}
>  
The previous patch has the following description for the discard module
param:
MODULE_PARM_DESC(discard, "Support discard");

But you are reusing it here to enable write zeroes and sec erase.
MODULE_PARM_DESC's "desc" parameter also needs to be updated in this patch.

I understand that all these operations kind of do the same thing at the
end, so it is upto you to decide if you want to add individual module param
for each operation or club them together as you have done here. If you
do the latter, then changing the module param variable `discard` to
something more generic would give more clarity as well.
