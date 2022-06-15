Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F8AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 10:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiFOKsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347173AbiFOKs0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 06:48:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9583A289A6
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 03:48:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id z14so6883197pgh.0
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HrPrkJE8jizmZIqhjR7LQQh1Vy5Akz1+QA5vz7RPuSk=;
        b=iWy9hZBLZlQQdOkjFVwm/XW1JFGBBjgybNzbDFA5O5KD0DN1wGS04c/v4Dx6zcOBuM
         24QsM9JFKPxZRAzSgOVKWLvVEukMpITR8SePwAJeJFVXwqSABZgXAszhJVhpYeh+Rb/c
         LTD2L45kQ4Z+d0iCtT8u/L8FHpM/etdHx8VI0YaVqCWELxQL59hzN5D8pAbS50shbQSn
         rapk4wycAKshCFh5l/JpQmmGBhMAAIrODODIRykfhlr6rbmQP40y5ZiaarTl0hT24egX
         hZav3SuCdQ9ssgwLNolub+HnRaxFuPUDX+EFlShiZqWNMNAhUFBdG70W189PwSoSklkg
         If/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HrPrkJE8jizmZIqhjR7LQQh1Vy5Akz1+QA5vz7RPuSk=;
        b=C04PffgYOeC3y94XVIo8JYGjbQ2XylmEw86geAKZAr79C150Oyr8lorWXGG6x7oQ1T
         XbyROrF4ZXZjmX1gA2yym7NH/gxVIdlNYkGagXATyflqXrUEiHkmarKBYj0jockb0kNp
         o3La463P+ZrAOD40t2NYwXjy5ipO3LrlPBtBT4GJfPs3UIb9aTjbLeuLHTKGaUoqan0N
         HtImzLO8tB29bhTPH2TFNbi3w272DlhzlQXjhmAa8gjUOBuyhUbKwXIErul3Hl/5A35E
         Jbr9Ey8GJ0gFLTXuFWgpwwOK2+co31J4vdzl7NHY++J8NV51ylHK+ixg1bLA8Ak3g/7j
         iqQA==
X-Gm-Message-State: AOAM532OMr+u9zwrxG3VybZPpiF/2gtluaNQ6PMNVBdgXRxXRgC+zdE5
        SwBuO+NBTHB+V+g8r0SYSNw=
X-Google-Smtp-Source: ABdhPJz7ZbBbl7wxI6LXLgjMNlNPP9/7Hlq97hsR7lvjDGmbeuo+s60Er61Z7FjbgGtaYintJm1hJg==
X-Received: by 2002:aa7:9493:0:b0:522:8317:b675 with SMTP id z19-20020aa79493000000b005228317b675mr9242373pfk.61.1655290105134;
        Wed, 15 Jun 2022 03:48:25 -0700 (PDT)
Received: from localhost ([122.183.153.161])
        by smtp.gmail.com with ESMTPSA id a15-20020a62d40f000000b0051f2b9f9b05sm9572348pfh.76.2022.06.15.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:48:23 -0700 (PDT)
Date:   Wed, 15 Jun 2022 12:48:21 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/6] block: fold blk_max_size_offset into get_max_io_size
Message-ID: <20220615104821.oyuz7x3a2c4klcd5@quentin>
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614090934.570632-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 11:09:33AM +0200, Christoph Hellwig wrote:
> Now that blk_max_size_offset has a single caller left, fold it into that
> and clean up the naming convention for the local variables there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-merge.c      |  9 +++++++--
>  include/linux/blkdev.h | 19 -------------------
>  2 files changed, 7 insertions(+), 21 deletions(-)

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
