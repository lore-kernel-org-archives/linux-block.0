Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FEBC433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 13:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiBVOAC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiBVOAB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 09:00:01 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3AC1275F3
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 05:59:36 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 195so17088815pgc.6
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=C1W4kV36E/88MQ0EgD4ReD32RmYbAbilQEMq9CuhY1c=;
        b=GAr1v3gitOFpOK94KhGgG0iriGATs5o0l/cpvr99uSwtKjmP8LD3IyRhRJUyh89zsa
         OFRq86cVgW2fBdCfDAvqvSoTZOLwtm2tgFfDxZ2rCUL0J8AieTaLUlr2B8GiDOrnlCAF
         DRmY8oiIU4cMLpVeW+arMTXFklUp1QVeYLefRhm7cX0t61L66YcuBR1M4mcO2EMDNSeE
         FcrMYJkmR/qTQTn/l63QrKuitFxDy3jKRDuLcQBlF1khAml8v6YYXTKJsCFHEhtkSP7v
         z0RnhrcV6Uy3AmUEtwj6jKTBoWl26tjeWM5exrxsF0GvoP87beDE9+yMVrfo2muLWoSH
         OVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=C1W4kV36E/88MQ0EgD4ReD32RmYbAbilQEMq9CuhY1c=;
        b=Yhivyh/YpnZWFpiEnqsiv7hLXQBKVDIZZCqy7drI0RS7kyd49f1mVZ1uyDCiKgYXM3
         uf4MiSKOQIT7h93TMYmpHZowPGEKWcVj6fVnUyCAe8hkEgzojj9YSTwSl70d2tFdBuTh
         Hn0ALKP45fYCWXWJVVoi5abcwQh8RQFmRljAGgeF+1DzW2/EGfpv7q3+HpkGX/ntwPvb
         UZZngQOv3lrw7mBZqWP51PWW2NDzjAMxT1kT1fOf56AcidvQ5bFH4x9xU6XulvXg150m
         4ELI08xwzMgd5A0+rIXEfx5sc4Xm7yK3MAQh6k5cekDucbWjKIGSuY1YWvHt5PbIu2Jx
         u3JQ==
X-Gm-Message-State: AOAM532z+yywYas+Xbc+ErcrwjY7okHv1kEstd/XEfVCm3HuzHl5fB1J
        yQ5jMTOyWHKtuujPvqLHxfJxt2Rs8wSbNw==
X-Google-Smtp-Source: ABdhPJzDRyJ/ki1TBz8O7jl8bNr+phcLYza9jywAF1RQVWiTjbI7ZTyTt3RunHBudGSIVMZTqGzQQA==
X-Received: by 2002:a05:6a00:1943:b0:4cb:79c9:fa48 with SMTP id s3-20020a056a00194300b004cb79c9fa48mr24948520pfk.47.1645538376196;
        Tue, 22 Feb 2022 05:59:36 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p9sm17624580pfo.97.2022.02.22.05.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:59:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220217064247.4041435-1-zhangwensheng5@huawei.com>
References: <20220217064247.4041435-1-zhangwensheng5@huawei.com>
Subject: Re: [PATCH -next v2] block: update io_ticks when io hang
Message-Id: <164553837519.20990.470624285897960760.b4-ty@kernel.dk>
Date:   Tue, 22 Feb 2022 06:59:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 17 Feb 2022 14:42:47 +0800, Zhang Wensheng wrote:
> When the inflight IOs are slow and no new IOs are issued, we expect
> iostat could manifest the IO hang problem. However after
> commit 5b18b5a73760 ("block: delete part_round_stats and switch to less
> precise counting"), io_tick and time_in_queue will not be updated until
> the end of IO, and the avgqu-sz and %util columns of iostat will be zero.
> 
> Because it has using stat.nsecs accumulation to express time_in_queue
> which is not suitable to change, and may %util will express the status
> better when io hang occur. To fix io_ticks, we use update_io_ticks and
> inflight to update io_ticks when diskstats_show and part_stat_show
> been called.
> 
> [...]

Applied, thanks!

[1/1] block: update io_ticks when io hang
      commit: 86d7331299fda7634b11c1b7c911432679d525a5

Best regards,
-- 
Jens Axboe


