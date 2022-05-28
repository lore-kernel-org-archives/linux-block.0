Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A88C433F5
	for <linux-block@archiver.kernel.org>; Sat, 28 May 2022 12:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiE1MUx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 May 2022 08:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiE1MUw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 08:20:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8803B1DA60
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:20:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y1so6550028pfr.6
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=xVmGe1pvb1NKRaxS08eK6LDkM0yzbPm06yZ8alaEbGk=;
        b=Ex2RVVuwUDGAbS1eIGz9BZZiDjRCWA6n5ETkHu9T74L+YmnqBwOzmRt0D50GLnOcne
         89Im+fxHAz6j3hRxEvc8R4BVZn4FSXO/VmBuoQawOEDggIitflk67OQOvDVNZ0/CFlxL
         DK8iYRkwrJfQOYB7KE1Q72sHW12gjrecYlfNM4GbZ67ycf0lgrsh1iw5G+T+/XUW1UTH
         98Mx/5kNsKY9Yga4YT0rjk66vV9ftOeY2xm0J/LQIth9jUKj7qNXixfOBK3OEXNoJZtN
         2ylGELGbC9BcWPNGMtvGXG6lyoi17gatTcDV66SCDagwsM3ThUEDzl3qfMJqmoYBb9HI
         LNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=xVmGe1pvb1NKRaxS08eK6LDkM0yzbPm06yZ8alaEbGk=;
        b=LQUyY8xRPYcSmwkxzoKZsY2Mm1+fklImcHCYBHubqFzrOn/6omhzZOowCZDG/mlsex
         gO6fSalyVkGYf2V4vS1ZE1oVjgzTJf1Zl2rz4GhItn6sk6zrwDj+PBc2EtXprS3ufoS7
         70wWClYy1xqonJIljZpHZ9MfGAX6HYF98sFNR/ruwBLLtewa3RWaMEX4peb2oVJhioVM
         fCvZCBkTnxifiYASPC4obIBTsPY1zIl/f2Zdd7epJr6ZD+Z1DovADDpiLv2NXcwYAQxe
         tl9AFT7bUbZu6txSdgF4rmuoXwJbp7pE/a+cduiSyUmDRhN+cl0au/wkSPbpq8G+NFHr
         rNlQ==
X-Gm-Message-State: AOAM532XxuWcQIiJiPXBUcdg+EBNddUvdPSVIce+312ia9XkNOjflDDZ
        9FEbtYrcJtjvWpXnA212MHMlOT8zbuDhyQ==
X-Google-Smtp-Source: ABdhPJw2JoXBOtEAH4o4PFJ8GxYYTMxM+Pl16lVdghppJx0YDlQ4ug4s8djl3xsFNogW6/uma3Fgjg==
X-Received: by 2002:a05:6a00:2386:b0:519:1ff1:d723 with SMTP id f6-20020a056a00238600b005191ff1d723mr11292271pfc.21.1653740450875;
        Sat, 28 May 2022 05:20:50 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id gb8-20020a17090b060800b001df51e34036sm3203230pjb.0.2022.05.28.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 05:20:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yukuai3@huawei.com, ming.lei@redhat.com, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
In-Reply-To: <20220521073749.3146892-1-yukuai3@huawei.com>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
Subject: Re: [PATCH -next v3 0/6] nbd: bugfix and cleanup patches
Message-Id: <165374044976.753929.3131835512531137863.b4-ty@kernel.dk>
Date:   Sat, 28 May 2022 06:20:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 21 May 2022 15:37:43 +0800, Yu Kuai wrote:
> Changes in v3:
>  - rewrap to 80 columns where possible in patch 6
> Changes in v2:
>  - in patch 3, instead of clear and then reset the flag if rq is not
>  completed, test first and clear if rq is going to complete.
> 
> path 1-2 fix races between nbd setup and module removal.
> patch 3 fix io can't be completed in some error path.
> patch 4 fix io hung when disconnecting failed.
> patch 5 fix sysfs warning about duplicate creation.
> patch 6 use pr_err to output error message.
> 
> [...]

Applied, thanks!

[1/6] nbd: call genl_unregister_family() first in nbd_cleanup()
      commit: 06c4da89c24e7023ea448cadf8e9daf06a0aae6e
[2/6] nbd: fix race between nbd_alloc_config() and module removal
      commit: c55b2b983b0fa012942c3eb16384b2b722caa810
[3/6] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
      commit: 2895f1831e911ca87d4efdf43e35eb72a0c7e66e
[4/6] nbd: fix io hung while disconnecting device
      commit: 09dadb5985023e27d4740ebd17e6fea4640110e5
[5/6] nbd: fix possible overflow on 'first_minor' in nbd_dev_add()
      commit: 858f1bf65d3d9c00b5e2d8ca87dc79ed88267c98
[6/6] nbd: use pr_err to output error message
      commit: 1243172d5894e2d8f277ee3c278180792de5c521

Best regards,
-- 
Jens Axboe


