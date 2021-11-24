Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF41C433EF
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 15:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbhKXPjJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhKXPjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 10:39:09 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A8C061574
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 07:35:59 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 14so3735602ioe.2
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ALC9G3idPSTxHx3dNiOgUJQN1a8TR7dxQYUksHu/zIs=;
        b=OphTRyK6qDVjdW1vyecYiw1W5ZJe4pqzmSjfYt1r4hszVgEN3uUQazfD/8yD1RL021
         u12M0CqKMocFNWKHs9CtoTKo6n6VVJ4cRA+B4wORZCUeC0ACf1agNpk8COAAUqYDtNSx
         KDvo++Cy1YeBCyONEVFLzuUsGaAKO+MzQEYv+QUgjDwnu/fncWgjEnvXOK0oNvT1kawJ
         Y3vjzqbpYBz9KCRskOv94Qi3s/pWwr4weWUNs23M7pFSjbyAv3l2DDPgiQF2cAIfbMCC
         UtbZhlMj/Dij5kkh6b8x7YDs60eaWl/lFqXKyE2mpHN37xbBrEqCfw6quWd9K8wOGF2y
         6noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ALC9G3idPSTxHx3dNiOgUJQN1a8TR7dxQYUksHu/zIs=;
        b=mx9f7zJzubhU6nSJH4WNVr1dQGDfJsMFTMZyOk4qxsakYk5YfVkpTvcqLb1Q5EiSXV
         MQ7njimgDHRnSaUxuK7e2y5GdK43jPaciY0LTZ9FY140+aWcvrquFMU5wc2aoj0tB/GR
         X7IUquqJGPWNYCrzn7FuYnisHc+h0vV3CpXy0Ql/LjPRhJbsL+8pkji+IDHEjHYLCL+r
         5sAJ+5qe4CJS5RdXqPZFcWQ1JiBmdUVVVqeWF07yBTVoJSx6OhEwxzihYEK4xNRry+sf
         V1N5KbgnA0tAbAdlUMhvPg+kipfTv7Jlk9sFBIFTM77llB8edAdD5hozg2rVHUGXlTWN
         NtCg==
X-Gm-Message-State: AOAM533fQRVpwm+2e0RdjQWRs1TomYaaLYMPp0h/0jGRosXztccVEi5k
        C6PcF1n+JQ2mURwt55SB7IBPZ+n3rLD/tFyd
X-Google-Smtp-Source: ABdhPJyatE8HltBUfs27t6XlOnjW7EieRk0cpAiFTjUptRzWeONfb42cgapP5VJWEe+M2td2ZyoDVQ==
X-Received: by 2002:a02:caac:: with SMTP id e12mr17748082jap.29.1637768158735;
        Wed, 24 Nov 2021 07:35:58 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o10sm100025ioa.26.2021.11.24.07.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:35:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <8ebe3b2e-8975-7f26-0620-7144a3b8b8cd@i-love.sakura.ne.jp>
References: <00000000000089436205d07229eb@google.com> <0e91a4b0-ef91-0e60-c0fc-e03da3b65d57@I-love.SAKURA.ne.jp> <YYxqHhzEwCqhsy1Y@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com> <9e583550-7cc8-e8a9-59bf-69d415fffe16@i-love.sakura.ne.jp> <20211112062015.GA28294@lst.de> <7d851c88-f657-dfd8-34ab-4891ac6388dc@i-love.sakura.ne.jp> <20211115095808.GA32005@lst.de> <eec36e72-ba7d-6c7f-12e1-a659298fe98b@i-love.sakura.ne.jp> <8ebe3b2e-8975-7f26-0620-7144a3b8b8cd@i-love.sakura.ne.jp>
Subject: Re: [PATCH v3] loop: don't hold lo_mutex during __loop_clr_fd()
Message-Id: <163776815823.461899.13506463183917934462.b4-ty@kernel.dk>
Date:   Wed, 24 Nov 2021 08:35:58 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 24 Nov 2021 19:47:40 +0900, Tetsuo Handa wrote:
> syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
> commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
> is calling destroy_workqueue() with lo->lo_mutex held.
> 
> Since all functions where lo->lo_state matters are already checking
> lo->lo_state with lo->lo_mutex held (in order to avoid racing with e.g.
> ioctl(LOOP_CTL_REMOVE)), and __loop_clr_fd() can be called from either
> ioctl(LOOP_CLR_FD) xor close(), lo->lo_state == Lo_rundown is considered
> as an exclusive lock for __loop_clr_fd(). Therefore, hold lo->lo_mutex
> inside __loop_clr_fd() only when asserting/updating lo->lo_state.
> 
> [...]

Applied, thanks!

[1/1] loop: don't hold lo_mutex during __loop_clr_fd()
      commit: c895b784c699224d690c7dfbdcff309df82366e3

Best regards,
-- 
Jens Axboe


