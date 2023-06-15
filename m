Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAAEEB64D8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 02:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbjFOCY0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbjFOCY0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 22:24:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5380C1BF9
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 19:24:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b0338fac5dso9675965ad.0
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 19:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686795865; x=1689387865;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSR50Y8VWLWHMMq4nms0HKVmdE5u9BBnFe5bAJ0HtnY=;
        b=w1vYVgJzS9pjyHpDGocrQGNlRMjxacXj+jIRXxU0M+NratXeH2J2xuxppoGEHZSovM
         K6SGNblnvVnW6J4J5WrkRU6J8XezgqcuX8cZPLTROTqY8UMesNzmU+GCI+7XCjo4hjwz
         0BrieDbaOjOvWm1XYpyddJtBmirQsd6sdsbIL0mi+tEBwpZ3WIbpS2n8aghMYuUSABVQ
         erOBT//6m+9y5vr809Yj0aLal+bzxoqzyvSia9giXgmhe/rPjPJkK39vcH00NV97cwxR
         XCILag4gHkBoyy4IO2LZZrn04hbQJWqxpd6ubLSSRazSfGgF7vx1MpiPC+5RUO4eoLr1
         BZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686795865; x=1689387865;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSR50Y8VWLWHMMq4nms0HKVmdE5u9BBnFe5bAJ0HtnY=;
        b=cd7FZ0DYPWE/H6+KZAr+i1neoqktuj+qPXBuI0vpmikw1XdVEGvHk15BTffvxXqIzO
         kWTTxH1iRTBnT405VjJm49/fgsl/zLhxAncxHvTyqTXYVSr3XkuArskn3va7uZGkjwwd
         rN2BROylTCXxzkMPptKNuEbD3MmjIi4llm+NpJDjU3QFY0GVrTDaXSIHDIHwMrNp4cmx
         bxWV20X1N8cI/exKAXUBjMgWOEtEns7umE/kfrhfnO6B5/Lm+IV4H+OVmCr6YpdJwoL6
         CpaztQbqmBiMdGHuBUog8WY++7FP7T39zCYm9QilAEWgIwlY43kdsIgHsJ+54G5Ghlbw
         0sgw==
X-Gm-Message-State: AC+VfDwandB0BXV89ZessS1sDhPzFRq1uAuUGhtJ/PZx8EiTzuNdl/PE
        SU0WcX6rUgfYqrJxE3fslQ33diff8BX5btq+fcU=
X-Google-Smtp-Source: ACHHUZ5D2OcFpcRCZ+WTQ8jJZZpZqq2lo8r/m6n+auc6W6Vc799H8O2HZWqfA6aNnF4o9Emqd8jxpA==
X-Received: by 2002:a17:902:f682:b0:1b3:d4bb:3515 with SMTP id l2-20020a170902f68200b001b3d4bb3515mr11038855plg.0.1686795864826;
        Wed, 14 Jun 2023 19:24:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902714b00b001ae0b373382sm12977035plm.198.2023.06.14.19.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:24:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230610022003.2557284-1-yukuai1@huaweicloud.com>
References: <20230610022003.2557284-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v5 0/3] fix blktrace debugfs entries leakage
Message-Id: <168679586333.2051714.1943947298850230853.b4-ty@kernel.dk>
Date:   Wed, 14 Jun 2023 20:24:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 10 Jun 2023 10:20:00 +0800, Yu Kuai wrote:
> Changes in v5:
>  - blk_trace_shutdown() can't be used for module, add a new patch to use
>  inline function for blk_trace_remove() to fix build warning from v3.
>  - add review tag for patch 2,3 that is the same from v3.
> 
> Changes in v4:
>  - blk_trace_remove() will trigger build warning if blktrace config is
>  not enabled, use blk_trace_shutdown() instead.
> 
> [...]

Applied, thanks!

[1/3] blktrace: use inline function for blk_trace_remove() while blktrace is disabled
      commit: cbe7cff4a76bc749dd70264ca5cf924e2adf9296
[2/3] scsi: sg: fix blktrace debugfs entries leakage
      commit: db59133e927916d8a25ee1fd8264f2808040909d
[3/3] block: fix blktrace debugfs entries leakage
      commit: dd7de3704af9989b780693d51eaea49a665bd9c2

Best regards,
-- 
Jens Axboe



