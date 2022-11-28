Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922ABC4321E
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 14:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiK1OPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiK1OPu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 09:15:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241C6220E9
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 06:15:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id io19so10259101plb.8
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 06:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PeXbR4VeDPxxhnKVtxquv4HIi9pB93Sm/5iGKMaKr2M=;
        b=nJR00g3R6ASO5AuSbPEfC2h4PsLXPm5T3LluihQo+0a3GnL2LZswOu6rV0O0z0E/w8
         bAhjy6K/ftA6ITcDrA5F885oRCvF79kobSWVjdavMNd3Gprd0E+FOWb67OKag/8DzrX8
         HB/y0Zl8PVLKkk1+Xq+YSv7rdFgggZmDdZfLozdg/SqyIHix7rPbxODQnh03gOJADEhl
         VX9mtS6cOy0wWfoGI2vodu1E1BDbvcWueewqRsTgqBTVuUTc+IOSbDd8v+2IQ+IxwtF1
         7fyyqUnrR6S9MFpGGVnkwFrc8/pPRh8v4/EjrfVQYQ2cggNQsZdQulAQkrOz7Mqdapz6
         cMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeXbR4VeDPxxhnKVtxquv4HIi9pB93Sm/5iGKMaKr2M=;
        b=unoYZjgQj2dVystce+Be9SN+JNRWIighwn5JItrsC0ei28NIh0jTIJJtA0qFg782hR
         IqvSP5dOWTPEEtw4k03aZ+GiIytd56YYytlvmDUEpwzf9ThulNhEQUOFOgumJeDxhIvA
         60t/YedWs36xFp+TOMT90mTaUlWl2P7ZrrU/1XJn0YM+/ZMWDj+8ZWV68U2Poyd14u9+
         cn1erwIcuQB0PXlALdg2o4wE1mg1PIr09NzG97Wv73SDBFs6nYTmAKHDJFok/lKuQ2gH
         PaJuEk+1vjRTr14wQC9QUzpSVLg/tuKpUn6NvF+IF/DilPky34D7aEeu2qMBvzol603v
         4iTw==
X-Gm-Message-State: ANoB5pkb+nrt7soyPPFZeCmTdXfWjmM+lNZJQKpZ4H6aNs/oCNpJYr1o
        sE0/BbQuxVdwLCf8paWcC2jHXtLBnEJ2TcYP
X-Google-Smtp-Source: AA0mqf5M2AeSHxFZ3uwu7836L+EQA9yyse8i1g0jWQp4NhnErcENJdmFIItv1Fh859jQIsdlkwMhQg==
X-Received: by 2002:a17:902:b20c:b0:189:1318:714 with SMTP id t12-20020a170902b20c00b0018913180714mr43244698plr.122.1669644948567;
        Mon, 28 Nov 2022 06:15:48 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y185-20020a6264c2000000b0056bc30e618dsm8085433pfb.38.2022.11.28.06.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 06:15:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
References: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/2] Minor fixes
Message-Id: <166964494783.5680.1897835623013824110.b4-ty@kernel.dk>
Date:   Mon, 28 Nov 2022 07:15:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 26 Nov 2022 11:55:48 +0900, Damien Le Moal wrote:
> Jens,
> 
> A couple of patches to:
> (1) fix recent mq-deadline improvement. Feeel free to squash that one
>     into commit 015d02f48537 ("block: mq-deadline: Do not break
>     sequential write streams to zoned HDDs") in your for-6.2/block
>     branch.
> (2) Fix REQ_SYNC use for async direct IOs to block device files.
> 
> [...]

Applied, thanks!

[1/2] block: mq-deadline: Rename deadline_is_seq_writes()
      commit: 4b49197f9fbd2dd4e0452df6effaba665beecb45
[2/2] block: fops: Do not set REQ_SYNC for async IOs
      commit: 26a7bc153a19f3349fd8c2e262728b2eae6bfd6f

Best regards,
-- 
Jens Axboe


