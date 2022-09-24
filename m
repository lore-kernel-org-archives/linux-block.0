Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45055C32771
	for <linux-block@archiver.kernel.org>; Sat, 24 Sep 2022 15:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiIXPAP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Sep 2022 11:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIXPAO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Sep 2022 11:00:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B922BC9
        for <linux-block@vger.kernel.org>; Sat, 24 Sep 2022 08:00:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c198so2691099pfc.13
        for <linux-block@vger.kernel.org>; Sat, 24 Sep 2022 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=/ZxmoZGavmWNlrZnawkbXveh01Wn367vmE/VNkXmIdw=;
        b=s25ZCs1tSDwZADqqqf1Vm4xt2zv7eMrlkQYv4xQaqPF3mPJzzvhB2mzxAqxPkb32pK
         NHAqqy/qx4pNcfeO5zqFmmWF2ufBVP1cOVbbxVTdLQvPTSHxLDM+xweoWGa34eoy6rDG
         dyyruF1ntIIDA6CvCIvQDTZADmji0DJAHX5s0Vhfrhdfq4gt11Qo5ttrdt7FnYlOgmiM
         g8G3lY1JxPY4sBzH8MwvY9x6UDIuc8ekZ8AqGfJh5wk+r/EmtPVkEnjYkiP/kHjK9ETv
         OYDkJBXcuZFyiUKv4Aw+s8K/uMug7rbzVAcHajZOqT5eH86LKpfotHSrJsWWt7a+AOji
         zcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/ZxmoZGavmWNlrZnawkbXveh01Wn367vmE/VNkXmIdw=;
        b=TLySxMp2TqCrUTiKivYLYUxWxVOKiVy11wAdAlEYTN+FS2LE+lX7sInLYiNvBoX9dF
         td16O5TQTRhXwKaZnhFU+pJCLJPhjgSkt0UEygBJAFIWGVhW7zQVbABVjOqlqkh68VtW
         72900mgwPenAsr7jACEFzeWPHDWf0LQQzg5WjkIPOy6Q398iJS8rPToFsIp4/UQRoXb2
         AjQ03W9Y0+4sI1ZcFt39KUz2TP/NWMN918j5afXhKHRSWjSgnZpTwBoSSicdEiHiGfI1
         fNh5uCVsw6XZR7oTMPdOk+w3aRxqQ+nQ5mTRy8O0izQ4etMOakoBPYFLSrl0RHfWAiTy
         xeJA==
X-Gm-Message-State: ACrzQf1aQJec7ppURqC4qRXVfbtTXhESUwDO1SnAjz6ehxlxruRN1mTI
        mtoeb5b4j9j+HULo7mb9KnRNY5uXRKnWDA==
X-Google-Smtp-Source: AMsMyM5+ef+aw0XcysL1aexhvPjDjgsey9VsVY7POoHb/1mlXyhvyLCmIyCeSI3bLtHy1j0OgNAhEA==
X-Received: by 2002:a63:5d48:0:b0:43a:390b:2183 with SMTP id o8-20020a635d48000000b0043a390b2183mr12204841pgm.29.1664031611841;
        Sat, 24 Sep 2022 08:00:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902760100b0017870f471f6sm7848200pll.226.2022.09.24.08.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:00:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
In-Reply-To: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
References: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH 0/2] blk-throttle: improve bypassing bios checkings
Message-Id: <166403161084.5171.274436515046613194.b4-ty@kernel.dk>
Date:   Sat, 24 Sep 2022 09:00:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 21 Sep 2022 17:53:07 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, "tg->has_rules" and "tg->flags & THROTL_TG_HAS_IOPS_LIMIT"
> both try to bypass bios that don't need to be throttled, however, they are
> a little redundant and both not perfect:
> 
> 1) "tg->has_rules" only distinguish read and write, but not iops and bps
>    limit.
> 2) "tg->flags & THROTL_TG_HAS_IOPS_LIMIT" only check if iops limit
>    exist, read and write is not distinguished, and bps limit is not
>    checked.
> 
> [...]

Applied, thanks!

[1/2] blk-throttle: remove THROTL_TG_HAS_IOPS_LIMIT
      commit: 85496749904016f36b69332f73a1cf3ecfee828f
[2/2] blk-throttle: improve bypassing bios checkings
      commit: 81c7a63abc7c0be572b4f853e913ce93a34f6e1b

Best regards,
-- 
Jens Axboe


