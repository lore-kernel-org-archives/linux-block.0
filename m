Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B640C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABFE61164
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhJQBQ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhJQBQ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:16:26 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8975AC061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:14:17 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r134so12137867iod.11
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ksdy1ZDQjJ3U+oSYF5WXAGWFZmavO1zgIiaiYUGroEw=;
        b=XpAHq8FN7pJxxgl4PuYavOET6tMu/onIKGScNgLSIhFmJEDGpKfh7i92+KPwY0Z41+
         0v9OSEL2xF+VZnffQHa5AfVUxo6hBkKIrhkFWMrk3Khy+DO0+aZ+Kp7w54HNYtRIJkuK
         IC7RaPQSOjeAvdElvlt4+JtdHw2ivqnwasZrDwwdj/By9sJ/VoJGamhOH21v9by5GhfS
         tXobAkh2lBwByNQb2W4PX7ZVxEHXS+1kik9HhfBcpCI/2eD4Pl8Sk/nCojzkFCzDqMQ9
         JcIljyaTVQK5S+ueM0F44FT7jjpSlwY8BbqCK899UiUYNjVG8x4zVqmzRG5NBFKr0jY0
         bsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ksdy1ZDQjJ3U+oSYF5WXAGWFZmavO1zgIiaiYUGroEw=;
        b=OM0G2G/rJK0teuoRu5WTDkjPC2E72BLBNQrDbzVg25eIvmEdPOg4RFma8B6JtBL2cJ
         UirNqBnhfZCTZ/qBsdIAFHCzUE8Ikp3np6as6A6HH2hpnGtcwx/NoIerpZO3KWzRpiQ5
         5cE03RUyWoQYbotJWg9g0shleFWLUuwWWrZiMFISGNq6na2U26GztJq7gHvPstdpAgLD
         BDvudRyHTs6XZlS1PyTx/SSuofLlJvYqNQVq6QcUgnkkTpxEDA5y35Ri1unyHmcViITd
         CKyT06x07PzFDs7120oVFOqp1XGY701fIxwBYYpc/JEJOJ6vA2trD1HDQtivdx98RX8y
         hLXg==
X-Gm-Message-State: AOAM5330KkJjWvNxnDZsQRDMX+IhqFC9CI4+p5BMqx8mnsj2/UzhHwrq
        Fj+fe0yuLIyWixy6Txs9lq0TwQ==
X-Google-Smtp-Source: ABdhPJxncr5nCE22XzYwBwJZRNe/LRL0D8VOztTd9ET6Q6YkTSQZuOkZS26YdJ1jCUJV6OLeNSuTsw==
X-Received: by 2002:a02:a786:: with SMTP id e6mr13002995jaj.117.1634433256837;
        Sat, 16 Oct 2021 18:14:16 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id r17sm4556293ioj.43.2021.10.16.18.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:14:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: call submit_bio_checks under q_usage_counter
Date:   Sat, 16 Oct 2021 19:14:12 -0600
Message-Id: <163443324620.64541.11214526072686123531.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20210929071241.934472-2-hch@lst.de>
References: <20210929071241.934472-1-hch@lst.de> <20210929071241.934472-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 29 Sep 2021 09:12:37 +0200, Christoph Hellwig wrote:
> Ensure all bios check the current values of the queue under freeze
> protection, i.e. to make sure the zero capacity set by del_gendisk
> is actually seen before dispatching to the driver.
> 
> 

Applied, thanks!

[1/5] block: call submit_bio_checks under q_usage_counter
      (no commit info)
[2/5] block: factor out a blk_try_enter_queue helper
      (no commit info)
[3/5] block: split bio_queue_enter from blk_queue_enter
      (no commit info)
[4/5] block: drain file system I/O on del_gendisk
      (no commit info)
[5/5] block: keep q_usage_counter in atomic mode after del_gendisk
      (no commit info)
[6/6] kyber: avoid q->disk dereferences in trace points
      (no commit info)

Best regards,
-- 
Jens Axboe


