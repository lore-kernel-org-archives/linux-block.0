Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5270FC77B76
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 02:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjDSCQ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 22:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjDSCQ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 22:16:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EFC124
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 19:16:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a6a50dd62cso2618795ad.1
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 19:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681870616; x=1684462616;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Kksh5tvR0QmlHupsDNsoSKV+Z9d9zCydPwVpV6Rn+4=;
        b=CJ+/8s3eMFG+XPUZfG1cfvt+Y4rOCsPFgzMkonFQWRF2ny7Qg9H6lH/+Umb+uczzjJ
         cHEkiCO9UXDKeaKEPaA1X+ZKzUT5P0U2ayvhLBcFV8CmyAf68NArCHpdUlkPBVPfbRRU
         /V7hjGtpv7NP/DtzWST4qxYnvvvxNmpR6saIBJ56ZABc2po5onU5wjDxUgPet8+gKUYU
         JyD+KsxzK1QOcT5WS8gDECre3Gz9lRd+X4Z+vWdQj1TcuDeFkIwzgkMfZgbPifXnzRz6
         8iub/Yn7gdXGwHYfh6LzOJhWapSOfyjloP/bRnJxDt1hWz/8DZ1b76ZEC51YTQ1WVbff
         vONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681870616; x=1684462616;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Kksh5tvR0QmlHupsDNsoSKV+Z9d9zCydPwVpV6Rn+4=;
        b=Iqdtczd/ySPay7r+PIsMC2PrQEbgjxBsVpJV/Vapihufk2c7SBYup8bHGzK42QFjYl
         N8X2BEzIZf7Gg/l9vfEVN7TBcNwCc/FZDwgdG89YHXOJP886PVqwVcnFV9m6T/BUwaaj
         KVeKOfTjWox6a3BPTx43RYfF57XRIyhZ/jgZI3Iyksi8B8/t/tifR5bjqItUqmBPdcsn
         j9uXVhJ36066bvE5Es+/VLRhY96pnRC58wff0luXYCbLR0ZxJ0oIzqUK2v+q2AC8nEqf
         VAGdx0NV1B4GsAyyOFuUbl73uJ9PcMBw1CTVjbzJQP1+o/5UyR0WGBFYl0/Yiyv5B/qY
         zjdA==
X-Gm-Message-State: AAQBX9cofPkCLJ+pOFjOoo/YEexwFo+iegs0ErI2ZuOvh8Ywua1JhEwR
        1CqJxO7v0OK5tUncWd+h7HTZYw==
X-Google-Smtp-Source: AKy350YiXfRDS+5hRkH39Pnx0v2gfGpwmRGfV1F9lTLsih6VI+nW8ZWUshvzLHbO8WfuRjQWnVMi1A==
X-Received: by 2002:a17:902:dad1:b0:1a1:956d:2281 with SMTP id q17-20020a170902dad100b001a1956d2281mr20008919plx.3.1681870615905;
        Tue, 18 Apr 2023 19:16:55 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902869500b001a5260a6e6csm10210138plo.206.2023.04.18.19.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 19:16:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Cc:     johannes.thumshirn@wdc.com, bvanassche@acm.org,
        vincent.fu@samsung.com, akinobu.mita@gmail.com, dlemoal@kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
In-Reply-To: <20230416220339.43845-1-kch@nvidia.com>
References: <20230416220339.43845-1-kch@nvidia.com>
Subject: Re: [PATCH V2] null_blk: Always check queue mode setting from
 configfs
Message-Id: <168187061486.411072.646491124803072068.b4-ty@kernel.dk>
Date:   Tue, 18 Apr 2023 20:16:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sun, 16 Apr 2023 15:03:39 -0700, Chaitanya Kulkarni wrote:
> Make sure to check device queue mode in the null_validate_conf() and
> return error for NULL_Q_RQ as we don't allow legacy I/O path, without
> this patch we get OOPs when queue mode is set to 1 from configfs,
> following are repro steps :-
> 
> modprobe null_blk nr_devices=0
> mkdir config/nullb/nullb0
> echo 1 > config/nullb/nullb0/memory_backed
> echo 4096 > config/nullb/nullb0/blocksize
> echo 20480 > config/nullb/nullb0/size
> echo 1 > config/nullb/nullb0/queue_mode
> echo 1 > config/nullb/nullb0/power
> 
> [...]

Applied, thanks!

[1/1] null_blk: Always check queue mode setting from configfs
      commit: 63f8793ee60513a09f110ea460a6ff2c33811cdb

Best regards,
-- 
Jens Axboe



