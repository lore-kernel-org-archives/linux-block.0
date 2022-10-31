Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A564FA3744
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 13:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiJaNcR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJaNcQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 09:32:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A210052
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:32:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u6so10729436plq.12
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRx4c97dxlZARSf0pXzKUxKSmewMkvqFqpXULat30TY=;
        b=X7vQz0ynmmKHnuxcYEkg27UDLb7o7h65YUenYhNtFTothhirhX9GuYenupHtEu47x4
         8igUWatnuNoI6Wu9diYqgZW0gDhFw5S6dThL3dZ9I8reXtw4ZHdc361jGren3HXwU21Q
         jP7Bn9IvTgUT+CTvlnpGg3AHlmlWQbclEldVcbxUXXqmpgMmYEKHOYcuPEO3eXnW1oOj
         u2qOpt1YLy7cjj4undsoeNJbbs2M5G+nqQ+P338ZYlzlcjF99jAiZHBfsw8dnhkIaADc
         2NRFHnjv4DVPRuza2frVoR1E4TW3ABjj5dqG9iXbePf6uaYuVKuE+eJQM0E2rnFx1hQX
         BSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRx4c97dxlZARSf0pXzKUxKSmewMkvqFqpXULat30TY=;
        b=fcLvA1C5Yf0d+n0nv9CbQU5g0SVRjO8GKcAK7WfWG8ey/twh2xPAVzBqaqT4EwqY7m
         d2e/U5vCiO89fN3pJwANZ+FrVmRIh9/WuhqTY1d3y4M0scDYpnmoBoJVE1MUy8eGPASk
         6GZxlBp8BY371WPC33tUwIesCFxBihv3ZILryKdx7i9IFIBqhWowz1nGkKgg156lS9T8
         fT2q1388/hQ35MnUX73MVXJGLaaG4IlezGjAU40qDj/RjzldwJvcVRaHjHSs6b/SbWhp
         6GnBiy05rMUu1qr7F6fCPlnRtu6Tj3MEP3dQgfztDPsQB7HEnAUPSwtZ0usWmJmH3WuP
         V5dg==
X-Gm-Message-State: ACrzQf2TPqORLOfU5sc6da7fnLyQvpa+VG3X2ImfnZ9O4vG3nAS3nVeV
        FrxHqTyncYujUV62fhHEqbDnZg==
X-Google-Smtp-Source: AMsMyM7prUdvNlfH2oRedW1t0cTpDNOHB43CbuNyJjjHLbSEN4IzOwU9QZdX0FKwfJV6AvwUqEE/Hg==
X-Received: by 2002:a17:903:2402:b0:184:29:8ac0 with SMTP id e2-20020a170903240200b0018400298ac0mr14040001plo.174.1667223133865;
        Mon, 31 Oct 2022 06:32:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t189-20020a6281c6000000b005668b26ade0sm4565791pfd.136.2022.10.31.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:32:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, bvanassche@acm.org
In-Reply-To: <20221030083212.1251255-1-nickyc975@zju.edu.cn>
References: <20221030083212.1251255-1-nickyc975@zju.edu.cn>
Subject: Re: [PATCH] blk-mq: remove redundant call to blk_freeze_queue_start in blk_mq_destroy_queue
Message-Id: <166722313299.68022.4225942407488507995.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 07:32:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 30 Oct 2022 16:32:12 +0800, Jinlong Chen wrote:
> The calling relationship in blk_mq_destroy_queue() is as follows:
> 
> blk_mq_destroy_queue()
>     ...
>     -> blk_queue_start_drain()
>         -> blk_freeze_queue_start()  <- called
>         ...
>     -> blk_freeze_queue()
>         -> blk_freeze_queue_start()  <- called again
>         -> blk_mq_freeze_queue_wait()
>     ...
> 
> [...]

Applied, thanks!

[1/1] blk-mq: remove redundant call to blk_freeze_queue_start in blk_mq_destroy_queue
      commit: 56c1ee92246a5099a626b955dd7f6636cdce6f93

Best regards,
-- 
Jens Axboe


