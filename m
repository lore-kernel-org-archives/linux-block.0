Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F91EB64DD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jul 2023 02:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGYCNZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 22:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjGYCNZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 22:13:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E326610C8
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 19:13:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-682eef7d752so1185351b3a.0
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 19:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690251203; x=1690856003;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c56ngKgwQSzfHDy9Dm42Yy/BRXc7xqLsg2OiHBTaeUo=;
        b=rX8oyCBGAKyNesUFXJ5uFsq/CIlxJCOC3U+ovGdQybNVguFvtvXiSmqaiBr5+5rdrW
         4d7aoTiKoUjjR9UZqRZQqGawljYxrQ/mCQ50V2b2wNY6v2Om3N3RfaGUv1eKdEh8k4Iu
         E260IpiaMeplxzc6mkfptKBa56euaLBYaYMGIgGlphyZqMO8qdcZrwNGe0uYUtXMIYeq
         nGlX6sYoNWCwyxgTlaTlaBB9DOdhN5NapQC58QtKjXbzbK6F29vUWUBC6AYVovt4jV+i
         BCLuFP8qFDohkl0Sm0xhCqeAkJrMuBfbI7KDAgp7qWIDwha9qGu1EyguSAeObUmIO3R6
         aTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690251203; x=1690856003;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c56ngKgwQSzfHDy9Dm42Yy/BRXc7xqLsg2OiHBTaeUo=;
        b=K/iV0EkCMxikL8KLSDBzr0BncnnMAUGnKAxgxALoqSCTkov0IdypuHtVypRRggcziP
         +lQ1Lruj0XMCt+MT28IPdTq3yR0Hxpzp95kzX9oqMbbpPH9VtxsK7ReyX0WRWmkKqWRB
         CF0zbUnIapBDgysWR8oYga/m1NW4JFoWxzZGUK4NonbxtfZPHdCRuUg8ybPUZrViMLbH
         MrtNuj3E1v0hI40hyiUcX5tHkTkuS6k913EBF/1oQKoAtnEIQDCIMCwb6yO+AgdKFx5d
         zXfrxqX/YDqaY/Oa1uadSLjBR7VfYMDmyKJstTvUv2A1IZdj8/x+iaNAT/1dVseIRGEf
         jkyw==
X-Gm-Message-State: ABy/qLb/UaJagklUv2kpaorX0GFSGRZ5Or65dMn46AYCC0ub4nittLDR
        jGPRyOY6j/eCUJryxN/kNo+vd1ICgA5bHZeT2BI=
X-Google-Smtp-Source: APBJJlGg5w7DuVJYL5K5/odNK2wJ4lY8QXgSfaPz8dBNSmCB4wMhmCKtKgtBak1sLyPYgHTfYFgLmQ==
X-Received: by 2002:a05:6a00:1d19:b0:67f:8ef5:2643 with SMTP id a25-20020a056a001d1900b0067f8ef52643mr12402195pfx.2.1690251203326;
        Mon, 24 Jul 2023 19:13:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b0066a65d4648bsm8286329pfm.151.2023.07.24.19.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 19:13:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20230721172731.955724-1-bvanassche@acm.org>
References: <20230721172731.955724-1-bvanassche@acm.org>
Subject: Re: [PATCH v3 0/3] Improve performance for BLK_MQ_F_BLOCKING
 drivers
Message-Id: <169025120261.657564.4029457065154945689.b4-ty@kernel.dk>
Date:   Mon, 24 Jul 2023 20:13:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 21 Jul 2023 10:27:27 -0700, Bart Van Assche wrote:
> Request queues are run asynchronously if BLK_MQ_F_BLOCKING has been set. This
> results in suboptimal performance. This patch series improves performance if
> BLK_MQ_F_BLOCKING has been set by running request queues synchronously
> whenever possible.
> 
> Please consider this patch series for the next merge window.
> 
> [...]

Applied, thanks!

[1/3] scsi: Inline scsi_kick_queue()
      commit: b5ca9acff553874aaf1faf176e076cbd7cc4aa0e
[2/3] scsi: Remove a blk_mq_run_hw_queues() call
      commit: d42e2e3448a99c41c8489766eeb732d8d741d5be
[3/3] block: Improve performance for BLK_MQ_F_BLOCKING drivers
      commit: 65a558f66c308251e256317957b75d1e643c33c3

Best regards,
-- 
Jens Axboe



