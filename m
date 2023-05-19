Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BBEC77B7D
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 01:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjESBlm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 21:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjESBll (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 21:41:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DCE10D0
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 18:41:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-645cfeead3cso499478b3a.1
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 18:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684460500; x=1687052500;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIvQqVcr+IQ0Thdi6dOw0ZHUYYVkFTmTShPKMfXt/QI=;
        b=z7idemPUBmmKSo9cenMcUcFwqa9g2n1nfGyJ2qQg2dhfiK6D+HKJfYvU8EHxSV62sg
         MUwFNmEjp3NuwpQmdFcZxTNAFHbUrczNjh58IHnmvMB6p8AluuUUPaYVNJgcODSu3p/F
         16PAVXT+gEb9AtYHCTnBeeDndZwLY9FT91fQn8EppibJlOD+wPuC/t9r9vMJ/IUsNSyY
         uuMuVPv4FQR3iQa/rk0p+LeYiGRU4CVRIuapF9Q6Go/MVH4RSeAk+I+rvf/AHgEa8do+
         YiUz+hMlMoX1O8ff8YjrwwKlmstYXEI4K8bWqjBuIKRm5kCAPJsyBeegux8WnIjRYLQs
         KSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684460500; x=1687052500;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIvQqVcr+IQ0Thdi6dOw0ZHUYYVkFTmTShPKMfXt/QI=;
        b=X+V1DPLfZI1vtyKrKF8WjlKKNhsaR2khLAvKsgz61hp3rVbNyBTSouFhIaDCrGcRxn
         iao0pkNHKDP31Rxq1yrm7tUp5bNoD22mn/ITtEBkEwJXmLzRnE+dCzbe5ykV5LTPGFt5
         Fy4ESHHdfcg+EYHAjqf0E0Bvp+dNnpRei5SzXf/mFZKbc8X+GD15ZhTjV4iPf9n7n3Mk
         fehlv5kvp56NXu3VBEG+4F3V4zA/ylqdUSSKhWWGeZcJ54canQOkUzQdjvkRanWe18iX
         kYeEL3AdJIqXDCitsBYYH3qTMMurOYhxhpqcWa02U571T4mGKnxmkFwvD2bmos2frj/y
         jZ2g==
X-Gm-Message-State: AC+VfDz5LvJ2oi5tTWEhrVFmRR+oYdD45Fdhd+MmpCLIS1XPwX5mF3xW
        sS61+eu9QJqG8qJZfGx+Uln6Tebk2YZzci+VsKc=
X-Google-Smtp-Source: ACHHUZ5+GIO1Xg17Gc7hxxBH2qaZiuL/MmZSb/FeyPQWQyeoBNfO7bGJym6VY/BTYC3KSa3+uAJXdg==
X-Received: by 2002:a17:90b:1e44:b0:253:407f:2506 with SMTP id pi4-20020a17090b1e4400b00253407f2506mr685654pjb.2.1684460499888;
        Thu, 18 May 2023 18:41:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c16-20020a17090a109000b0024ffa911e2asm325191pja.51.2023.05.18.18.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 18:41:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
In-Reply-To: <20230518053101.760632-2-hch@lst.de>
References: <20230518053101.760632-1-hch@lst.de>
 <20230518053101.760632-2-hch@lst.de>
Subject: Re: [PATCH 1/3] blk-mq: don't queue plugged passthrough requests
 into scheduler
Message-Id: <168446049859.141878.12246667725693827889.b4-ty@kernel.dk>
Date:   Thu, 18 May 2023 19:41:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 18 May 2023 07:30:59 +0200, Christoph Hellwig wrote:
> Passthrough) request should never be queued to the I/O scheduler,
> as scheduling these opaque requests doens't make sense, and I/O
> schedulers might required req->bio to be always valid.
> 
> We never let passthrough request cross scheduler before commit
> 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging"),
> restored this behavior even for passthrough requests issued under
> a plug.
> 
> [...]

Applied, thanks!

[1/3] blk-mq: don't queue plugged passthrough requests into scheduler
      commit: d97217e7f024bbe9aa62aea070771234c2879358
[2/3] blk-mq: remove RQF_ELVPRIV
      commit: fdcab6cddef24a26b86d798814b3c25057e53c21
[3/3] blk-mq: make sure elevator callbacks aren't called for passthrough request
      commit: 59f86a9c69ad379650839b41bb01be213bfac9e3

Best regards,
-- 
Jens Axboe



