Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B6C05027
	for <linux-block@archiver.kernel.org>; Sat, 18 Feb 2023 02:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBRCcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 21:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBRCcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 21:32:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378395B2FA
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 18:32:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id dw24so472995pjb.1
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 18:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676687566;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0OgKm01cbWznSga28mZ1JVfLaRBsGBtmtDOiNDsu3U=;
        b=Q3qP9yjsehkxhspO32RhswiHb5QKunc8ZARDBrCnVb+4ANTH7BrAPD+GCtXvf+MhU9
         yM/ByZjRzie+Okx2lcKJ3gIeaDQ5HVILoY+pzMFXYeockpzOdxagTHhVQk9R5G/Hb7ud
         KU6DXQwXZXZk5hqTak2rP60RMge3yjcNVfc+IJssB9Xb1CZl6NN7ckYMJV+aR7qICdka
         Cnz5tQRonyc5jTXUtMcseg6VrlT46pASpm3wqChIxZR2QxSdYUns/xX1H1w0Z7Qt2/a6
         Uzjx5zyd6Sesfqab4en+avnETQmKnVuhm9dsNNOEURqQTxO5Alc187vVhT9vQbDvVa94
         y0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676687566;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0OgKm01cbWznSga28mZ1JVfLaRBsGBtmtDOiNDsu3U=;
        b=h5zYV8+XEfaqv6KzEgLHzZHJeI9kYp5yX2wmgKgT3EBvMbpcfPqNt4qUiD8zT/LS12
         4dzESggVdsZqhjteB1YN4aoxq9h7qkQ0hYAGTLtzVlWqY9n9I/Xca1X/EhJCLVZt/VYH
         haU1rus96PC1tf1PczMhjcCL/BoPXyzS45cu3qLz/7XIFD8tZkQFAJxi9RXdWCs1BjHZ
         NHz5njPJl6gDIXeUVkzS+yfLhrolxKtFndVlyYm3J/TTbKeiuJeedoO9QYXQnYZNtQ3u
         kX4QT7ZJ/uXfXu/AdROJVeiuxyy9pMacWynRsRwvkE2efGOCJJLQlkiF9SPBJ1mshU+W
         qKCA==
X-Gm-Message-State: AO0yUKVTcZoSKt2Ja/dZ1odVskHcejJviV8cWKlLHAdfecuHSsiedBOj
        BI0uHeayVN7vJ+i8YR359jZ96VgPRZSmpYCH
X-Google-Smtp-Source: AK7set8i+OiqXSGRH6tWjtQM0CJhOq/JnYSS/dPSbFWsxXsjY3OcXI3lCaZHVMrOyyNFek7rO/SF7w==
X-Received: by 2002:a17:902:da8e:b0:19b:f5b:4ca3 with SMTP id j14-20020a170902da8e00b0019b0f5b4ca3mr220985plx.3.1676687566428;
        Fri, 17 Feb 2023 18:32:46 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709027fc700b0019a74841c9bsm3710574plb.192.2023.02.17.18.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 18:32:45 -0800 (PST)
Message-ID: <58231104-74e0-c1df-5a47-9027ed0241c6@kernel.dk>
Date:   Fri, 17 Feb 2023 19:32:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block fix for 6.2-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

I guess this is what can happen when you prep things early for going
away, something else comes in last minute. This one fixes another
regression in 6.2 for NVMe, from this release, and hence we should
probably get it submitted for 6.2. Still waiting for the original
reporter (see bugzilla linked in the commit) to test this, but Keith
managed to setup and recreate the issue and tested the patch that way.

Please pull!


The following changes since commit 9a28b92cc21e8445c25b18e46f41634539938a91:

  Merge tag 'nvme-6.2-2023-02-15' of git://git.infradead.org/nvme into block-6.2 (2023-02-15 13:47:27 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.2-2023-02-17

for you to fetch changes up to 1250421697312a7f2f13213a71b430402f2ae8f1:

  Merge tag 'nvme-6.2-2022-02-17' of git://git.infradead.org/nvme into block-6.2 (2023-02-17 09:07:00 -0700)

----------------------------------------------------------------
block-6.2-2023-02-17

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-6.2-2022-02-17' of git://git.infradead.org/nvme into block-6.2

Keith Busch (1):
      nvme-pci: refresh visible attrs for cmb attributes

 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
Jens Axboe

