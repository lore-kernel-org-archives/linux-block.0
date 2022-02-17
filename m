Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE7C433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 02:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiBQCsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:48:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiBQCsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 21:48:32 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2546F1FFF65
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:48:19 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y11so788370pfi.11
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=GyP8fkvYZ+iKZjQ0Xv0VozXuxBZdUAH14cR8iEy61TQ=;
        b=C2AZgKZnUbnuppY2d2Z8RZKJ9xEfXrBAXmMnwNfnX1Tp/wTnpBWSpavsg74KJgpyMU
         JUGqxBdBH5qZGujSZvUXXYgODtrGueByto7mQg2asnFoS0zLPNaokzZajZfQq7ay1Gf7
         07jV7OMjCpnNacCZTMpqZRUf1UWa3vb0mY+Nk3gFCEFLo+JO/i74MQImch6yux8E8Cef
         i6/x2pzWmY4C49ULGCH5kiuv0CZBNopQ0FX1pea5lFTi6Q/bTC1ONKqRlVlPjGh6OOG6
         zLhM95NPSGOeJipQRXjybnc6oIrsskVYojMjAz8AiyubPzULwqQOOKAne1va5duXUI1C
         7svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=GyP8fkvYZ+iKZjQ0Xv0VozXuxBZdUAH14cR8iEy61TQ=;
        b=2Ir4c968koPjFUEe/3FvtGiWawJ1DKcN02tzTebnAxIsxsABd4k3i8UEIgZExmBXXV
         k7mbAQLr3AbkwcWpzu0CnziDE4VSNVb/x22SeXjfED+TDNSN6JeO1NuuAC2NsXPenSjf
         jYOrXjxPWjt9It+SAr9H3H1ezTavY6cI2iMpuopbxCgau00H1FVjBI7RGe95XUlC6NDj
         et85t6/8tlKiY3ILloymdx3OKL3UiMmg84c74igQLDjZtsNt7tVhQL/XCkqOFntWOZ3I
         L5MwpHQUMyY5NZHuTgLSw7r1gBhl4ZvLGepPtaO9YXbVW+nrazLCB1MUs+crpJJtxZWP
         AA6w==
X-Gm-Message-State: AOAM532TDGitB1nwxYwUbsyDGPHCUU8c8yFEM+s6KdMzQEXqTAUthhs8
        YzPSusKEXKJB8maPaXaxfW8TiI5BkAte3w==
X-Google-Smtp-Source: ABdhPJyepnKKYsa9HYtmM8aTLyFXuhMuuXoW4LVxkZQ4AO7YXhcBPdhNwUCwuyAZEyBQJgLpTFoD2g==
X-Received: by 2002:a62:8787:0:b0:4e1:b69:5ea7 with SMTP id i129-20020a628787000000b004e10b695ea7mr826287pfe.31.1645066098491;
        Wed, 16 Feb 2022 18:48:18 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 84sm15672421pfx.181.2022.02.16.18.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:48:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220125091938.1799001-1-zhangwensheng5@huawei.com>
References: <20220125091938.1799001-1-zhangwensheng5@huawei.com>
Subject: Re: [PATCH -next] block: update io_ticks when io hang
Message-Id: <164506609748.50355.11490091116960287078.b4-ty@kernel.dk>
Date:   Wed, 16 Feb 2022 19:48:17 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 25 Jan 2022 17:19:38 +0800, Zhang Wensheng wrote:
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
      commit: 62847731488f59971413484005a7fb2772cb9249

Best regards,
-- 
Jens Axboe


