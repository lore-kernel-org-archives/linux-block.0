Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A8C433FE
	for <linux-block@archiver.kernel.org>; Sun,  9 Oct 2022 13:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJINsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Oct 2022 09:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJINsn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Oct 2022 09:48:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7CC26AC3
        for <linux-block@vger.kernel.org>; Sun,  9 Oct 2022 06:48:42 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 128so649962pga.1
        for <linux-block@vger.kernel.org>; Sun, 09 Oct 2022 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkNfwa52J7sMrLHZ8QvF0WkiVrf7CKgOKzcDQJ9/luI=;
        b=k1m17xlTOhme5LjnFHKgn+i6FDJf1/xcwuohDL5UtMkB761MepQ/yAEfb8Vu2qwdt4
         QqpKlms3H9ASE6pAkgt/UR6ZOvmQ9g2Gf/KQV8SXwCLfUEgt6Xs+vswmLnsjankLpP1I
         2qnFNwZIk0NxQXqUfKcOlwpcLOXJLXED0Oi2Q6cpGOSJpb3ouXuEg53gy21L982u3kzm
         IRqumO28nEn9zaXXFeyCJC1U4u27cPK1XXdU8Hx0+r4u+oWxICi2xB8Kpks+Z/R5NdHN
         aMUtLxynywtPa5fMF0SB7rDrKzvc3WE+/KG1KKxNnYwAcB4VVuY4jYA8/Jv2gPMoodIA
         hAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkNfwa52J7sMrLHZ8QvF0WkiVrf7CKgOKzcDQJ9/luI=;
        b=YC+ndQldXS3bzMiwOFDMaR1+nuCmUYaq7xDOBZ09PO0BH3fk0+UT4UAinekQUzv6Jj
         vpoo5R+U945lLxKJ+6kPnXSmpQM0gViPSSWybrIbU6gADjBT4CvMQ3h1/MMMV/J5bHmb
         XVHbdCsf0CjpcGjAwlkNtDR8KfBf08KIHV27I7fdt1zXUltDfJrzst6OP8GInmRQzO7U
         KsyWC0nwtKElQNoY9jXDWHEDCC3dY30MT4UvT0Rr5v83OBTeUPxB2Cfr9e4sqf2bHRNB
         dK/Hgk86bQ8cUiVSkzccK7sQE4FSJD0b90XtJAmZkOzcDBtP489WJLQFR37yiA4/jREn
         I1zg==
X-Gm-Message-State: ACrzQf3tEoTxE7WEk7eq13DK1BTg2NhXOUakUoQbr77MFjKSTZJjAdRS
        mKqV/k21T0z5zvwiht0RjpRwhQ==
X-Google-Smtp-Source: AMsMyM4a6Z/RTEnbk7OiUCFaWLzKQzrmrN4JMt/asnxx6nbq0RCO/svzV1FCFxRUYVbmbDgniR502g==
X-Received: by 2002:a05:6a00:430c:b0:562:6897:7668 with SMTP id cb12-20020a056a00430c00b0056268977668mr14652393pfb.23.1665323321833;
        Sun, 09 Oct 2022 06:48:41 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i72-20020a639d4b000000b0044ed37dbca8sm4601703pgd.2.2022.10.09.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 06:48:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai1@huaweicloud.com>, fengwei.yin@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com
Cc:     yi.zhang@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221009101038.1692875-1-yukuai1@huaweicloud.com>
References: <20221009101038.1692875-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-wbt: fix that 'rwb->wc' is always set to 1 in wbt_init()
Message-Id: <166532332067.4035.10826406194481023090.b4-ty@kernel.dk>
Date:   Sun, 09 Oct 2022 07:48:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 9 Oct 2022 18:10:38 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 8c5035dfbb94 ("blk-wbt: call rq_qos_add() after wb_normal is
> initialized") moves wbt_set_write_cache() before rq_qos_add(), which
> is wrong because wbt_rq_qos() is still NULL.
> 
> Fix the problem by removing wbt_set_write_cache() and setting 'rwb->wc'
> directly. Noted that this patch also remove the redundant setting of
> 'rab->wc'.
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: fix that 'rwb->wc' is always set to 1 in wbt_init()
      commit: 285febabac4a16655372d23ff43e89ff6f216691

Best regards,
-- 
Jens Axboe


