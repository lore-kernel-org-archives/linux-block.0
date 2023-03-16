Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D8FC76195
	for <linux-block@archiver.kernel.org>; Thu, 16 Mar 2023 15:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjCPPjB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjCPPil (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2023 11:38:41 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D3F23104
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 08:36:56 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j6so1201693ilr.7
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678980957; x=1681572957;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYar2ybeVJqnai5t6j9VGmRtR2ovUMfBI/dkWezXyWc=;
        b=sVk1JuZmFUhd1tlBehU7iFt3sVXohrn+jnAzxsEhXyW1rV3rTUKOwK9OK1Sh1mDfzd
         Kdv9QjNsZcBRnPUFaxFo+MZqaO/wdpiUCKcD0WaWhPqnh8kAVh2LV8rzxLXlt/nl0ZkI
         zmuuw653yy4/0bfN11ybpCc2F1GxYJUez5q3lorEpqZmPHRWANi9M5ZirtBDnQaQV313
         h3yoZbRmcM/85ydvtqPw4hElb0MKrZBkT5NK+SHPVpIXcq/POirSUbuXiM63Nt1VDxJQ
         tmJwN2tMboNaBqDwf6Ag8Rl5xWxtCDFYcmMQQgdpU8duQc+zZpHZfsl8DtrjYmguNLfo
         5SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678980957; x=1681572957;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYar2ybeVJqnai5t6j9VGmRtR2ovUMfBI/dkWezXyWc=;
        b=GpTVcR6bjWOnjQEXwR+ayvjVOfgoyGjpy80z2TLZ/Uk57PBbaIqowQ5cCysb/MiBUj
         Rewtfx5pQGuV1xs7dGw+EU7yCaptrcCL/qppjxIbu/+q2QMgKP1ayMy3h0qPEVlvD/1y
         sX9f7fFTMIE6cdbhEPhR62mwG4yc2XPDl4Mc4QpkcxEY+at+IZwoxWK+OnZpu41Yr3++
         OxBWW7Yy6KUB0stiZEsmA199ZZWUtXF6ByggBzCdrLNNNWkuSno5PwkqUY2nlA/W6Ahj
         aGhz4hcxmw+gsIT1/27X0RAnYME70lUU5SrGmLupZbrpay6qiE2zce0FjnEWuHkFZISj
         AGKw==
X-Gm-Message-State: AO0yUKUocXUHeuWAzn7Dr3j7XVganass7O1PPyWctUDe9va5kOA/R2XP
        ebIPv76bvyYiEWCNOiv8hkWtEDSm5vHDHI+EWNUiQw==
X-Google-Smtp-Source: AK7set/W9ggxEyvzAzMZ4ShGBmfvBVdryiJ14kkiBwYaN78df/A1Lz33twWv8A/A/Ldki12xG+KOpg==
X-Received: by 2002:a92:d64f:0:b0:323:10c5:899e with SMTP id x15-20020a92d64f000000b0032310c5899emr4228071ilp.1.1678980957025;
        Thu, 16 Mar 2023 08:35:57 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t8-20020a056638204800b004050d92f6d4sm726970jaj.50.2023.03.16.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:35:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230316111630.4897-1-lukas.bulwahn@gmail.com>
References: <20230316111630.4897-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] block: remove obsolete config BLOCK_COMPAT
Message-Id: <167898095613.31557.5292857532580529637.b4-ty@kernel.dk>
Date:   Thu, 16 Mar 2023 09:35:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 16 Mar 2023 12:16:30 +0100, Lukas Bulwahn wrote:
> Before commit bdc1ddad3e5f ("compat_ioctl: block: move
> blkdev_compat_ioctl() into ioctl.c"), the config BLOCK_COMPAT was used to
> include compat_ioctl.c into the kernel build. With this commit, the code
> is moved into ioctl.c and included with the config COMPAT. So, since then,
> the config BLOCK_COMPAT has no effect and any further purpose.
> 
> Remove this obsolete config BLOCK_COMPAT.
> 
> [...]

Applied, thanks!

[1/1] block: remove obsolete config BLOCK_COMPAT
      commit: 8f0d196e4dc137470bbd5de98278d941c8002fcb

Best regards,
-- 
Jens Axboe



