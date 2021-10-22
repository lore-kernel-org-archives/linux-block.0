Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ADBC433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C70F6115B
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 15:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhJVPSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhJVPSo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 11:18:44 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3EDC061764
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 08:16:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so4780557ote.6
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ANjxMyzEaBerOwzLK0Q3RxHvXsNIIMRJZ4VhyjUE2w8=;
        b=Um61NSl9XZjxdivHLbY9cyH91To30EM1MV27+M0ag4zCerhQSBBvzx1BRSBoHD6Vu7
         NJy+RmfZJ7bdbaMjkyaUbT2mKri6WdrUNzA/5s1Ab25uWmeNmfEqRa6CoZMRzcv4pAnW
         GqG4yWcCLcl+b1P6/mXuBprj0JiQzSfEfm7op605Qg+C4BnrvkZthiuK4P+Hh6YBev+i
         S+LHJUy3hnl+GrLAfnleLK8RjDegxB6WzfRslI1sEu4869lFJcADzxfcTFz23+dxroRV
         OaX1gIYVqHHhZ1Vvejvi5Wkow+QtUwGJ16Cg6KHA2PwABXN5QvlxxcWk2uN7/lAtlV4y
         r3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ANjxMyzEaBerOwzLK0Q3RxHvXsNIIMRJZ4VhyjUE2w8=;
        b=U1Pcxhh/A9XIhiYSkRzXcnOUyyIWWy6BhhmH7WQaU6SIdQbf56kOfNOWCU1U9bLi4p
         zUueX2BB264La8Tl6jURzIjOlGfzdlBj4B/fjen12Ixj6ESN+lHcNU10X8KkUbOihx80
         z570Y8O1YH242vvdSUiT7YPmU5fj33+W28fa/Pqy8lS5rxu2IsOlLj5ZTKKux3tqJksg
         MMEeioSncd/kDk1FzF83kN21+1x0WDkIJqx76W9cbFUb7+OdA85B/M5UHoL1rF29myNW
         xUi7Z6kpUMpHSYOW9+kW5shhMoeibUfd3gXnemqrkB/QLVmAgZ4B0F6hDRGOjseadTJ4
         uA/Q==
X-Gm-Message-State: AOAM533mcHdbZ/f3qQZZlIrawMP2ySnloJd4hqW4mNZSve8NkSOW9oOo
        oFiYiiNyeF2DVe5mBolptq3iSA==
X-Google-Smtp-Source: ABdhPJxVF1FPp4NIY23klw94VQMWmGA8+pwcyTnKttWZaIi0nOTHXtGUy6TNbgHv3LBU/WCQXWfbyQ==
X-Received: by 2002:a9d:7644:: with SMTP id o4mr397173otl.270.1634915786523;
        Fri, 22 Oct 2021 08:16:26 -0700 (PDT)
Received: from [127.0.1.1] (rrcs-24-173-18-66.sw.biz.rr.com. [24.173.18.66])
        by smtp.gmail.com with ESMTPSA id y5sm1733409otg.52.2021.10.22.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:16:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     ming.lei@redhat.com, anders.roxell@linaro.org,
        naresh.kamboju@linaro.org, linux-block@vger.kernel.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org
In-Reply-To: <1634890340-15432-1-git-send-email-john.garry@huawei.com>
References: <1634890340-15432-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq-sched: Don't reference queue tagset in blk_mq_sched_tags_teardown()
Message-Id: <163491578487.92334.5273496329606212281.b4-ty@kernel.dk>
Date:   Fri, 22 Oct 2021 09:16:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 22 Oct 2021 16:12:20 +0800, John Garry wrote:
> We should not reference the queue tagset in blk_mq_sched_tags_teardown()
> (see function comment) for the blk-mq flags, so use the passed flags
> instead.
> 
> This solves a use-after-free, similarly fixed earlier (and since broken
> again) in commit f0c1c4d2864e ("blk-mq: fix use-after-free in
> blk_mq_exit_sched").
> 
> [...]

Applied, thanks!

[1/1] blk-mq-sched: Don't reference queue tagset in blk_mq_sched_tags_teardown()
      commit: 8bdf7b3fe1f48a2c1c212d4685903bba01409c0e

Best regards,
-- 
Jens Axboe


