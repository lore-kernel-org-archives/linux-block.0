Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7BEC433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 12:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB4760F93
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 12:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhJQMyt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhJQMyq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 08:54:46 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E38C061765
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 05:52:37 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d11so12077285ilc.8
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 05:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kUdj+PubbOccqzjbDpeIXkqI8ezQ9BFkK71JzcdfdY=;
        b=2vW1sd7+d3+Ny2NWPJTZ98WFK1VuyLdGiLMzjVJ5M5rgYSnIgpcepOpZjeRVt+YNFT
         Ue3LHRibFQoJsqnMYqZ88eMfc7FwUoBRce94U80gaVAI0OdC3jLn7SmQ5QEalUM/q68s
         HnGIfuNRtTqvosFmyvwkHjVB8Sf1c9nmrNtbTe/Yw0x/doEAcJM0JwQ0Vi1PSWqj5NHD
         n42/f9zYLaRiQzFqF6ovitGq4hgN5Nverz8SBjlbfIbKGlZb8gkPlApBPahFh3dX27Mf
         GAyOr9fuVvL4hoDQMULDsOXB9d0+zTUez/y8HVe6pO8XjdZ5bpQYIdmqjkMxG65kCblX
         OFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kUdj+PubbOccqzjbDpeIXkqI8ezQ9BFkK71JzcdfdY=;
        b=GRz33NTDIHq3z25NuJ3qmHJVqCt2OSqRm9y8eQ+THiCrKILTOtAtFg6u+a6rKp5rzv
         OJGoogjAEhSseMc6g37d1VmiUdKdYfrgz5Artt6sbiPX4PAsMlukevRwjExASBR/XH6v
         cf6ORZLM3/aR2rKqqFn5ziykdtaW7ICRDxHqy1V6Fw6AOysqsAA21PnJhrrnaejc51Ri
         +YhutpDHcWTZ2Qka0UXEyHqB1RlSkhGwIYmxYypLVDPjHSuCGGda3SLmHkDtnDg12LK7
         z9WL7p/iqRE7/BA6GdrKVjk2t4+wHqOgojGD4rNVZPAFtjWkBCQ3KuuyiQ6/UpFFJ2O1
         ib0A==
X-Gm-Message-State: AOAM533VSxhaa8QSsdUKODVV+g22iv6cDlcFFWeB9fv7ZU2VFq8LjK7T
        KbDahALO9KTt2Lc5zrtGEmVdfosUgl7xpg==
X-Google-Smtp-Source: ABdhPJxnL2wSNJdlvt+v89TrklGtERmcJMRUUJ5y+vDvs9syXUbaW49RZPs72r03EchAytYRSSJULg==
X-Received: by 2002:a92:4453:: with SMTP id a19mr11384892ilm.233.1634475156480;
        Sun, 17 Oct 2021 05:52:36 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o2sm659247iow.16.2021.10.17.05.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 05:52:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] brd: reduce the brd_devices_mutex scope
Date:   Sun, 17 Oct 2021 06:52:32 -0600
Message-Id: <163447514844.88529.5923880648838724092.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <e205f13d-18ff-a49c-0988-7de6ea5ff823@i-love.sakura.ne.jp>
References: <65b57a74-34db-d466-df67-c7a7bb529ae3@i-love.sakura.ne.jp> <20210907064958.GA29211@lst.de> <e205f13d-18ff-a49c-0988-7de6ea5ff823@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 7 Sep 2021 19:18:00 +0900, Tetsuo Handa wrote:
> As with commit 8b52d8be86d72308 ("loop: reorder loop_exit"),
> unregister_blkdev() needs to be called first in order to avoid calling
> brd_alloc() from brd_probe() after brd_del_one() from brd_exit(). Then,
> we can avoid holding global mutex during add_disk()/del_gendisk() as with
> commit 1c500ad706383f1a ("loop: reduce the loop_ctl_mutex scope").
> 
> 
> [...]

Applied, thanks!

[1/1] brd: reduce the brd_devices_mutex scope
      commit: f7bf35862477d6d4f8a9746c645a4380de984700

Best regards,
-- 
Jens Axboe


