Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E0C433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23336115A
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhJSMO6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJSMO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 08:14:57 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9B5C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:12:45 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id x1so18127605ilv.4
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2+IEK3kg0Zk0fJ8fVzfsJ8iQZtRFkLoIjiPyMP+4TQ=;
        b=rYMR3/ayUdq6BOHApXcp3WB8LgaM+NV4OChBFajBEypzKlP5oEtHPhP6l29DHWi+u5
         Z4xECFjipr206uH0Av8SQzdEUxp53elYQFNswRVJtpzNj+vbY5dFRLjr3pmM6OVvOv6N
         ywdmDr8bE2+0vQrEtFDAgrabxwfygbSMXEz37Gv7mAhjZcCgQqPGNJJsMOz0nKZ14Ayc
         7FQzr6r/MS4h+V8vkqoHZ3dOGEyTlU2jxGfk11mZIq9RsH0oKRiCveZTA8UcnQfmozUK
         qqpMa3wOVr/XLwqkIeiV+f4+YgS8Dzreo6cUzr/U1HUy1PgXtoo/ZJM8BDdc4tGvPv9S
         LRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2+IEK3kg0Zk0fJ8fVzfsJ8iQZtRFkLoIjiPyMP+4TQ=;
        b=bDRtAso471y15meZhsKv5DRPpkXJQSdP2jgd8iZKNrO9BNzsugpuMnFCh8alcr8Rjz
         DdeUgKezC9XJLH+twPxHMeiPaKsnPOL7LWsCWcwFtUeB2whWB/MiDFmGqJMv5MQvdxGg
         ASFQ6/Mvd4zMlNJcQzAQPKm7duTG9SElmQBcCD9B+9hvs1HMrWolPpgDAMogFQQOMBfm
         pxYbXHx2TNQAnc9L+dfrfta7T7ohEhulFthcE51jkqeSE+9e8bXRZaL5cBbrQ964T281
         Rf+UZalKJsn2Lfq4D7CZiqwzXT1xJEgbksJcipDxsYv8XhqikMm/lmC/WLrXUTAakWV0
         sl1Q==
X-Gm-Message-State: AOAM531Dr6H/mjmLGA0ZhyOQKWNXF9NBj8gEbrvd2U+CKxVjOBFnCiOM
        r0e0ymicnRgwrgHu8gI2n1V9MBfvxXYrXw==
X-Google-Smtp-Source: ABdhPJy1dAgRBhEuurIgLxhtm5eJT2y+bdnaMO2DXmtd55Pm4T/CUs9a59T40/rDSJV07Qx3iTn0cA==
X-Received: by 2002:a05:6e02:160e:: with SMTP id t14mr18857041ilu.107.1634645564723;
        Tue, 19 Oct 2021 05:12:44 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y6sm8587580ilv.57.2021.10.19.05.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:12:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     geert@linux-m68k.org, Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block - ataflop.c: fix breakage introduced at blk-mq refactoring
Date:   Tue, 19 Oct 2021 06:12:41 -0600
Message-Id: <163464555754.595860.5260761740824485566.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019061321.26425-1-schmitzmic@gmail.com>
References: <20211019061321.26425-1-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Oct 2021 19:13:21 +1300, Michael Schmitz wrote:
> Refactoring of the Atari floppy driver when converting to blk-mq
> has broken the state machine in not-so-subtle ways:
> 
> finish_fdc() must be called when operations on the floppy device
> have completed. This is crucial in order to relase the ST-DMA
> lock, which protects against concurrent access to the ST-DMA
> controller by other drivers (some DMA related, most just related
> to device register access - broken beyond compare, I know).
> 
> [...]

Applied, thanks!

[1/1] block - ataflop.c: fix breakage introduced at blk-mq refactoring
      commit: 86d46fdaa12ae5befc16b8d73fc85a3ca0399ea6

Best regards,
-- 
Jens Axboe


