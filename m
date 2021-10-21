Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46156C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 16:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253F5610EA
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 16:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhJUQPH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQPG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 12:15:06 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D1C061764
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 09:12:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso1009174ota.9
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=16KxnfD2EjRW7s67gQ2B1gfm7zayQWm3CwLWep3JjEM=;
        b=auDhun93u2KnRwyRu2Jxrnsl8kMD7dn8A6XhWDZfQiulJCbso5jyEFs4nKWw5HPyR4
         amQMp6e/7oxwkD1eVQUnPMk00ciPoqPhlCIPi3KY3l8hCFm0zwoWpPhusCRfm3Q/S1PD
         irdw+J+UgzuweQ2UnhRm+t/dL0huueUPfA4DIYAzxWAemo//pRRwI0a6Wp4QWNKVeJMH
         Dkiu+2yoKgDyoDyMdRPuBj9bQJwr6pCtiQhzb+VNYGnGaYmDIFkQ8sVnxlEbDrfFM6XN
         3R3IIMEuU3PojHvUpMPcqOTQkz1ubT13T/H3jH/il51+JahVT7r/YGtPwTHmQ3H8+9v/
         WaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=16KxnfD2EjRW7s67gQ2B1gfm7zayQWm3CwLWep3JjEM=;
        b=TYAG/cQr19u0XSJi3igu5LhaULSgOnEjstGsaOsewteZ5VRaLZl2zRqGJyYkdWcmkk
         dBVzKzlU7dzFOJMAMlZLIiB5/9R05pDELguQ0VFestiybO/5s83DsdVZXjQIeJh6aWiy
         eh+THNQS8aUUYWJxwHRy1bIwwDCtREieIo6ExEicPE6k8QtFjqQ5wJGsY/dsUQVlY9jY
         YNvkB0T71ymXLB+SNwY3wT9fAntu0QBzgPpGR6f2XSXyOV4ExfAWN4hACf4sZNej3FOt
         xJLrptoTgPEGNm5tHUDd+M4rI3Oqxa/uBqhnrGBwTshh4F3untBnHDe2LhntWLoxfqXA
         82uw==
X-Gm-Message-State: AOAM533eGxB4bwC6J2v6TNJcUUEyPwlRMbUfubNelNLWsRLfmmn/R6YI
        LPaVJw0TuvWjrQLQmDFlG5d0NTFEjAK5qw==
X-Google-Smtp-Source: ABdhPJx3ZysvSA9KzeDjxTDH5deMFC6mxVG8ziElQSLDD8csxNxondJD1QYJDrXyCNF2kicL+NAHhQ==
X-Received: by 2002:a05:6830:2424:: with SMTP id k4mr5474376ots.210.1634832769427;
        Thu, 21 Oct 2021 09:12:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id e59sm1176020ote.14.2021.10.21.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:12:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@infradead.org, josef@toxicpanda.com,
        Xie Yongji <xieyongji@bytedance.com>
Cc:     yixingchen@bytedance.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
In-Reply-To: <20210922123711.187-1-xieyongji@bytedance.com>
References: <20210922123711.187-1-xieyongji@bytedance.com>
Subject: Re: [PATCH v2 0/4] Add invalidate_disk() helper for drivers to invalidate the gendisk
Message-Id: <163483276867.63016.8699085778503440970.b4-ty@kernel.dk>
Date:   Thu, 21 Oct 2021 10:12:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 22 Sep 2021 20:37:07 +0800, Xie Yongji wrote:
> This series comes from Christoph Hellwig's suggestion [1]. Some block
> device drivers such as loop driver and nbd driver need to invalidate
> the gendisk when the backend is detached so that the gendisk can be
> reused by the new backend. Now the invalidation is done in device
> driver with their own ways. To avoid code duplication and hide
> some internals of the implementation, this series adds a block layer
> helper and makes both loop driver and nbd driver use it.
> 
> [...]

Applied, thanks!

[1/4] block: Add invalidate_disk() helper to invalidate the gendisk
      commit: f059a1d2e23a165bf86e33673c6a7535a08c6341
[2/4] loop: Use invalidate_disk() helper to invalidate gendisk
      commit: e515be8f3b3e63be4c5e91dc6620483ed0990a0c
[3/4] loop: Remove the unnecessary bdev checks and unused bdev variable
      commit: 19f553db2ac03cb8407ec8efb8e140951afdfb87
[4/4] nbd: Use invalidate_disk() helper on disconnect
      commit: 435c2acb307f19acc791b4295e29cc53a82bd24d

Best regards,
-- 
Jens Axboe


