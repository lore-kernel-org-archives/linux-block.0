Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97429C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 01:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbiCOBQS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbiCOBQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 21:16:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D5E3464D
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 18:15:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u2so27280ple.10
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 18:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=YYXrSkA7DcKX+OZWoRaWmcezxkTTC0s3clPNsqj0tSs=;
        b=zf7n+VLD+TlQXBul0FjxSYL20r03zWROyOA5y4hxMFq+RWaP03LQynIiq5YiSKbkkk
         4FokEd9K2SBXzY3lcpBYaxnM/XggXqkIcGAl5r05eOeLMuqueQt1qHpL0y8ONY4UkRWB
         nBOQR2g1Id/IcgIVc7vZwbInbJNmzdP7pfzuyCm25Qt9oioTkTV7badO8iz5bBmcssLB
         0KIgZROVlTgkXqbEl5+PXmSTXM8mvNynBnTBPRurvJ4XazuIINdwhDb2y8z6I8b9DvMa
         CFUppDDNwXn58Mk4IdX6/z8JxMriMX7GpU4cFu1j/62+ZYdkJ1XGn6qd4uA2m29bS33j
         5CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=YYXrSkA7DcKX+OZWoRaWmcezxkTTC0s3clPNsqj0tSs=;
        b=tRIe4+OCva4erPf63XaTlQ7BOf+bi2rYLevGoDMdSTSzn6JZG5odHEPW1n9MA9nTLG
         f8t1rxlwYMt9b46Qvw3ax9tpPh7orQ59aV15SKkZm3UE/FajEifNjw4EfxzDJxFvgzCn
         HoCXgqImlIdQ2MZW6XPrQIo5VcWqQkYgLOLyxePda8v9nBIVvhgeWMluqh1Ry06boid8
         xmLFmy8otOclmaXXzgg757ikKTeYdOjf4QuQkET9pmvsdLxCVdyZCH1LIAsjVmaVZUL3
         XmmLFzQZ2AucPJnMf5apdHdLMpdIfcAxJsOQAgMo6h5FWB0q740d4TZ7J5b0MK31SK14
         Uzyw==
X-Gm-Message-State: AOAM533W+EfCKH2kHDBGFnLiIf7p3AcjdSRBg1LerBPT7hlE+Z7xDW6J
        n5LYcXpG1p7bOnxXei/YD+r50Q==
X-Google-Smtp-Source: ABdhPJybZTuIVdsdqiq9XXOjoE5OhuzK9g5Qb+orkGS7bDm7/WhD/PUXavEFFaj8efC60jR46TlAXQ==
X-Received: by 2002:a17:90a:1f4d:b0:1bb:a657:ace5 with SMTP id y13-20020a17090a1f4d00b001bba657ace5mr1830551pjy.39.1647306907272;
        Mon, 14 Mar 2022 18:15:07 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090a7f0600b001c63352cadbsm510847pjl.29.2022.03.14.18.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:15:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <Yi/eE/6zFNyWJ+qd@slm.duckdns.org>
References: <Yi71WZ3O9/YViHSb@slm.duckdns.org> <Yi/Us896/ftt5l4f@slm.duckdns.org> <Yi/eE/6zFNyWJ+qd@slm.duckdns.org>
Subject: Re: [PATCH v3 for-5.18/block] block: don't merge across cgroup boundaries if blkcg is enabled
Message-Id: <164730690621.219116.11184082869298025827.b4-ty@kernel.dk>
Date:   Mon, 14 Mar 2022 19:15:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 14 Mar 2022 14:30:11 -1000, Tejun Heo wrote:
> blk-iocost and iolatency are cgroup aware rq-qos policies but they didn't
> disable merges across different cgroups. This obviously can lead to
> accounting and control errors but more importantly to priority inversions -
> e.g. an IO which belongs to a higher priority cgroup or IO class may end up
> getting throttled incorrectly because it gets merged to an IO issued from a
> low priority cgroup.
> 
> [...]

Applied, thanks!

[1/1] block: don't merge across cgroup boundaries if blkcg is enabled
      commit: 6b2b04590b51aa4cf395fcd185ce439cab5961dc

Best regards,
-- 
Jens Axboe


