Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1246CC6FD1D
	for <linux-block@archiver.kernel.org>; Sun,  2 Apr 2023 02:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjDBC2p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Apr 2023 22:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDBC2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Apr 2023 22:28:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FBCFF03
        for <linux-block@vger.kernel.org>; Sat,  1 Apr 2023 19:28:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u38so17057438pfg.10
        for <linux-block@vger.kernel.org>; Sat, 01 Apr 2023 19:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680402523; x=1682994523;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbBXik6s13zjuB8lqR/mXcNtwljV23YmiF9AVCc5Tqg=;
        b=fs4EEMdJIsWQKkCDUlFJconzAAa10y3z9h/ND5chxiuUY/0NLR3/Wy+JZpITiLte7y
         5NhX9P7DGIV9h6gGz4XBQjCcPBRB1LCvM5pjUTBa8CoCkDlAeBCxQU0RIGUvafb0Xzqo
         a0FY8ySc/B8VW9/Bz1/ravjf6gXF3fCj3QoNF2dOUX1sndYgHAeP30nPh5Vy4K+Syy+/
         4n8kYCvaoCdPXQeUfa0Vw8EZorA3NkK740WubnjeTZaQRlSfVz2V+duS1VUFTCCjIbqQ
         hfs0y3Jik8HAKPzvs3YdULuDtzAXAWi82pXbWRsGSxjG7wIDCAf7tAmLKHef4zUjU6Zx
         kLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680402523; x=1682994523;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbBXik6s13zjuB8lqR/mXcNtwljV23YmiF9AVCc5Tqg=;
        b=BB9FD0BxzMwn8ZRTUZxzOPDLAV+V3jniIC8KGH6fCfn1gE1h0D/HkZ4XUpZqFHbrGF
         F5/RUzZLdt46OM05lcqZMnHSyY94VixBU6OGpF+J94pDZSivpbRB1LE7rdbEf/rKefOb
         qm8NepDLhsyIxx+D2+3+VL+Lh7kkuuRzYh1vbPfoY1ciZxgP7p4jfrCvK8L3qOp+G4kW
         heZFWhKJMeg1scR1Jl8Dsp6wX/xYcIMgHW2YfRGbxpF8qCf9NjbArseyiYE1ax6x1L5f
         /Dwr4Yr9xqW6DqjGPUg+e8JpYNkIOVC7D50BTGeFV9TgwYa6hvRy4Q6p/TVm1NIZ1cVg
         fhVA==
X-Gm-Message-State: AAQBX9caB3nm0Gyuhy+LRF8CzSU66rMn7G4QiegM9FTd4raXcEpGXUSc
        lpvlqx3kOabBT+TT+fXYU5JTfw==
X-Google-Smtp-Source: AKy350bAJbY260sAkhMhd0XbnK7IGHPfxtA8wVX6GOSyICoiV+ctVlXv6Fj7G84Y7FbOqRYmHeMsTA==
X-Received: by 2002:a05:6a00:22cb:b0:627:ff64:85cc with SMTP id f11-20020a056a0022cb00b00627ff6485ccmr11929945pfj.0.1680402522990;
        Sat, 01 Apr 2023 19:28:42 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n23-20020a62e517000000b0061ddff8c53dsm4184006pff.151.2023.04.01.19.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 19:28:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Cc:     damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        bvanassche@acm.org, kbusch@kernel.org, vincent.fu@samsung.com,
        shinichiro.kawasaki@wdc.com, error27@gmail.com
In-Reply-To: <20230330184926.64209-1-kch@nvidia.com>
References: <20230330184926.64209-1-kch@nvidia.com>
Subject: Re: [PATCH V2 0/2] null_blk: usr memcpy_[to|from]_page()
Message-Id: <168040252203.200172.2016544685299966439.b4-ty@kernel.dk>
Date:   Sat, 01 Apr 2023 20:28:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-20972
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 30 Mar 2023 11:49:24 -0700, Chaitanya Kulkarni wrote:
> From :include/linux/highmem.h:
> "kmap_atomic - Atomically map a page for temporary usage - Deprecated!"
> 
> Use memcpy_from_page() since does the same job of mapping, copying, and
> unmaping except it uses non deprecated kmap_local_page() and
> kunmap_local(). Following are the differences between kmal_local_page()
> and kmap_atomic() :-
> 
> [...]

Applied, thanks!

[1/2] null_blk: use non-deprecated lib functions
      commit: acc3c8799b9723d0b6a8cd67f8036dfdaa280825
[2/2] null_blk: use kmap_local_page() and kunmap_local()
      commit: acc3c8799b9723d0b6a8cd67f8036dfdaa280825

Best regards,
-- 
Jens Axboe



