Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E51C433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 01:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiCIBIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiCIBIB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 20:08:01 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3F6141FD0
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:49:11 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 132so593907pga.5
        for <linux-block@vger.kernel.org>; Tue, 08 Mar 2022 16:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=7vzogl3snQJdg9bpcyEA/LktrD/7zcyZz0+PLvZ4jnM=;
        b=4K8nH1sOc4tyxqfsjaMNXKXTq1LhkUrO8Qc/a1TUL0pEqcxAWbjiY31eH0HlnxrUu6
         bzT3g/lREOZKeDo8CDMKy83OW5TPhgVrub3kpkCUy7R7Q33Hmo7Oi65/qj2CD6myRa8W
         s0MzZ+RrVPORxZAxdJpDGs3+MkL+/LZKvTR5ZHm86bYZcFs9X4jEV+OvZ0icvP8MPAa4
         PHSZkafhXXOEtfl81Di5Q/BMV3MnN9zfoHd+GDbk9cwGie60Z829K5a6pohLId6d8Nh4
         VvVEgCrUD5TkTlhDXRuVoX4wV1lmS2h7Kc+kzywi0ibDbFsceUXZqrMt/nsvvHyzsrkv
         Jqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=7vzogl3snQJdg9bpcyEA/LktrD/7zcyZz0+PLvZ4jnM=;
        b=ghfgqGuzXKHa1HjXPdgqlpHwA/hTJ3ohCl2CBBmMpN6Hi/A5MjfhIrFUIhbhB5x2R0
         EyOaJ5xZ6YOxue4EoInvEGF2t9DDK6mxXi+NAhBH8hDzxT/pMILPTjLoCj/3uDYEnTho
         hFj8aH70gYzvQrx1E4p6kSZQYasE1/oWZ53HqZBFf2T6gztBtWxwskAS8A+LpMJ1Fkai
         Al+V6qA04yUzlGuG0GPmqfjDk5YR9h9g7c+hO4dZ3a2mwizLYrnT0Gzv0sZIlk26H2kV
         0LL4bqofJUbzrP8tWYcGB/Q3d+3EmnYZ8TsEhagxGpkNO/P7BsFhLAf87hFPsmmWNxyo
         Gwdg==
X-Gm-Message-State: AOAM532BZBqVqbhMq9Mi6dNvq/BXf8ml2v88/Qoya0g288SX68z2DcYL
        SdKumqeYTxZXIe9YPxpC9kZjgA==
X-Google-Smtp-Source: ABdhPJyX9ihnw+FheQbcv5OeqXFQ/sFc3U0sHtzYaCn2KPezEoA0iTpvVz1AIE9IAVtjkX0Kae1IZg==
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr20726095pfm.3.1646786950864;
        Tue, 08 Mar 2022 16:49:10 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b62-20020a633441000000b0037c794cb68fsm281311pga.9.2022.03.08.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 16:49:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220308080915.3473689-1-shinichiro.kawasaki@wdc.com>
References: <20220308080915.3473689-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: fix blk_mq_attempt_bio_merge and rq_qos_throttle protection
Message-Id: <164678694991.401524.3120405729456177612.b4-ty@kernel.dk>
Date:   Tue, 08 Mar 2022 17:49:09 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 8 Mar 2022 17:09:15 +0900, Shin'ichiro Kawasaki wrote:
> Commit 9d497e2941c3 ("block: don't protect submit_bio_checks by
> q_usage_counter") moved blk_mq_attempt_bio_merge and rq_qos_throttle
> calls out of q_usage_counter protection. However, these functions require
> q_usage_counter protection. The blk_mq_attempt_bio_merge call without
> the protection resulted in blktests block/005 failure with KASAN null-
> ptr-deref or use-after-free at bio merge. The rq_qos_throttle call
> without the protection caused kernel hang at qos throttle.
> 
> [...]

Applied, thanks!

[1/1] block: fix blk_mq_attempt_bio_merge and rq_qos_throttle protection
      commit: 0a5aa8d161d19a1b12fd25b434b32f7c885c73bb

Best regards,
-- 
Jens Axboe


