Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15283C54EED
	for <linux-block@archiver.kernel.org>; Sun, 29 Jan 2023 21:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjA2VpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Jan 2023 16:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjA2VpU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Jan 2023 16:45:20 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776101420D
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 13:45:19 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q9so6396404pgq.5
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 13:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mlWGWk/xGZIts3NL177gYapbWeRI/F898dfij2bn5Y=;
        b=VUpekjT4eobTtgSswm2s+LU/r9TV7s7D3lDG1sNT1jYByWNdh5CN5OPW1Tv7HVToxp
         eXd2GHd79ERXvAQiXiSpgc3bYsW1zdr32gwYedjPB08H9RPe+CR/R793Pe5t37cIGa46
         yeXQ6r26Hk3pN2sf2GlH/RpHmVlWyZfTA51hg7JSREf6w6woSa1m7hGt67FlUDJWNw9H
         a44BTWOG0DFl68XvsvA/YtdTBEq+dVJeNhiHrx+oCEQXDvYzy/pShvVuNkRvP2Hw3cv0
         +l300uvjTQvOkOQUhHP7T/Oj/cnGX26pjapjNmTv/eAenZGsGWAUDY13Ffmj9fJlouP7
         D/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mlWGWk/xGZIts3NL177gYapbWeRI/F898dfij2bn5Y=;
        b=A6Xkf+k2Wk2ZMvvygCPpeM8nGTZyFMU+C72Dd8wFA/8uwFBX+Eu24PA78Yi9R9ZLGB
         TZ97EhzcjvsxFHtsRumhnqT+OYJsxyWcW2E9sAWigFhM1lZENIwFPpu8k+5QgSMmZnZE
         YuhNWJLYojhL7ObxS4ytt/w/+rOsZUa5KfwXL1gh8NIQpDDtGyJMZSIuslfjQReXNt02
         ZsVFBZrfs7M7mv2Igpj8sN6WIUvjRDEpdCSBrdS/q0GAKuomrihmao6D1SkOR8o5jWR4
         m92Ev8NIZ7BiLcz2D2yKug3P9IvWWqW8y2e8zbcHW6/x0pabfq0noYc5XTU31pGMHNEf
         3e6A==
X-Gm-Message-State: AFqh2kpJGuK4iN72cCpQdHsX+XY8E6KXAnocRsOIMUsLZg6gpOsr5x/x
        ywlBRT1u+YBA/4kfETOYB/Gb8JMWhEGZxJpq
X-Google-Smtp-Source: AMrXdXtsvnlhy1C1Bo22+pe5X20bbQRF+CKJjGRH+4jc3FrfRPhRtkK2qI0LPGwV3zDdJ4Bm/e7btg==
X-Received: by 2002:aa7:9114:0:b0:57f:d5d1:41d0 with SMTP id 20-20020aa79114000000b0057fd5d141d0mr10615241pfh.3.1675028718976;
        Sun, 29 Jan 2023 13:45:18 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v66-20020a626145000000b005882b189a44sm6032360pfb.104.2023.01.29.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 13:45:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
In-Reply-To: <20230128030419.2780298-1-zhongjinghua@huawei.com>
References: <20230128030419.2780298-1-zhongjinghua@huawei.com>
Subject: Re: [PATCH-next v3] blk-mq: cleanup unused methods:
 blk_mq_hw_sysfs_store
Message-Id: <167502871809.54799.13535290595162039137.b4-ty@kernel.dk>
Date:   Sun, 29 Jan 2023 14:45:18 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 28 Jan 2023 11:04:19 +0800, Zhong Jinghua wrote:
> We found that the blk_mq_hw_sysfs_store interface has no place to use.
> The object default_hw_ctx_attrs using blk_mq_hw_sysfs_ops only uses
> the show method and does not use the store method.
> 
> Since this patch:
> 4a46f05ebf99 ("blk-mq: move hctx and ctx counters from sysfs to debugfs")
> moved the store method to debugfs, the store method is not used anymore.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: cleanup unused methods: blk_mq_hw_sysfs_store
      commit: 52627f3c2935342dbceb2ba6fd710f1deac627a1

Best regards,
-- 
Jens Axboe



