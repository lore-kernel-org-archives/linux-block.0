Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105A7C433FE
	for <linux-block@archiver.kernel.org>; Sun, 22 May 2022 21:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbiEVVkH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 May 2022 17:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiEVVkG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 May 2022 17:40:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4B37ABA
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 14:40:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so15878005pjb.0
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 14:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Sss4ag6ijiWC1dG2xyqQ3U2glNFWSHe5McaF2iNbp64=;
        b=VzCYJQWwp3TQC2wNYoXJirJazZP9Kpr21N2VFFq9x3l3VfeKVG+7QxCdFMg6jeTniv
         N4xVRahB3PiLi59Feonk9xBJhbkkUtjIvfwmfu32dAx++xMnM548KrfS5toJO6r3UMjS
         3+h/lpM3X9cRIl6DS9WWBIJ1qVHy76xpr3pD65aoqhzIABeq47Q6EGgFRpJ3/pWqcvNB
         BV7Wl+zDwret77Px8GYqFpKkg1F/FUIb4f1CkWPHizpa3xviyhoPzrdZY0kk08UIS+lX
         +rXU1eb2WaqRUDck9AoD3WGAk+HcL+N1Sc0hZG/YbbxVPkZRMKyK0Twcvabkq1BhWpWe
         X75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Sss4ag6ijiWC1dG2xyqQ3U2glNFWSHe5McaF2iNbp64=;
        b=PjOxfUbbjRKIEhO6OZSoX3S4G3h7iL62U28Jxbkt7X51f8J6nWz4LgJMcvl9JDIRlu
         emnB0tVIhtwA0zeWiVtcpUKExdrTK1dVfGizhuWtjg0oybQcRyqawZIJnDHPgh2Ii41R
         i1AA5Mdkzk1qUcTP462kWewad0JQR1824ECknDqyA6m8scvSHBsWTz26O97kjsu4azOx
         jQ1jAGXRNl+l1WYLDOoNyiLCR46ztCb5bhrMmypw6R2zHgGIuGyy6nd/SGu7oo08uo7O
         FnedN0Rr9gzUehJnHH3z5J5F6GOrRL7dOADtcAruxiA5/+uqAqH1zXvw5+YnKVI8vx7I
         690g==
X-Gm-Message-State: AOAM531kfcLbE8aJD01MwtMm4hgG+4F1blf2xV41yDPriM9cfLHC4e1a
        V+pGC0xRC9Nphzx/droAezmsLEWJi0/H8g==
X-Google-Smtp-Source: ABdhPJyyuprh5NFfwtlTgLBSI61aqpWxdixghGqrW83v0Wls+a0pNqo3Elr4m20BcXsY65r6UvjVgw==
X-Received: by 2002:a17:902:f08d:b0:161:d786:8694 with SMTP id p13-20020a170902f08d00b00161d7868694mr19441546pla.77.1653255603913;
        Sun, 22 May 2022 14:40:03 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a1b0600b001df7612950dsm5730716pjq.7.2022.05.22.14.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 14:40:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     colyli@suse.de
Cc:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org
In-Reply-To: <20220522170736.6582-1-colyli@suse.de>
References: <20220522170736.6582-1-colyli@suse.de>
Subject: Re: [PATCH 0/4] bcache patches for Linux v5.19 (1st wave)
Message-Id: <165325560324.1881851.11432655454328594082.b4-ty@kernel.dk>
Date:   Sun, 22 May 2022 15:40:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 23 May 2022 01:07:32 +0800, Coly Li wrote:
> The bcache has 4 patches for Linux v5.19 merge window, all from me.
> - The first 2 patches are code clean up and potential bug fixes for
> multi- threaded btree nodes check (for cache device) and dirty sectors
> counting (for backing device), although no report from mailing list for
> them, it is good to have the fixes.
> - The 3rd patch removes incremental dirty sectors counting because it
> is conflicted with multithreaded dirty sectors counting and the latter
> one is 10x times faster.
> - The last patch fixes a journal no-space deadlock during cache device
> registration, it always reserves one journal bucket and only uses it
> in registration time, so the no-spance condition won't happen anymore.
> 
> [...]

Applied, thanks!

[1/4] bcache: improve multithreaded bch_btree_check()
      commit: c766acd3d78e30c7d24faca05333c2526aeffd6c
[2/4] bcache: improve multithreaded bch_sectors_dirty_init()
      commit: 0c723008bd6cf999130e338a043f7fa5b603462f
[3/4] bcache: remove incremental dirty sector counting for bch_sectors_dirty_init()
      commit: 4d667b2ce04fcf4a53a248a85a60336870729300
[4/4] bcache: avoid journal no-space deadlock by reserving 1 journal bucket
      commit: 4be2d484e9842b09fd451cfd36e22cb3db3aaf5e

Best regards,
-- 
Jens Axboe


