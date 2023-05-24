Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12969C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 14:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjEXOTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjEXOTj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 10:19:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA49119
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 07:19:38 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7747f082d98so7628639f.1
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684937977; x=1687529977;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27nIvrrZcNL0ZJSKg+xlusXOw1Xbg3Vrq76XZmo3E9g=;
        b=xTn6Y+kgaOtKE9m9CPxZVVhBj2HUWblUluxaGVpuKhn4acXmm/KCuwfVhENkne8uwT
         wABnCvUvgzZE7RN73np59j7leulV6hIxcJmS+p/sBgM70g6bKVW15fvfLFRrKMdciun3
         UJkm5BQHVc4FVyCixGB4u9hLoNZpDOO7C/sDDnEmXhqefnq0Mc+xjCpgU+G2IZpsMy/K
         +W0cQ2TJA8rLHwJbX7WUBN2wvqvO8sSe/HGe6XFkf5NcY8T1uXMfvQJhwjaXqYbmk+te
         CICFR+jHN24USA3+2lYX9+LdOZUHtpX0LGNW2UCfq5SojJ63nddBXwyNj0GAFiJ91TUZ
         mrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684937977; x=1687529977;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27nIvrrZcNL0ZJSKg+xlusXOw1Xbg3Vrq76XZmo3E9g=;
        b=h+j5a+U3SGzuKfcLJi+iok3V6g0VtzCHPJnDot6zPyspVb/DV45OxA+2MG7JLqh35v
         NMGhLVaD3DJ9sPJ6+xRoLLN7C5LVIm+25ySD18XyZWncv/F/QAvc1L7w61ijbbBdGJv7
         gbaqiPIsw84ednG1Sw8i77sdKIaW7R7j9PJMJjBtbts1EK7amIGvbrbDsApiPYGk2Ohl
         7qwXV0I8wlaTui0oJVcAjebfAgNoW97ta2tNDkMHOkRK/cWEGutG50aVLCjfH/S1Wr76
         buWZsjCWGIBBUa1CcoNqSHL/GaSk/D+Znc2YApFU0yQW8mQPeEOEYWtQ25AfFhxnqGuM
         Sw7w==
X-Gm-Message-State: AC+VfDwTWTFE+BeIAUOBuGwKCmeQjezP5LzD6JUSqFPiomwwA8QLDR2x
        NxO+xSwaZvTrFOMZa/Y0WUI+ww==
X-Google-Smtp-Source: ACHHUZ4veSmUBde9Z5UHqLEp9sSGgvjHXKfDUw0Nbt9o4ZFQhJxKxIvfDbWj0/1q1AvMOYGcmFajOw==
X-Received: by 2002:a05:6e02:1608:b0:338:1467:208f with SMTP id t8-20020a056e02160800b003381467208fmr9586248ilu.2.1684937977599;
        Wed, 24 May 2023 07:19:37 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a20-20020a029f94000000b004040f9898ebsm3208714jam.148.2023.05.24.07.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:19:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     minchan@kernel.org, senozhatsky@chromium.org,
        linux-block@vger.kernel.org,
        syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com
In-Reply-To: <20230524060538.1593686-1-hch@lst.de>
References: <20230524060538.1593686-1-hch@lst.de>
Subject: Re: [PATCH] block: make bio_check_eod work for zero sized devices
Message-Id: <168493797680.546524.7090533632380144712.b4-ty@kernel.dk>
Date:   Wed, 24 May 2023 08:19:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 24 May 2023 08:05:38 +0200, Christoph Hellwig wrote:
> Since the dawn of time bio_check_eod has a check for a non-zero size of
> the device.  This doesn't really make any sense as we never want to send
> I/O to a device that's been set to zero size, or never moved out of that.
> 
> I am a bit surprised we haven't caught this for a long time, but the
> removal of the extra validation inside of zram caused syzbot to trip
> over this issue recently.  I've added a Fixes tag for that commit, but
> the issue really goes back way before git history.
> 
> [...]

Applied, thanks!

[1/1] block: make bio_check_eod work for zero sized devices
      commit: 3eb96946f0be6bf447cbdf219aba22bc42672f92

Best regards,
-- 
Jens Axboe



