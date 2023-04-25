Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47900C77B61
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 13:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjDYNsa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjDYNs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 09:48:29 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119C4133
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 06:48:25 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-32e74139877so1094695ab.0
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682430504; x=1685022504;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZwRlr+hy/zUh+AabZX3wrvhWJ7uoRqat5P5byj3iBM=;
        b=y2xcrkjONsb2tcCQrQC6OE9FbjKXCxpPwQibhOv105RREvOPcrEy0ApmTQznllayUY
         UnMdJjdl7UcohtCxklKbUoprb1tLGDXs7tPtwbrpYpXjbAgptaFQsSgc3tX94OfP87qJ
         Fk6Vv4PJ/V577Kqg0PfYMzGlLtQlRPsBCH3IneiXtq1u8aXbs1kigyCWW1vCx6o7pnPd
         vbw68LqkIM7ztMinqzQ9AydT2sNMNdwOImjpAFenUVYs3FiTZV7hqsTbtxVgJq5cQq5f
         wOPuwAuEtQwUXD5LNh2FsShU7d2KwrMdiSgc7h5ZT2h6Lj8axmNjp12qjK8HDAyzibIU
         93JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682430504; x=1685022504;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZwRlr+hy/zUh+AabZX3wrvhWJ7uoRqat5P5byj3iBM=;
        b=T3LTfoKeaN6k9gQjZbVzRra+KfG8WyQw6J8HZArOOEZw6DPfemTf/Sz/rksydlyD3y
         b6Pib9x3J6my9SfGi4ke0t2Jv3iiWAdx5w6r+HUu5iMJRWRbDbYKlIjBzywCc3ByWh2/
         BPjlYMt1LA9Eb+NZH6KWyfdH86GMi6XPwXRTfpSFuxvS+0n/PUIEJV9D5aGKQfRiBf+I
         Ybj35ix/taQKlSnlALx5wfQS3E0lqgWCL3vN9g0ZBWZ0PkHg+KJzj74t2l6ZFAVZWWwC
         BYH2qC0xwC4nP2HnPBjvFyQzcMawFLHBUsXJloowPMbM86lX66sX9UxXYtnpwXUVevl2
         Hnnw==
X-Gm-Message-State: AAQBX9enHUpMl8EW5KpEA8gojsxggevq784RBW9zLIbE+P89pzu/++52
        aRX97Zv7xN550RH8eB0VSWgxfw==
X-Google-Smtp-Source: AKy350azkiWJEsqUbWopmNtBmN198gwlCJJkTgG8iwbb0OM0fay/vHbhRl2xh6tFaRHS51Sp650VGQ==
X-Received: by 2002:a05:6e02:1609:b0:325:f635:26c5 with SMTP id t9-20020a056e02160900b00325f63526c5mr11650283ilu.3.1682430504422;
        Tue, 25 Apr 2023 06:48:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m11-20020a056638408b00b0040faf78330asm4233147jam.28.2023.04.25.06.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:48:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Changhui Zhong <czhong@redhat.com>
In-Reply-To: <20230425034154.110099-1-ming.lei@redhat.com>
References: <20230425034154.110099-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: sync part's ->bd_has_submit_bio with disk's
Message-Id: <168243050382.16933.11939896925923255565.b4-ty@kernel.dk>
Date:   Tue, 25 Apr 2023 07:48:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 25 Apr 2023 11:41:54 +0800, Ming Lei wrote:
> submit_bio() always uses bio->bi_bdev->bd_has_submit_bio to decide if
> disk's ->submit_bio() is called, and bio->bi_bdev could point to one
> partition device.
> 
> So we have to sync part bdev's ->bd_has_submit_bio with disk's.
> 
> 
> [...]

Applied, thanks!

[1/1] block: sync part's ->bd_has_submit_bio with disk's
      (no commit info)

Best regards,
-- 
Jens Axboe



