Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B787CC0015E
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 14:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjHKOM7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKOM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 10:12:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4156E65
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 07:12:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bda3d0f0f1so2267765ad.0
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691763177; x=1692367977;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWMKdnKHrY3LQ9ReS3XwKKHFwVtuTf0+tBs6vf39oT8=;
        b=ad3sF0Wk5FwYKsnJyn8rp/uYplx8QvXFTFPuX6slqoJ0rG30m4ydbRabAgWupwzr2Z
         fJLRWDJfTkQ285jQMj9pZsCSsuA44QfT3n8X0C6dQUywz0sn20GuiibBH1DGHxLA42nN
         sbe6hNOUgCr1DytcXdi2vDecqymQiQxBnOwgxNs/pKbTu4g/debR3e+YYNjHhVf/lwir
         oI6oAj1aSxFpru89EKB7n5+rsHcfJl0d9Nz3NaCtmejMDecbr/+6NZZib0ViFYl+lMc4
         qNeugB6bCtbZTKQakX72trtAZGMnHdaaNuT6zmY21JxCGjgX848GQqaRFBYy1I8Gw2m4
         ZEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763177; x=1692367977;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWMKdnKHrY3LQ9ReS3XwKKHFwVtuTf0+tBs6vf39oT8=;
        b=mI9oganBkgLrs2y1wY12aTMBFxJD3w76U4ebYv1U9iZaar17NKEuns9x7AgvgKlGwO
         JrkrhgQ2bXpn0ubwwHHfG6tPbuu36RCF0dtqXhwjvLRnPh/21MvFRgm75T3sxn+TG1Gs
         Bk3lXsyfUjwqchfX5gTlEl857MQc7g4D1YKuUbT8om2uEjF/Ams47fODlaw1IcJSa97F
         dmlrnwx5Ry9iLLHQJtklRl2AJxJ+i1R3dN4TrTkHF7LCqoYjMAuEPVo05CmnX/stVE1Z
         BCoksyL6C1tA8r/JvdllsMtpidqmEzY0FXMSeg+zXYTgvyCe6sFRVDjrYuD9XcqBivdp
         m3LA==
X-Gm-Message-State: AOJu0Yy+qtvIW50a2iWYzyLhZhjDH+lCbyDNKL8Ou1xj+DeVE6KZqdM5
        whFVb344QAaKvnODGY2am8Nu9fReGCJsBGmQAKQ=
X-Google-Smtp-Source: AGHT+IGvJUiiaYudbczfqwHt6x/VdZTMQY2y+E3p36rtGfneB9ar0Vi58o1hQWC2pD1xaW2kJVo/sg==
X-Received: by 2002:a17:902:d503:b0:1b8:95fc:cfe with SMTP id b3-20020a170902d50300b001b895fc0cfemr2309319plg.3.1691763177250;
        Fri, 11 Aug 2023 07:12:57 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b001bdb8c0b578sm1559521plk.192.2023.08.11.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:12:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     josef@toxicpanda.com, mkoutny@suse.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, yukuai3@huawei.com,
        linan122@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng3@huawei.com
In-Reply-To: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
Message-Id: <169176317573.160467.10047297090390573799.b4-ty@kernel.dk>
Date:   Fri, 11 Aug 2023 08:12:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 10 Aug 2023 11:51:11 +0800, Li Lingfeng wrote:
> Commit a13696b83da4 ("blk-iolatency: Make initialization lazy") adds
> a mutex named "init_mutex" in blk_iolatency_try_init for the race
> condition of initializing RQ_QOS_LATENCY.
> Now a new lock has been add to struct request_queue by commit a13bd91be223
> ("block/rq_qos: protect rq_qos apis with a new lock"). And it has been
> held in blkg_conf_open_bdev before calling blk_iolatency_init.
> So it's not necessary to keep init_mutex in blk_iolatency_try_init, just
> remove it.
> 
> [...]

Applied, thanks!

[1/1] block: remove init_mutex and open-code blk_iolatency_try_init
      commit: 4eb44d10766ac0fae5973998fd2a0103df1d3fe1

Best regards,
-- 
Jens Axboe



