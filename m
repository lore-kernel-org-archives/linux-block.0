Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF1DC43334
	for <linux-block@archiver.kernel.org>; Wed,  8 Jun 2022 18:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiFHSRi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jun 2022 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiFHSQ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2022 14:16:29 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD142A10
        for <linux-block@vger.kernel.org>; Wed,  8 Jun 2022 11:16:28 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id 68so7662101qkk.9
        for <linux-block@vger.kernel.org>; Wed, 08 Jun 2022 11:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hhMM47L2BUyuoiXuMFBaLENxxR94JQzFZtgdrCdFeOo=;
        b=AldhNL+d1EjHYeSDEXw4a1PwxhXgLw1mfboy9N1X0geTpo36YLruq4a4trXyZpLnK/
         MzLa5CBuO3OlzkTQ78nMtdsCXbW6A+9H/RQ2Yn46WQXUYIk83216TtiCDQHWV/MLeZDs
         qAw6Hkx2DwbyxfjkWOAjTwIgL9vf7nZZzunz1vhrPUvpXkso1PtkIx4jd/NzPHPWsT//
         w9L6gax5Lx3BUB2M7i9jYK7dDENSdPtpUQ2mtOtN83K85zJGokGOGfOQaZr6nAQcVJQk
         gsS9cLlhsVLU4TVEihlaQFG8AhYyQBHK2WpL1n1Mjl2dRPbCptTjmXv8basRP3K+Mf5M
         nP7Q==
X-Gm-Message-State: AOAM530PiNGz0Ra4UL/xI37963ZHYmMumOfXGM0YSWgcB4CSmJJqe5D6
        7xcibbCI3jrP4I4/qRQcw/U8+Y45utRm
X-Google-Smtp-Source: ABdhPJxv3g2qRGAfDYY619LqpL324bC2bj4rLn7oKWOFdWeAtRrRgbYDLLT2gspaeEQjYO7YkE2Alg==
X-Received: by 2002:a05:620a:2701:b0:6a6:c4b8:9d39 with SMTP id b1-20020a05620a270100b006a6c4b89d39mr10575457qkp.453.1654712187861;
        Wed, 08 Jun 2022 11:16:27 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m185-20020a37bcc2000000b0069c72b41b59sm16543495qkf.2.2022.06.08.11.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 11:16:27 -0700 (PDT)
Date:   Wed, 8 Jun 2022 14:16:26 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: fix and cleanup device mapper bioset initialization
Message-ID: <YqDneqyp33PvkCLm@redhat.com>
References: <20220608063409.1280968-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608063409.1280968-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 08 2022 at  2:34P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Hi Mike,
> 
> the first patch fixes the device mapper bioset to restore the previous
> behavior of preallocating biosets instead of allocating them at bind
> time, and to actually allocate pools for the integrity data.  The
> others are cleanups on top of that.
> 
> Diffstat:
>  block/bio.c           |   20 -------
>  drivers/md/dm-core.h  |   14 ++++-
>  drivers/md/dm-rq.c    |    3 -
>  drivers/md/dm-table.c |   66 ++++++++++++++----------
>  drivers/md/dm.c       |  136 +++++++++-----------------------------------------
>  drivers/md/dm.h       |    5 -
>  include/linux/bio.h   |    1 
>  7 files changed, 78 insertions(+), 167 deletions(-)
> 

All looks good to me.  Are you OK with me picking up the first 3 to
send to Linus for 5.19-rc2 (given the integrity bioset fix)?

And hold patch 4 until 5.20 merge?  Or would you prefer that cleanup
to land now too?

Mike
