Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEE4C433F5
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 23:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiEQXqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 19:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiEQXq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 19:46:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631250033
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 16:46:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v10so590990pgl.11
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n3+m8jgAxm8fBSHnfbMor5+nGrWjypP0ZwFQmtehfDg=;
        b=4oMIEylzMml6BGLoG1rJ1062XsJCmkJZ8XecIRfg3ZioG2yhKA6cMHzTDmeS0OorLe
         7AGYQWX02wuBFgMw3AKHxCgewXcG8hKHrTzyupfPTOL7qJ4KZhQpKq8Zce2Z1NZk2GpF
         6GpoDsbMab4fCKEczVGXtZ0Nw/gagNYBtKu87aVaMWq6ZUsuGsfflZMXjrlSatBcI5xc
         Xw7aeh60TPlhEaqQVrCzZIq7q01GK7FLBYeVPdhBZL19NXkZtYOSl2f1Sz+G/p+rKLMQ
         VYBcTnCBosLQIlpP7W/Gx4UgSyzfdy8+1Q6GujemvIhUvRZ/Um0bNw/s29qIAgyVxMXn
         At1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n3+m8jgAxm8fBSHnfbMor5+nGrWjypP0ZwFQmtehfDg=;
        b=oHLeLof2uSWrL/ek39KvKvfA1wnbPiQEHIPKMC+a6+xq/319ILJzLGQW8mTdx8Gf5t
         eyGbdjEx+FTYJntNXyI7yv+/Eu4ZhQPTToj94qVrl3M6PsrJZGrlRx48VH0TzKJc7ujb
         zhyFJxljcaCsd//832nyppAAZszOX9Tw3pHC6OG63fHIO2H6DU8jvHEMhEP1pkETo82N
         TfKRn3UhMTfDCmBRwUm4YFDzgztCvU4k/efiDtvmrd1WIP8jPCjRTQA87fcNN+fSv+r4
         zFOGWhstOpiRzlGkYPCnKR/1T1+ctd+LVVUM9+Ioan6f3oEd/x4yIRvkxX/+74wjIMrQ
         0vjg==
X-Gm-Message-State: AOAM533HxvF4s2bEchlBxVRP+t9/L/4ILIKiWgYqxaF0i+irg3Q8QHZ9
        P13daBlWFR8OkW+DSEEGTr4UMg==
X-Google-Smtp-Source: ABdhPJwRSfTP/51TNq3pmC+bcl+cMJtM9+P9JUVJGIF4JXuynMuAXSbTCfrhzLkcERY28nIM2iBZRQ==
X-Received: by 2002:a05:6a00:174f:b0:4fd:aed5:b5e4 with SMTP id j15-20020a056a00174f00b004fdaed5b5e4mr25013495pfc.39.1652831187193;
        Tue, 17 May 2022 16:46:27 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:500::e2ec])
        by smtp.gmail.com with ESMTPSA id jh4-20020a170903328400b0015e8d4eb1fasm181863plb.68.2022.05.17.16.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 16:46:26 -0700 (PDT)
Date:   Tue, 17 May 2022 16:46:24 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     osandov@fb.com, yi.zhang@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Documentation: Fix typo nvme-trtype ->
 nvme_trtype
Message-ID: <YoQz0J67qSUPKVyq@relinquished.localdomain>
References: <20220511030059.205953-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511030059.205953-1-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 11, 2022 at 11:00:59AM +0800, Xiao Yang wrote:
> Fixes: 3be78490def5 ("Documentation: add document for nvme-rdma nvmeof-mp srp tests")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  Documentation/running-tests.md | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied.
