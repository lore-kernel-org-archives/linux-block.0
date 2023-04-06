Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB635C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 22:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbjDFWSJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 18:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbjDFWSF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 18:18:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3283D0
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 15:18:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-627ed1ac61cso345166b3a.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680819481; x=1683411481;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR0qElr6GKo/8lkQEKKCuizg5Rqf+FVH+Y9MEeaocBc=;
        b=CTDk8fXkSi/2fH0SOj+GXvVRH5S6QA5imppnrt/gwouT5W76pTHwZ2OV1K8esejpns
         TffeSpkqOtZP2Z5mZjGsLyzV6VoFwUpYdcj7qS98MYnvtbxy6HSg0PTolPQxsigIO8eg
         4CAnHnFzMsEINxDQzCJkexnixAiUsTiW0MvKIj6J5+E1a/czSnpoHP6c8DrlW0oyqZVH
         sjoh6AP2ScqUNr7aPoSMs1qwcOQ/juvCZ3A3EwZTWdQ6XRZNAp1p+ymIA04jqyqzCN+H
         amOl6FTl3SqAE4B2kVVMWWZvtJkvPrRhiumf7BeCGBT8MjB00nQVz5d8Ri1wF0740flP
         8Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819481; x=1683411481;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FR0qElr6GKo/8lkQEKKCuizg5Rqf+FVH+Y9MEeaocBc=;
        b=ZKha6ZWHzXPVT52LzvEXMB7Uy+8CeQubVCHgdv3w0u19o+2Cuyu+lSYrbqmKwW9NMB
         t+aFNiGfZ1HnX3GxhZek0L10hOxf2q5kIBIfVRdGdtkbuazGeBixLJ9SUvQPQSXzwkpJ
         dIYArtDQaKiHktsewaaxM/59UPTHGpEeQxQI7REB94G18De/EM5KrlW0w+Sjd4Zi7lwT
         6aHMSWMm3m7uqeP6ix9OzJCXeaPIBrNPg7ixA7v/We/xcPHxdHG+OFoQCdamirrCHee/
         5S1e1cZ3CVei4u3d0ZzeFY4uUWzWv1xbI8o66aGoWYKH9dSz9kw2WHY6U68SU4g9ClVI
         UMBA==
X-Gm-Message-State: AAQBX9csoxob19vB+MbT9oeP4QRbkCKZzjeTvLJmPtHwE2Uvv2CGhwoQ
        6OigQtyVJDPOK+5NKnIU/OXK7g==
X-Google-Smtp-Source: AKy350YnD2suF/VB7J9ZPEFqYHepBpgtDLWT610MimLUIt52lT9asZClyes4UdkFaR3T5fD5/4MfHA==
X-Received: by 2002:a17:902:da81:b0:1a1:956d:2281 with SMTP id j1-20020a170902da8100b001a1956d2281mr632872plx.3.1680819480605;
        Thu, 06 Apr 2023 15:18:00 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902b28800b001a245b57963sm1815051plr.173.2023.04.06.15.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:18:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406145050.49914-1-zhouchengming@bytedance.com>
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 0/3] blk-cgroup: some cleanup
Message-Id: <168081947971.7640.13634484209341526558.b4-ty@kernel.dk>
Date:   Thu, 06 Apr 2023 16:17:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 06 Apr 2023 22:50:47 +0800, Chengming Zhou wrote:
> These are some cleanup patches of blk-cgroup. Thanks for review.
> 
> v2:
>  - Add Acked tags from Tejun.
> 
> Chengming Zhou (3):
>   block, bfq: remove BFQ_WEIGHT_LEGACY_DFL
>   blk-cgroup: delete cpd_bind_fn of blkcg_policy
>   blk-cgroup: delete cpd_init_fn of blkcg_policy
> 
> [...]

Applied, thanks!

[1/3] block, bfq: remove BFQ_WEIGHT_LEGACY_DFL
      commit: e9f2f3f590289681c71d0137d4e5e88421f934c6
[2/3] blk-cgroup: delete cpd_bind_fn of blkcg_policy
      commit: d1023165eef83dace7cc6299af904f26272baaca
[3/3] blk-cgroup: delete cpd_init_fn of blkcg_policy
      commit: 650e2cb50f3fc45d0585ed8609db9519f6c9bcd8

Best regards,
-- 
Jens Axboe



