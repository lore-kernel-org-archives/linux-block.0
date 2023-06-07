Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749DAC77B7A
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 13:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbjFGNwj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 09:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbjFGNwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 09:52:37 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0AB1BE2
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 06:52:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f8b0649010so6358231cf.0
        for <linux-block@vger.kernel.org>; Wed, 07 Jun 2023 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686145955; x=1688737955;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pWjfG7YX2PU6lTg87BQzQgK5gQrtCZuLosIt3qtFrw=;
        b=QMGMlVX9pT4+APXXvlD2HGaGEg55QMH0btBqGqRw+dtdVOGo1kh5q+IRJfikBCjoAZ
         vafj+YrmGCGYaOtKcFzs/g7GriOKBIzWtZZeh8BfNxsIDJ7VseMMJPYoiNuQt7caTcMI
         fbzdenPFcryIzgWI+zcXPps0vDUIFsZMliLzzzo2NMTbOU8IV+6GRTdzS4etu2E7bG1G
         zZy5GDzKAFGL863kgCYdqdlrRhzG8ovq7gNP99KiwoUnVzy58N3hDEkaisdrZi9QqDvh
         12nHG5VND02dBavngpMxFq36XYe5fvooIddYSP6a8+XPAVtLp/lIB0YMBjMBb3y/nBpV
         Px9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145955; x=1688737955;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pWjfG7YX2PU6lTg87BQzQgK5gQrtCZuLosIt3qtFrw=;
        b=io7sFEnvmwPBm7rFJpCBQJUSha9wgI/cfldpdtRIQDkKC4HXTQmuyLjj+DxYUbqK5K
         N1ccKNM8VtmoR/+DMC4TY5IZQJJQ9TLrCf9PCEGzgjzRgBh8Y7iXBbT0Vil6xatTo7cB
         ZW1UjwaAH4gP5IMMxe5s5K+5bGN80zpPOTsNOg+Q3qx39UVn9cSypkeduWKRL/w6cPD8
         0mJQpwM5ThSUSbAMbfs1Kjb8MWsYeKWlTOD+7NFqgOPiN/CwO/X6Fb7RV24gR5ByRlek
         pvynTVAxzHQ1rSp8h9XV+CIRc1nwCeG5tISj0rx0bCQgdlVcqf9fRuQW3DEQfUHZb65L
         DK+g==
X-Gm-Message-State: AC+VfDx/03Zut80usmfae57uOdgzxTWw4MuElVaE3QGNzmkIvkzFRgfY
        reP9l48Vzg5yUQ4OH9wUGLeQVg==
X-Google-Smtp-Source: ACHHUZ5DwvtauaBvGPF/zgxanW0qGVda9dWL3S5jI/ddgyNov7yI8rfOmzvLFLxsl0kOx8qDfPrgNA==
X-Received: by 2002:a05:622a:1899:b0:3f9:ab2c:8895 with SMTP id v25-20020a05622a189900b003f9ab2c8895mr2173118qtc.3.1686145955449;
        Wed, 07 Jun 2023 06:52:35 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id s5-20020a05621412c500b0062119a7a7a3sm6141611qvv.4.2023.06.07.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:52:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20230606180724.2455066-1-longman@redhat.com>
References: <20230606180724.2455066-1-longman@redhat.com>
Subject: Re: [PATCH] blk-cgroup: Reinit blkg_iostat_set after clearing in
 blkcg_reset_stats()
Message-Id: <168614595386.134969.17908041000836291196.b4-ty@kernel.dk>
Date:   Wed, 07 Jun 2023 07:52:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 06 Jun 2023 14:07:24 -0400, Waiman Long wrote:
> When blkg_alloc() is called to allocate a blkcg_gq structure
> with the associated blkg_iostat_set's, there are 2 fields within
> blkg_iostat_set that requires proper initialization - blkg & sync.
> The former field was introduced by commit 3b8cc6298724 ("blk-cgroup:
> Optimize blkcg_rstat_flush()") while the later one was introduced by
> commit f73316482977 ("blk-cgroup: reimplement basic IO stats using
> cgroup rstat").
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()
      commit: 3d2af77e31ade05ff7ccc3658c3635ec1bea0979

Best regards,
-- 
Jens Axboe



