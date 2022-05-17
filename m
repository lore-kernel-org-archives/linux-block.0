Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1024C433EF
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 04:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiEQELs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 00:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiEQELq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 00:11:46 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708F3FBCA
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 21:11:44 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2fee9fe48c2so52954347b3.3
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 21:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NO/qVr25gl9DWObhrjxNHN1PGGWIrTbPudg44b/JLeI=;
        b=6KEbpLl+WAWuaT8l95JqbSOJgxSfJpLNEobjxxcKridU4U1e87XUTvnUWU6odxyltG
         sXCcYvAJY+6YB1DpztmiFEnawZUnjEhrpZdrVqDMMN1cGgA1leE+uGdC2eL9FIQFSPdB
         xEO8+E2C/VI8ufjhzynb2Z+cjaYGHRHv3EiZaE0UgmgXsHBuI952bSfrr9GwiudXZovw
         CVqHc0o16YBvjIQ9aiw2/bi+cIfUuynJXbTcERUtjLZy+1Zd8Een7qt0NcebDbVycA6i
         4xth0GFVrEk/CoU07cQjxYG1M9u2NZERL1P5PXhcCQ6ywkbKUWXRQHnHLustaralGwoS
         2tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NO/qVr25gl9DWObhrjxNHN1PGGWIrTbPudg44b/JLeI=;
        b=DI+AkyfHUEPBrl3sQNJQiJtzlzP5y1LkrdOgFvWJPiFcPdHoS/sUFlBHxfJZ1l2Czf
         CY8/izFKMKts17R6TptXfghom3T9roulOgsKWfWueYDbRrVzcb29gRCVlI8V/kAofD44
         pTbImbj1mcmPZg/vqLR08YyUO/qKIM1IKu5w6V96jvo57oJb0Ozl4+dW8jKgAkQSPRGI
         PetZCYHfgTmxM09L02KGJOACYVrvN3nyEuFsms1GVgS4Q69as3mfEN6c1k/XRCIvDrOL
         DYplwkA/H2oE9uwYhEvQvGofhpmrQm8ZScoQfYSv7EH4GUxKOWEjeRn66aKIr47mNJhc
         wqdg==
X-Gm-Message-State: AOAM530TZeC4xA09THUGAuh5AmwaFeWh6NUa5DUf3lf/puMt9Qc0bdw3
        equ1cG2PXJQ5vL0wy11RSAQNeU379sPddVegkorGQQ==
X-Google-Smtp-Source: ABdhPJw94mquCu2tzO4e+v+R3EKZQm+TzZ6hT1GPqsmlWqCmuAgQDMm/rqRAJ7UuVR8eO1d1Omo9W844ZRuDq2Cs1+Q=
X-Received: by 2002:a81:7b05:0:b0:2f4:e45a:b06e with SMTP id
 w5-20020a817b05000000b002f4e45ab06emr23607287ywc.458.1652760704159; Mon, 16
 May 2022 21:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220516173930.159535-1-bh1scw@gmail.com>
In-Reply-To: <20220516173930.159535-1-bh1scw@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 17 May 2022 12:11:08 +0800
Message-ID: <CAMZfGtU8GYN6aLepHr3z=AvJ4XivmWpPdnvUBgaJUnmf37-28Q@mail.gmail.com>
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
To:     bh1scw@gmail.com
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 17, 2022 at 1:39 AM <bh1scw@gmail.com> wrote:
>
> From: Fanjun Kong <bh1scw@gmail.com>
>
> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
> Which can serve as RCU read-side critical region, so remove
> rcu_read_lock/unlock().
>
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
