Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA28FC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 16:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiG0Qmh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiG0Ql6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:41:58 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF255C343
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:29:53 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id n13so9097130ilk.1
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=/SSf5BVafpijdSXMMngYQC9Ps4BVJNDNF+wR9WJ49aY=;
        b=Nkx20mSS5MczpPiOvjgvQ1R7ZCL7Bl7U1/Qu9WIh21JP9tNxHoWKy5pxgHRILiVQjW
         4u1O3lDiE6zHnpPAlaW9/sLHWb3sza3Yvr9MgQBh2r/mw0BHAYQvDyFFmBVnu0eKB72C
         4rgINqvC2VFgy4jKKmvuUufRWw1I8tBTLwya611erERbgv4hRvJhUqPGbeSkbg+nsk0P
         d2sO9cgFZTgluXUyWLGDG2eahL+cRQPQvrMACxY3EolaZniYU+A3fDoYZCfHshoDxdvW
         WWyVfatwRd7lgCpVmPJ3/N8Lnp7yPPUsTWOxbQJBETTzZ3Ga1HCEyEojY/1mvpbckCEk
         QyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=/SSf5BVafpijdSXMMngYQC9Ps4BVJNDNF+wR9WJ49aY=;
        b=Gr2PLfo4HV3pWbybTZBoEsMbDYcAuGCCIwYlfd6CrPO3weJpPm76S3fPVnHNdZZcBN
         bJZchr0tvD6kfcxzvnt7QqTnov7mh4BC1asNAqSHeq65AW3/iaTROAk2/kUnhiyJ39BY
         hKjapulWVMIOVvSLJVH1dnr5pj8bV67p0WfCMWGowyUZEWvRPho3H9lQkSNXbRL3KbV+
         UVvzYuXarG+mGM9p7aUs3VCvFp5ZRKu9lVBzDhAcV8N2Xcyie8W81RjorwZS/cDC1qOf
         3tP3EVVfD+5gv/xtpRDnwwPcHztDCED8WqTYNqGGSyZSfG6MbbQH+bovZglzl6a/e4oq
         R2nw==
X-Gm-Message-State: AJIora8jb9ZUxZpDaHUTgklpCuIb4hiXp1LPrECMkwJPLRoYIuuj+sRU
        PUIAgQhlkXIS8uQSLMTWYTESXNpfxY3tQw==
X-Google-Smtp-Source: AGRyM1u5iCKgESsTDjmfNJWSQuosMGPLohgU2bpjwaq1iZUpaQFJU9Sq1nFLw/+ZdEWCM4SOs95EWg==
X-Received: by 2002:a05:6e02:1b8f:b0:2dd:8f33:d8d6 with SMTP id h15-20020a056e021b8f00b002dd8f33d8d6mr3576759ili.81.1658939392558;
        Wed, 27 Jul 2022 09:29:52 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p13-20020a02780d000000b0033f8af36a96sm7857530jac.165.2022.07.27.09.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:29:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220727162300.3089193-2-hch@lst.de>
References: <20220727162300.3089193-1-hch@lst.de> <20220727162300.3089193-2-hch@lst.de>
Subject: Re: [PATCH 1/6] block: change the blk_queue_split calling convention
Message-Id: <165893939161.1603239.13356247879677746620.b4-ty@kernel.dk>
Date:   Wed, 27 Jul 2022 10:29:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 27 Jul 2022 12:22:55 -0400, Christoph Hellwig wrote:
> The double indirect bio leads to somewhat suboptimal code generation.
> Instead return the (original or split) bio, and make sure the
> request_queue arguments to the lower level helpers is passed after the
> bio to avoid constant reshuffling of the argument passing registers.
> 
> Also give it and the helpers used to implement it more descriptive names.
> 
> [...]

Applied, thanks!

[1/6] block: change the blk_queue_split calling convention
      commit: b1b9c6f4d078f50b62e8cc0f4d3bd4c87d411377
[2/6] block: change the blk_queue_bounce calling convention
      commit: 4d70e071de1fe363e81fdfd7b0b1686355120fdb
[3/6] block: move ->bio_split to the gendisk
      commit: 1be3479b85330141b54a102903e5f07948362695
[4/6] block: move the call to get_max_io_size out of blk_bio_segment_split
      commit: 0ef1e5aa4337e291e9fe590e01e1da3021be6743
[5/6] block: move bio_allowed_max_sectors to blk-merge.c
      commit: fa785c340621a4da8f6ee70b6e5ad263c4c4bbb5
[6/6] block: pass struct queue_limits to the bio splitting helpers
      commit: c9ca8dcc66a99d1123f0fdc2dc161436b93d194b

Best regards,
-- 
Jens Axboe


