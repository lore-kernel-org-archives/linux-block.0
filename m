Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A796C7618A
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 01:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCOBVN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 21:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCOBVM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 21:21:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D91BAC5
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 18:21:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y11so18485119plg.1
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 18:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678843271;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLQ/MfP3y+JzW2NmaawnyG4peAeIRysnlcJZmbtMZNw=;
        b=C65dUtffvyWvu2ZHu7Jg/kEAoVFzLIV+RcUkuWgVhQ5kpOssqxkKUVJ8tDTlsw3zbb
         vB13KdE0Cab9UhqsakhuU0hxjkcdh8pMHIq+4asGS+s6jnhFu4hfTZy13RTEL3XE3nKn
         q8jqcIqrQKlsLLrRRh+TaqrftICiXBbLLtJ1dmkCLAPXJ2C5IwDIr/0vgiMu7mwF07gg
         rAg0nOWWwuHxKh2jw8mFACCaq+x8vCYGQSYAIeIEFpPBzw72BwT0jTZiElVqLcgUODSi
         PLQboxs8puf3RJaAhSvMwHM8yFrlMu1ogoP/Z7Ayykr/NILEI3BkiWkQFuhN5Xd2/J26
         K5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678843271;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLQ/MfP3y+JzW2NmaawnyG4peAeIRysnlcJZmbtMZNw=;
        b=aHK55IU/iHyGhMSzuxfR9dbY0SFCnAMhTncDaNZyy64WM/8dXaBuCghJ8oelvu+SQl
         +wmWGD67f3LXJAUALQ7k2PN+vdXAH8m/UXuQ/3rPOfDIdWmZfcFySIR3UvSt10ytDZQe
         yq1D8JpoYUq8amFMy7L+mX6Tt6Cthc2YZrzmHoWiCBm/ucy9DMcBqvZns5eP9S3i5RVU
         a9obvKP7vdN4qEx/WTJoUFTbwVC1gOWsp4ppd/C+iSE+QzjePiyb9g9Ab5vexuompV/p
         QSIJUZXY69ViP0IUgjY69fs/EVhd2mBIaaufejxEFX6ycd3nrz/SE1fYItwIjjeQunZL
         yd8w==
X-Gm-Message-State: AO0yUKXNdJHWuaQMoPxnBkqmS8eQHsNPnKQWN7MJaADjKuft63kIYvmO
        L7tp+Tv+Q+4MLYwVthkNd8T/vQ==
X-Google-Smtp-Source: AK7set/IdCa2bZc8aar2uHv6UojXauEhvJdw0vczzBVwIkkxYbpHkIDuznmRdPVp8g6pPu0AjQJijA==
X-Received: by 2002:a05:6a20:1606:b0:d5:58df:fb94 with SMTP id l6-20020a056a20160600b000d558dffb94mr5504511pzj.2.1678843270943;
        Tue, 14 Mar 2023 18:21:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l17-20020a62be11000000b0062549352d1esm2199000pff.162.2023.03.14.18.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 18:21:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Chris Leech <cleech@redhat.com>,
        Marco Patalano <mpatalan@redhat.com>
In-Reply-To: <20230310010913.1014789-1-ming.lei@redhat.com>
References: <20230310010913.1014789-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: fix "bad unlock balance detected" on q->srcu
 in __blk_mq_run_dispatch_ops
Message-Id: <167884326982.17000.9039472462680431727.b4-ty@kernel.dk>
Date:   Tue, 14 Mar 2023 19:21:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 10 Mar 2023 09:09:13 +0800, Ming Lei wrote:
> The 'q' parameter of the macro __blk_mq_run_dispatch_ops may not be one
> local variable, such as, it is rq->q, then request queue pointed by
> this variable could be changed to another queue in case of
> BLK_MQ_F_TAG_QUEUE_SHARED after 'dispatch_ops' returns, then
> 'bad unlock balance' is triggered.
> 
> Fixes the issue by adding one local variable for doing srcu lock/unlock.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix "bad unlock balance detected" on q->srcu in __blk_mq_run_dispatch_ops
      commit: 00e885efcfbb8712d3e1bfc1ae30639c15ca1d3b

Best regards,
-- 
Jens Axboe



