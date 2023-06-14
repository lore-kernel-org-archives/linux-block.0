Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BC5EB64D8
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 17:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjFNRLz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjFNRLy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 13:11:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A29213B
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 10:11:53 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33bcc8f0d21so4758125ab.1
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686762712; x=1689354712;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFGm7FqvVo6N2TIKugcE6wuGfwkXCoffvc2Z4/ZFrvk=;
        b=lm1oNKUB9xU8Pb6XFA19Ula4qGY1HRWrLbYsGRzV5RHzhzp7pwTPNlfXwJPIVxA0nJ
         lS2aewP3Q2LDai+BwjNnKBHv4pJ90hQ6cpZMLdko+u/M+lSkgm8XYrzzg18wpdMQ043U
         wBroNJCPhC8P8AxxZnWkw3zjxehqUOI0ZQ2twVjawryi4NAxzlEDV0a6xQxU9ShuBt9a
         3Pu4Vo7mbsM7bHmBYUNsE43Oa0MZDT8BOvemG5mLhkq9epAqbLyAvDmLMqCj36Mhu1JY
         wshaZs+i0Q3UyPO29s23hrcgXtnNYkwp8E2jlL41wew88vO9pymj1H93lM6MMp4MiWaD
         hjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686762712; x=1689354712;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFGm7FqvVo6N2TIKugcE6wuGfwkXCoffvc2Z4/ZFrvk=;
        b=Gve+C1V/bcgN8DEWSYFDrGlvCigaTmiIc+Dss3u38jJhznsDAItq6igh+yOfihqIz/
         37NYJDZzGynxfYkVpz00J+EoBHd2kKooCJe6A3ziSWE7buUoGgLwe9ofRNQ5zDZB5SuT
         eCKNmIvVClxpBxce9XwyJhHJRD4RhKxN2SK86w/NiymTEYo6HXlLk7Cjcy+xlUCGgOAy
         LQJqfB4pQISDeBH+o26g3I1i7zpWxet7mzXAE6GrViZrYKx93RpSxYMvja3/u/+7HPfQ
         f6WA4di0H6/OibZ/fDpJWIO5rGDhQm7Ze1Qutn4BH+Orblpj0Z7HLd7CMLOUj3DBZsvT
         OClA==
X-Gm-Message-State: AC+VfDz7h2NmG7iinmJBGS4MW6GDlFFd4YHiGgkBtmvU0d45ST7l+/Wr
        59xSpyBVH1MRxYSsQzSB2mePTA==
X-Google-Smtp-Source: ACHHUZ6yQRQ1s8D9mzXhZ3rYN6V6cthldCfEgP5WF7NRHJ5KcSo9a5YXXGXUhFA/hu1SGecsAQuqGA==
X-Received: by 2002:a05:6e02:50f:b0:33b:1b5d:9723 with SMTP id d15-20020a056e02050f00b0033b1b5d9723mr10710356ils.3.1686762712334;
        Wed, 14 Jun 2023 10:11:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9-20020a056638020900b00418af04e405sm4313921jaq.116.2023.06.14.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:11:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kbusch@kernel.org,
        amergnat@baylibre.com, liusong@linux.alibaba.com,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, powen.kao@mediatek.com,
        alice.chao@mediatek.com, naomi.chu@mediatek.com,
        Chun-Hung.Wu@mediatek.com
In-Reply-To: <20230614002529.6636-1-ed.tsai@mediatek.com>
References: <20230614002529.6636-1-ed.tsai@mediatek.com>
Subject: Re: [PATCH v3] blk-mq: check on cpu id when there is only one ctx
 mapping
Message-Id: <168676271101.1830690.9612621068004159159.b4-ty@kernel.dk>
Date:   Wed, 14 Jun 2023 11:11:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 14 Jun 2023 08:25:29 +0800, Ed Tsai wrote:
> commit f168420c62e7 ("blk-mq: don't redirect completion for hctx withs
> only one ctx mapping") When nvme applies a 1:1 mapping of hctx and ctx,
> there will be no remote request.
> 
> But for ufs, the submission and completion queues could be asymmetric.
> (e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
> ctx won't complete request on the submission cpu. In this situation,
> this nr_ctx check could violate the QUEUE_FLAG_SAME_FORCE, as a result,
> check on cpu id when there is only one ctx mapping.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: check on cpu id when there is only one ctx mapping
      commit: 30654614f3d27230200b1650f6025a2ce67900b4

Best regards,
-- 
Jens Axboe



