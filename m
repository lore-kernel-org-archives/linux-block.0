Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4FDC433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 02:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiBQCki (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:40:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiBQCki (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 21:40:38 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8BA19E
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:40:23 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 132so3766648pga.5
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=oODu74s9GE4pl/LcFCnseaYhJWRPo2lHWvLkc0TctgM=;
        b=VwZs0sDEHU1lj3R8xk8nJKIW1EUGPPlevdD9GMfvpeK6jRBn8ES09qyjG4D9IyRqT1
         sdjPPS7sX/IovYIwQ1rALENXs3NO6j/cRb7tj9RU4bk6bDFbRm+4m76kNAYwkLAH+G9k
         hinUmegx0c+mGiVH3sVoy/tBMxWWSr8RsqahiPhlI2XsWe5ePkI4EZLmZ3/W1ZjOF/B2
         fhaWHxPe+XKvzxg6c8qRmzVUkahRDWVOUwBNsxs3yh5L/Buzixp/yCHmRiYhU1C5Myll
         iwpQXS3Cjou7HyJqClj/aVPlPB/9wxGiP59+sm8giqf1UZRaQqHl8adEktWoCm2AqY1v
         mnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=oODu74s9GE4pl/LcFCnseaYhJWRPo2lHWvLkc0TctgM=;
        b=aUNQJsI4BawlJZFHsDxmllwIxQJYdkNObDwrQHj1mrtqYxIlu3DuYog49pt2/uhKZl
         Culk5wwry5jCJkqVowEFAtEE3hrJ4H3km3nE3BmYBjLiLcqUkgqX2MP2Nr7IwGTidAuA
         Kkzn++32EZNOyfnSqwdr1VXPZogLTO0Vm9pMMZAlXonN0XJtTPtDVlZDMt9MaWMUQplA
         TilyxYwkyejLG6yqDM+16Bcz621kTevCwZB/TwEcGLwrcTGM659FLBvnWXN7XSMfTtV2
         lzNgtyQdHTXhs4iy9IFtxzbb01sNczEbl03UBUbL+RC246HTl7N7JvDT4TGxb1uh1xDS
         z7Vg==
X-Gm-Message-State: AOAM530RAPqvZXmXhMKtf0rjCjVbjIUR+dE0mj3u2qFFjnG1pPaJ9qHb
        D+QqCQOjurz2eQSGUuE4zrjW0g==
X-Google-Smtp-Source: ABdhPJzPZybSL83JbFQ7Ko+3wR4VK2ajkjH42fnPCHnO7hdrLt590zqAdba2ygW+GoAliSG2gPoiZw==
X-Received: by 2002:a63:451e:0:b0:373:6a1d:2ad9 with SMTP id s30-20020a63451e000000b003736a1d2ad9mr797469pga.114.1645065622451;
        Wed, 16 Feb 2022 18:40:22 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a17sm366645pju.15.2022.02.16.18.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:40:22 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
In-Reply-To: <20220215100540.3892965-1-hch@lst.de>
References: <20220215100540.3892965-1-hch@lst.de>
Subject: Re: make the blk-mq stacking interface optional
Message-Id: <164506562143.46255.14806921752720866775.b4-ty@kernel.dk>
Date:   Wed, 16 Feb 2022 19:40:21 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 15 Feb 2022 11:05:35 +0100, Christoph Hellwig wrote:
> this series requires an explicit select to use the blk-mq stacking
> interfaces.  This means they don't get build without dm support, and
> thus the buildbot should catch abuses like the one we had in the ufs
> driver more easily.  And while I touched this code I also ended up
> cleaning up various loose ends.
> 
> Diffstat:
>  block/Kconfig          |    3 +++
>  block/blk-mq.c         |   45 +++++++++------------------------------------
>  drivers/md/Kconfig     |    1 +
>  drivers/md/dm-rq.c     |   26 +++++++++-----------------
>  include/linux/blk-mq.h |    3 +--
>  5 files changed, 23 insertions(+), 55 deletions(-)
> 
> [...]

Applied, thanks!

[1/5] blk-mq: make the blk-mq stacking code optional
      (no commit info)
[2/5] blk-mq: fold blk_cloned_rq_check_limits into blk_insert_cloned_request
      (no commit info)
[3/5] blk-mq: remove the request_queue argument to blk_insert_cloned_request
      (no commit info)
[4/5] dm: remove useless code from dm_dispatch_clone_request
      (no commit info)
[5/5] dm: remove dm_dispatch_clone_request
      (no commit info)

Best regards,
-- 
Jens Axboe


