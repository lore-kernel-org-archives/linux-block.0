Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5986AFA373F
	for <linux-block@archiver.kernel.org>; Sun, 23 Oct 2022 03:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJWDCy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Oct 2022 23:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJWDCw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Oct 2022 23:02:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58EC1E4
        for <linux-block@vger.kernel.org>; Sat, 22 Oct 2022 20:02:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g129so4284621pgc.7
        for <linux-block@vger.kernel.org>; Sat, 22 Oct 2022 20:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM5gJHOnivLnvLSSbR9bvNlNc5ldgiHnzUjRHLcgvbU=;
        b=qd5Kz33mh+7AO0dVcQ+c7EyyLSmJkMhour9nYFlmFGTktHVOXpNha9k3JhuJSZF+zD
         UE2RXd/ePi8/QZEOYyUV0LpLttN9k9SNBV0B5MExwgCyfC0F2w6Sjs+fKqlXNLFrr0os
         qKDJvX4pUKvDnEoS5UMC3WcKEOSl8/YXQ8u7T+MaqDAyZy/ucbEF5bXn6iV0waJT3Q1A
         zu7VwaenZ9BTr6djmsNX0MgrW9sJdNrE425K+e0LGOv+k1iFbTp9VL0610juVNRTtQvR
         6PJmiU3ZZ7lwZrCo99zGDAM1azg3u9RbdQxuntvNk1ttFq4ICZCAHX3MwV80wuvfMxPO
         /kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM5gJHOnivLnvLSSbR9bvNlNc5ldgiHnzUjRHLcgvbU=;
        b=2osG1Y4WvYG87tcQSeQ0/RW+LJCVgzbcC4+pOML3ok3yljab2Dqg7DcaBsPueT5S5C
         8tT27DxuJxU9y4u2tpegKk+zjLPYeyiRe+iKNeEFwfRRv634OMH3aljDhloowA6uxx52
         uV0FXxdJ7xjWXCRxEPwLH31tN0fDdmVZCPBETKHKNvI8YGOrsOYY2YNUexj7Kwmu+FKh
         +gXi8asZLvQmqFKD+YftSk7Eve7IddkKTV3z29ZiAuQB5EP9vW9MQu6+YAGwQFUJiMyD
         mU6RD2232D8AD+0IkZ303YPkXFJmVLDsi+cvCgQii4pdzCdyCgPFtUjEGWcOxj7Jefxa
         /akA==
X-Gm-Message-State: ACrzQf1bTv73HXzIiepNYiJYrRGu4NYEKnTG4fYySKRvk9gFfdx5jkez
        dEpDPo1isthrdrvR88Rzz1s2+Q==
X-Google-Smtp-Source: AMsMyM790aDklrOEICsMHtcknQnjRuh3Z1xara5tff7NEOLvBKd5wjuUk8H/Vh9slA/TCXO2Y93SfQ==
X-Received: by 2002:a63:9144:0:b0:45f:c9f5:1bb with SMTP id l65-20020a639144000000b0045fc9f501bbmr21925716pge.165.1666494170286;
        Sat, 22 Oct 2022 20:02:50 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w186-20020a6362c3000000b0044a4025cea1sm15023467pgb.90.2022.10.22.20.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 20:02:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai1@huaweicloud.com>, ebiggers@google.com, hch@lst.de
Cc:     yukuai3@huawei.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, linux-block@vger.kernel.org
In-Reply-To: <20221019121518.3865235-1-yukuai1@huaweicloud.com>
References: <20221019121518.3865235-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v5 0/6] blk-wbt: simple improvment to enable wbt correctly
Message-Id: <166649416867.43324.13666623072880876901.b4-ty@kernel.dk>
Date:   Sat, 22 Oct 2022 21:02:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 19 Oct 2022 20:15:12 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> changes in v5:
>  - code adjustment in patch 4, as suggested by Christoph.
>  - add review tag by Christop.
> 
> changes in v4:
>  - remove patch 3 from v3
>  - add patch 2,3 in v4
> 
> [...]

Applied, thanks!

[1/6] elevator: remove redundant code in elv_unregister_queue()
      commit: 4321c1ad4abe05fb3683745ed52d0ca17918d537
[2/6] blk-wbt: remove unnecessary check in wbt_enable_default()
      commit: e2c2a27a4fef0af09bfb50c017d1d1962aa8784b
[3/6] blk-wbt: make enable_state more accurate
      commit: 563ee8c7ebfa01d43fa9a785c562318b3f6a587b
[4/6] blk-wbt: don't show valid wbt_lat_usec in sysfs while wbt is disabled
      commit: a66d2566505c819261591fb2462a99069c43db55
[5/6] elevator: add new field flags in struct elevator_queue
      commit: dd58a3a032d5b53571e9934b23a4ceae7b158db0
[6/6] blk-wbt: don't enable throttling if default elevator is bfq
      commit: b192851f14d980f8ce794e747adc4a2418527a75

Best regards,
-- 
Jens Axboe


