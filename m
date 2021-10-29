Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087FAC433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 12:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF8761167
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 12:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhJ2M40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 08:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhJ2M4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 08:56:25 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D51C061570
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 05:53:57 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i12so4318129ila.12
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=LUYF+vFrMrvXEYexLl3qxY2ER/gYtePdoU9fEtmoAVw=;
        b=CVQFg0LJl9KFh+D3bOEMs0y5jpTdyDAnDYUN22GdKR28hhfGHMA8puyLuEdfJq6YiS
         /aZUHBCEUdGJRQ7p9+XFiS9aktBmxvfY//EJH+QMO1uHtzPVvGHinpNzJBkCiy4yf7Hw
         MHE3dz3gQNuMMUQBeKviLRNur3gHv/GGZKE5w/fODm0tdoYNZJ9H0Q3A2InbXh4umv4h
         IHKAaNAvKiBWXC8ByR7a8x6epU8ItR0h/wdKPCGpBmq1iEU/1hQ7vp7iFDVqelmXBc6Z
         9u+ix7ew5qCmAEiGugK1zoCPRnnmwkqWR4B0q2gpvCvZS8qjSBl0iDzyfKiSUJWktP82
         Dv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=LUYF+vFrMrvXEYexLl3qxY2ER/gYtePdoU9fEtmoAVw=;
        b=DLxy4QQ5g7krr2xkJlus+CNsf5D2eL637YMH/J6OEhGlemc+YOgfvpWSOqiUJ70xl1
         DM4OrmTHdVGAbShZ5FOR5hnGaKYoMfdH2d4cAeFSaeH1zL3XPMUoo02FYDb125/l/kMS
         wqGjKQZNqgsLvLW2ivUyOhAlL7YYhzC+cuswYpjc2quSV3T0RIRZrXSpwTeT+PeGBojh
         kznqm2128J16yMmb+uo0OnO8Rrhbdvvn32oH/BWRypSjVP9N1BetQ/7gqMXJzOW6MGMP
         OThsWQX5+zmM4cvAmQDtTksJeBmeV4UqXZ+Jeu+6yKgLgpYsJU6OmAPuf6wY0JxTR9GG
         MxwQ==
X-Gm-Message-State: AOAM532HMxEz8E6qPetl1TFHv4S1wevzjO4hMShZk9CCjirvQpyI6PiU
        9pDBHPx0E1JaMbYRxrIpCH02gQ==
X-Google-Smtp-Source: ABdhPJxwbEx/pAaUpOhk0Bn8Bb8J9haQWvVzgEc4yW3Iruzb/TqFVP64Y5fGvbiIaW+WJANjOiLgvQ==
X-Received: by 2002:a05:6e02:1543:: with SMTP id j3mr7490944ilu.151.1635512036584;
        Fri, 29 Oct 2021 05:53:56 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g11sm3419433ioo.3.2021.10.29.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:53:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org
In-Reply-To: <1635496823-33515-1-git-send-email-john.garry@huawei.com>
References: <1635496823-33515-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq-debugfs: Show active requests per queue for shared tags
Message-Id: <163551203480.85142.14090478685501297058.b4-ty@kernel.dk>
Date:   Fri, 29 Oct 2021 06:53:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 29 Oct 2021 16:40:23 +0800, John Garry wrote:
> Currently we show the hctx.active value for the per-hctx "active" file.
> 
> However this is not maintained for shared tags, and we instead keep a
> record of the number active requests per request queue - see commit
> f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for
> when using shared sbitmap).
> 
> [...]

Applied, thanks!

[1/1] blk-mq-debugfs: Show active requests per queue for shared tags
      commit: 9b84c629c90374498ab5825dede74a06ea1c775b

Best regards,
-- 
Jens Axboe


