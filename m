Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E82C433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33C561A3C
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhCYVlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhCYVlL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 17:41:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D0C06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:41:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id y32so1996303pga.11
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D/4KZMAlbXLgx+1fzHn/h/cE3L4iWN9TmIPJM+L9kJQ=;
        b=HItToSmpEzU6HsTtaz98v51Y1qcQDS0ce2ocHCBvFaJVuu/op58RcGnubdB6xnrkmq
         45CtCSfjwiY0QKLkrvZJjIjI5qLNQg6xSVjJWAqyeEqvbyVEOaFdETnHpG83JhFGGhj1
         XsAllx0bRcReubr9IgnISK3YP7rliPVATSdaPjD5hL1AQGNUogxHFZ8verQwUkBBZFi2
         WYZQ9eavVbjkuhl/MhpuqYs94Bcwmx/HD9PbA94EnNAK++T1zJe0iVOZRq1532Nmsg1C
         o8TGozrnFvV7h9z4E9NXZLhh5GUIfHfQBScTip9TkliZGiEXwI/vAkJwwKeE9CfR8kWg
         RoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D/4KZMAlbXLgx+1fzHn/h/cE3L4iWN9TmIPJM+L9kJQ=;
        b=Hdz9+pdXMX/7nlVCqvB/R7peXj2JKR3N2ByGDuucfZYOV9Myz1Digo9tNMT7BNjdJi
         gnnBYQtkz8QlEhzIYfKNqEtztT58VRpHq34e/xI0Y6Sxfbh5szCPggqtdLGOk9dfylyr
         mgenMhP32TotZMJipDMlP2yruQKl7uAlHwGiUarm1h//5k0N0OQ5kVzfI/8H82er33tg
         cbJyw123hT8l39E7+YvHV6APgxwxM1aM89VZ3zu/HbCLqhxsOQs94jfE8CTEc5SkkLzV
         kuFKwCz6yDdM3NOMvZGGvdcAuE1wLyt/xRTZ6jigLWIGlTYUxkyRMGzKFI7iEz5tZKL2
         +GRA==
X-Gm-Message-State: AOAM530n6znWCbsnGvKswrB1fnNZ0G+5eODDHnT059HUrQySLByOQk3n
        65uo3I6Yd16t69pdet+mLZynWQ==
X-Google-Smtp-Source: ABdhPJz8FPXAYxfey9NelgCRRkP1MH4cnV1TkOpd4uNsyZm+oGKVpO3h0J3NqEMaY4nYicD0voMHSQ==
X-Received: by 2002:a63:1502:: with SMTP id v2mr9132692pgl.22.1616708470903;
        Thu, 25 Mar 2021 14:41:10 -0700 (PDT)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id j22sm6027328pjz.3.2021.03.25.14.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 14:41:10 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:41:06 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 0/7] ensure bios aren't split in middle of crypto data
 unit
Message-ID: <YF0DcnkXy2l5WJzW@google.com>
References: <20210114154723.2495814-1-satyat@google.com>
 <20210121171129.GA4122715@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121171129.GA4122715@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 21, 2021 at 05:11:29PM +0000, Christoph Hellwig wrote:
> On Thu, Jan 14, 2021 at 03:47:16PM +0000, Satya Tangirala wrote:
> > When a bio has an encryption context, its size must be aligned to its
> > crypto data unit size. A bio must not be split in the middle of a data
> > unit. Currently, bios are split at logical block boundaries, but a crypto
> > data unit size might be larger than the logical block size - e.g. a machine
> > could be using fscrypt (which uses 4K crypto data units) with an eMMC block
> > device with inline encryption hardware that has a logical block size of
> > 512 bytes. So we need to support cases where the data unit size is larger
> > than the logical block size.
> 
> I think this model is rather broken.  Instead of creating an -EIO path
> we can't handle anywhere make sure that the size limits exposed by the
> driver that wants to split always align to the crypto data units to
> avoid this issue to start with.
Hey Christoph,
Thanks for the suggestion. I finally sent out v2 for this patch at
https://lore.kernel.org/linux-block/20210325212609.492188-1-satyat@google.com/

I tried doing something similar to what you suggested to avoid
creating an -EIO path, but instead of changing the size limits exposed
by the driver, I changed the allowed data unit sizes based on the
exposed size limits. I did it that way because the limits that
interfere with inline encryption happen to be "hard limits" a driver
can't lie about, like having support for SG gaps or not requiring
chunk sectors. Another reason for doing it this way is so that we
don't interfere with regular unencrypted I/O by changing driver
exposed limits unconditionally (and I didn't think it was
straightforward to expose two different sets of limits of encrypted
and unencrypted I/O respectively). Please take a look at the new patch
series if you're able to. Thanks!
