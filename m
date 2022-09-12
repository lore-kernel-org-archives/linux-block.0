Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6839EC6FA82
	for <linux-block@archiver.kernel.org>; Mon, 12 Sep 2022 06:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiILGLA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Sep 2022 02:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiILGK6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Sep 2022 02:10:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B720A1EC43
        for <linux-block@vger.kernel.org>; Sun, 11 Sep 2022 23:10:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o5so2352786wms.1
        for <linux-block@vger.kernel.org>; Sun, 11 Sep 2022 23:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=B1Edghr8vqH9ZPQm+sb2jTxjtkq1RNTuah3Qw0uGLlI=;
        b=2XpJsGTpzXgMcAI65G9JZbFYeo6DFsrivCa4Ka2orphnxlAaiCjVD7f4emRkLi92KF
         4OJPIVyOpzRTvW+RFOvAMyGdgquuek2oiof46iSAxdQrU3CqjzSimSDPbzHxIAQD5Rg2
         NaANYLpPPYoQC5GinQ7tSXLOgIQ1rLoUz20KW3TYf0055PcqxNAWqZWaQ+9OW14hEvJM
         m5zVnayNUfN54alKMQh36NDyK+81i8cktR1wFACOlagloIIRQ17Pox8K0nnVpZzspEpy
         YyU3aCCbp37PE9W1nURiBOthxhCNF6m5JITz5nXnOC814WEQN3YSEuPvYstdeE1HHHE/
         D7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B1Edghr8vqH9ZPQm+sb2jTxjtkq1RNTuah3Qw0uGLlI=;
        b=lo5DpAid9A+Hx3AYf5Za4hlYZgR4K7SFPxoICVc+ykjmRw84aL0hOd3bR6UFQMGodd
         N8bxv7/7fE94IJpmGNQYoje5NuZW0b5Zj3Q/U8u5lmXjyqQI5ZfKEL9wSHcb/E8qRy9Z
         5YWoyRwOqunk7J/kic4Ic32dcmXSWFXp3k73qqlK69Ev0yDQwdM2hBd057oo3EjrngFl
         HU4pfNvlSnd81gdOOf5G4BPUK/6BR99s6A5UKsebvBNYyOu2A0VRzTs2DoUtyDHgAztw
         uEV6ymuiQ/hm50MOPBMBlicCTbizGcAxu5YCDBPgL5tBbnR/viel5NPyWPB70FqdyD2Z
         Q54A==
X-Gm-Message-State: ACgBeo2HPDWNzEXDAhebJ0H9UrDT2baZdYbB6nXnG/WFQdNPoy0gDUHB
        Irgjka8VM0u4soBRBbOU39UfrQN/7FIjb5Yq/7I=
X-Google-Smtp-Source: AA6agR585pAbkxCoj974vst4SHbj5HjX6jUGhX07lu9vUDq7qBhzI6BSiRCs+F99evmB9PIpDfMOoQ==
X-Received: by 2002:a05:600c:1e8b:b0:3a6:1a09:2a89 with SMTP id be11-20020a05600c1e8b00b003a61a092a89mr12443613wmb.108.1662963054858;
        Sun, 11 Sep 2022 23:10:54 -0700 (PDT)
Received: from [127.0.0.1] ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b00228dcf471e8sm6276062wrq.56.2022.09.11.23.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:10:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Keith Busch <kbusch@fb.com>
Cc:     Keith Busch <kbusch@kernel.org>
In-Reply-To: <20220909184022.1709476-1-kbusch@fb.com>
References: <20220909184022.1709476-1-kbusch@fb.com>
Subject: Re: [PATCHv5] sbitmap: fix batched wait_cnt accounting
Message-Id: <166296305412.55873.17622965267596423832.b4-ty@kernel.dk>
Date:   Mon, 12 Sep 2022 00:10:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 9 Sep 2022 11:40:22 -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Batched completions can clear multiple bits, but we're only decrementing
> the wait_cnt by one each time. This can cause waiters to never be woken,
> stalling IO. Use the batched count instead.
> 
> 
> [...]

Applied, thanks!

[1/1] sbitmap: fix batched wait_cnt accounting
      commit: 4acb83417cadfdcbe64215f9d0ddcf3132af808e

Best regards,
-- 
Jens Axboe


