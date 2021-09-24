Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00F5C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 16:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD40F61241
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 16:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhIXQ7g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhIXQ7c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 12:59:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84387C061571
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 09:57:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 145so9385915pfz.11
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AlGhjQgx1IvFlacw/eSYonV1Ve8whQq5pGs6porzq5E=;
        b=Phz9SVeG1wjzGZK74F8xJfjFWuABunzJaFBZKaqfu8eL1sywqRy7yqFrIWET42B3sd
         XYiANpEO9OmlwBo6ugZvYnu+xvjViI8axHAp3GgqkvenvInQHSFlLN9D5oYIWzHaNzy8
         BpNGd9i1fUZeTPQ+KKcUsK2g3hEK4TXTsrfuOWr8P41N/wX7p7sO3LiFZQhWBAoLOFnT
         XA2tIq/c93NAqrreWFTjhi6O9wxtHngz3JvsoeTd2wz0PXSIUyu1sR6Rjnl0zQz/dh6i
         xaaNStTsF4Oj+EpUTytyzYsiFGskvF15vZ+eel2/Hy/PRbeLfwbBYr1NuJBZPOyndIQG
         ETpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AlGhjQgx1IvFlacw/eSYonV1Ve8whQq5pGs6porzq5E=;
        b=Qa94I5e96vB3F91UxOI6KJK4WNOIJjkLSRjao9GoGpZ8pkKZbFwpFXIjyocaGSu6L2
         p3dSjGv2Kgm+StQNvYgs1M1papL8P+O3P5+Y2iPEISMntNitG32xdW1fr2C1H30t9hza
         NsvdBbjHNVfI2KDMmV+MEjlLxkFM0cdJkw6tUo/I9fXcF63VQ493ArESvS06HO4945p/
         OYThC1kjUAZ7/tfDbi/lWJgrI5TE4KD3SeJ2XJrPwtl/CPK/D8tpt/6tIETDyWARgQT8
         PUUogprpyZaPi0pB3yPBfFICEeVF2/92ttDtggrNgZ7mdG8160xWuWMKfnXn8AmC1EpE
         5T9A==
X-Gm-Message-State: AOAM533ll+ycjSf9KOhx3+Uw6WeONGvIEbllp1XR8ZWGAAsTcX4d+Fm+
        ErG529eYhg14LEoCt767/H4=
X-Google-Smtp-Source: ABdhPJyB4Zi+zJXy7R9yDJA+zx0UAwxzpLY6ZvgB/WSoz6NAeanhQn8UeMlsrrdkuNDMralQLkr8rg==
X-Received: by 2002:a63:4614:: with SMTP id t20mr4673318pga.372.1632502677330;
        Fri, 24 Sep 2021 09:57:57 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id 21sm9301788pfh.103.2021.09.24.09.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 09:57:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 24 Sep 2021 06:57:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH] block: don't call rq_qos_ops->done_bio if the bio isn't
 tracked
Message-ID: <YU4DkxBcYeIRO+NL@slm.duckdns.org>
References: <20210924110704.1541818-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924110704.1541818-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 24, 2021 at 07:07:04PM +0800, Ming Lei wrote:
> rq_qos framework is only applied on request based driver, so:
> 
> 1) rq_qos_done_bio() needn't to be called for bio based driver
> 
> 2) rq_qos_done_bio() needn't to be called for bio which isn't tracked,
> such as bios ended from error handling code.
> 
> Especially in bio_endio():
> 
> 1) request queue is referred via bio->bi_bdev->bd_disk->queue, which
> may be gone since request queue refcount may not be held in above two
> cases
> 
> 2) q->rq_qos may be freed in blk_cleanup_queue() when calling into
> __rq_qos_done_bio()
> 
> Fix the potential kernel panic by not calling rq_qos_ops->done_bio if
> the bio isn't tracked. This way is safe because both ioc_rqos_done_bio()
> and blkcg_iolatency_done_bio() are nop if the bio isn't tracked.
>
> Reported-by: Yu Kuai <yukuai3@huawei.com>
> Cc: tj@kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
