Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F9C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 18:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiKPSwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 13:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbiKPSw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 13:52:27 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0E5663D8
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 10:49:35 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d3so9640797ils.1
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 10:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n95RAejoBvHJ+nFqzG6WTufVF+kbjdKnjE8P14OfBa8=;
        b=M6o1fWtGzBAEUOfgDUiX5uyf5guEq745a0SQIgfsKzHcAwHrlJkl4LUJIX9vB7Z2YG
         eo7W8tBmmiWLvO1cmzJxGAaxDAzfbOGprg8wfnMShrFZ75N8yfIdBlosDP4qw7fI1dyp
         6pHtXdbTrgMyPIsMDHZK0AbwdOOcWTgDsMeoe495YFzNxzZYhN6UmFaEnOg3p6yu/X8u
         hkmXFQ+Jejwb2Sjop4tfwwbGoeF2pvgiNChp2w+UayGYVktxwZH8WvjiULnMkf0xAIJ0
         23rHBeH2B3csEzqZZWFREisKu/KTa15307wR8YLVrlInPtgJW2K7eZNguGY1FwRna9DT
         J2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n95RAejoBvHJ+nFqzG6WTufVF+kbjdKnjE8P14OfBa8=;
        b=bZ2cbkl4tJUQACszKKuY2Zkyild3wm4qnl8IZUrTp7L0UXMtZC5aXwOrH7Pwrnrb8k
         8c3Zar8TwKx5B6QzXtx94vSbksJ8xC5bcrSmit3PDsAWajQ8q+5sO3nvy1lC6TmjHqxP
         MKgJxmc/8Evek0vEOBpHRl+d6bnUobkRgkuYCMFO0DJhlGo78gXsXMptPjS/qYbznQhO
         WU3ruffbv/3XTuE8Ds5+g/PTwifAkKxSlJzk8N3rcfhGKpHnhsjAsfVh0Wo+7YIuLWR8
         Qm+BdDMhEXVwnJVGwlbYexWpsaH/ijsw7cQbAxE6y0XaVfhrlqH089vFN9N8oh/AZ1LS
         CAMQ==
X-Gm-Message-State: ANoB5pmyG0fkKZKOao8DizivJBloEq7S6lbzkjN3HpaBRR6WiKIXs3DS
        UB9zqiBnKON0M65slzNTnOFcHQ==
X-Google-Smtp-Source: AA0mqf7OR9g6q7RZABhBbM3ej3ZcyC2jllQ6stdT0I/9RAomJjbP5n87b7rQfYRPn3GYsqRg/RVavg==
X-Received: by 2002:a92:874d:0:b0:2f1:723f:92a5 with SMTP id d13-20020a92874d000000b002f1723f92a5mr11418319ilm.291.1668624574562;
        Wed, 16 Nov 2022 10:49:34 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m1-20020a0566022ac100b0067b75781af9sm6913174iov.37.2022.11.16.10.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:49:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-team@fb.com
In-Reply-To: <cover.1667384020.git.asml.silence@gmail.com>
References: <cover.1667384020.git.asml.silence@gmail.com>
Subject: Re: [PATCH for-next v4 0/6] implement pcpu bio caching for IRQ I/O
Message-Id: <166862457367.199729.4668127111319120015.b4-ty@kernel.dk>
Date:   Wed, 16 Nov 2022 11:49:33 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2 Nov 2022 15:18:18 +0000, Pavel Begunkov wrote:
> Add bio pcpu caching for IRQ-driven I/O. We extend the currently limited to
> iopoll REQ_ALLOC_CACHE infra. Benchmarked with t/io_uring and an Optane SSD:
> 2.22 -> 2.32 MIOPS for qd32 (+4.5%) and 2.60 vs 2.82 for qd128 (+8.4%).
> 
> Works best with per-cpu queues, otherwise there might be some effects at
> play, e.g. bios allocated by one cpu but freed by another, but the worst
> case (always goes to mempool) doesn't show any performance degradation.
> 
> [...]

Applied, thanks!

[1/6] mempool: introduce mempool_is_saturated
      commit: 6e4068a11413b96687a03c39814539e202de294b
[2/6] bio: don't rob starving biosets of bios
      commit: 759aa12f19155fe4e4fb4740450b4aa4233b7d9f
[3/6] bio: split pcpu cache part of bio_put into a helper
      commit: f25cf75a452150c243f74ab1f1836822137d5d2c
[4/6] bio: add pcpu caching for non-polling bio_put
      commit: b99182c501c3dedeba4c9e6c92a60df1a2fee119
[5/6] bio: shrink max number of pcpu cached bios
      commit: 42b2b2fb6ecf1cc11eb7e75782dd7a7a17e6d958
[6/6] io_uring/rw: enable bio caches for IRQ rw
      commit: 12e4e8c7ab5978eb56f9d363461a8a40a8618bf4

Best regards,
-- 
Jens Axboe


