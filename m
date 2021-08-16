Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5D4C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD83660F5C
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 14:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhHPORg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhHPORf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 10:17:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885D6C061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 07:17:04 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so21064748otu.8
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xqBgEkGNywTvhBrskowD08mnqrtLbd1U3IqXducmNiM=;
        b=hi9oKWJP7v7pHxG3rppmcvZBqhh3QpTGh0B69Ipa7d1CP77jb1Z7F8xfBkHCNYWqO2
         ixy9IhmRobpxHXCUhyGF/wvH8rw2frBoQtKjjjWrbCz2YYYclUQyJxwEZBFcFSpYo+Jw
         gP99djVzYyAM97wm6HAG4x0uRgDErxBbrzDJVqP4mfwfVxp/BBESRsNIbbLNXRp2R7rL
         3lhcTuYGvNnLTGwHwmzFs+JQBTnz/cJpZGTzKODU4WlknajAuTgZ5IcLbcUNZ1APRgZP
         l2F8oJ8VjjTdTO8TO+5EXqQGYyBKAyTgGzygGJBI9t7kyIjVjFqS8CABNAlICymoNmsg
         V5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xqBgEkGNywTvhBrskowD08mnqrtLbd1U3IqXducmNiM=;
        b=M1ntbEJ060yHqSVDdReJy+Rq9vomXFZM71KsW9i1VRlIQSac5TRUKxXat3my9cf429
         YCZLIqGLnf2rfnXP5qGdUZcGW1oBDnEuEx2+L3CsTWaL1uCAPIV+M2yv/PlUBnEs6lN4
         hXm/tFIR4DtIAsoqGinIvXV5GUqbBMqPEIv6GHTNkyNnvMc5IXubvgSFqkjCJTPyA1+7
         ArsK+9scuuNA241y3jnLQ8YR6swCC4v7Mxt+O8ZfoGdV5t9zo3AHelDTcmqUoVxcvQeg
         e2FxY9VwtRTwN1F1RQhsWmHTAWxi8/ubLLXIz5lRS0EmirsiUcG+nolGpbBr6nLLlFkS
         8jfQ==
X-Gm-Message-State: AOAM53216KvvIXmzuz19YGiKHg6Pk8pkSYkUZd4xyqQPuA0rnGU+7lML
        NX+osHNxh5ADYw691zXRs3I=
X-Google-Smtp-Source: ABdhPJwk9RHSoGUJTOU9tmS9JZvmAHg37gvCbM3/T8FG2iyjhZiOE2JVE2I1qIxtU73Rp6CqWPD8tw==
X-Received: by 2002:a05:6830:2695:: with SMTP id l21mr13300180otu.138.1629123424016;
        Mon, 16 Aug 2021 07:17:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6sm2219953otu.16.2021.08.16.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 07:17:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 16 Aug 2021 07:17:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH 4/8] block: support delayed holder registration
Message-ID: <20210816141702.GA3449320@roeck-us.net>
References: <20210804094147.459763-1-hch@lst.de>
 <20210804094147.459763-5-hch@lst.de>
 <20210814211309.GA616511@roeck-us.net>
 <20210815070724.GA23276@lst.de>
 <a8d66952-ee44-d3fa-d699-439415b9abfe@roeck-us.net>
 <20210816072158.GA27147@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816072158.GA27147@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 16, 2021 at 09:21:58AM +0200, Christoph Hellwig wrote:
> On Sun, Aug 15, 2021 at 07:27:37AM -0700, Guenter Roeck wrote:
> > [   14.467748][    T1]  Possible unsafe locking scenario:
> > [   14.467748][    T1]
> > [   14.467928][    T1]        CPU0                    CPU1
> > [   14.468058][    T1]        ----                    ----
> > [   14.468187][    T1]   lock(&disk->open_mutex);
> > [   14.468317][    T1]                                lock(mtd_table_mutex);
> > [   14.468493][    T1]                                lock(&disk->open_mutex);
> > [   14.468671][    T1]   lock(mtd_table_mutex);
> 
> Oh, that ooks like a really old one, fixed by
> b7abb0516822 ("mtd: fix lock hierarchy in deregister_mtd_blktrans")
> in linux-next.

I have seen the problem in next-20210813 and that patch is there,
so that is somewhat unlikely.

Guenter
