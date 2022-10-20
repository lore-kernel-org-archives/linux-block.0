Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD981C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 12:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiJTMum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJTMul (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 08:50:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F2A18952A
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 05:50:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k9so19776821pll.11
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T6X+tt7V+91kobXX12t6/xBrHgsUusEkXMw0L2QMKo=;
        b=V1e+eumcTbSiXyjph0yA3r/AC6Jy3E7VdU0fC5UdvN3Jjv5eHkX+KRzb3g/5Snd3ZB
         TO3UwH0dGpPsF3IU1lCS+drZ84tqXau9dHvtNPhV2RLawCrjLIQ8PR4P5KZqR87/eJqb
         SE0VT26rx6WgMpUXzQiyNswQClOxqQojw78L07iPRMxPxe3bOhmP16OZQ6rbU0gwzOxU
         KnGQSw+KJJBW8s1zOep5CjR4Fmsir+FCzi9T8L9Okp56p7CnC33SIIoZB1zuZMOvWIPD
         RMXguy9y9Ej7zdSAjXnm6we46Y+87YtUPtndgbrZl3Bjtl/wMhRUbj0BQhxgNuJ6Dgcp
         Y9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T6X+tt7V+91kobXX12t6/xBrHgsUusEkXMw0L2QMKo=;
        b=3sh7MlzR6FNpQtyYJInREz5EpdVZSwEaxhCHEXYYvgwYskLp5iKpx0lst2r7sQWukd
         yO30gD6CPP6Lx9HXeuMB+5JlLZSd25WjBsL2pevxEtkYNV9VuVc4ItpmEARwLDgmd0yN
         MzeecQS0MvkR3mOOIgKJTdOxFHbwgj9gW0Q9ngENtCO8mMOrp8oK+JPnYOHlWZF76BKk
         RNCXSsEnW5rIChfpMoESo91IWMoLmq8iyii75ViUZekU6bzRdeIT83UZhKG0V+KbF4fz
         MZGt0sGpSu2H0JWon47DE6HugG6h3ull+lKLOQvgQumd2rn7BvnjF6zYwMNhWoYhYx1Z
         d4IQ==
X-Gm-Message-State: ACrzQf2HgFKhLYnIyoQPv18z8isiT3QySU58MLdygNRPIRupNzZ06btV
        2f54Vtzi/cKyp/ricQn73V9TqrchWBBfHqNd
X-Google-Smtp-Source: AMsMyM4TRzgWshHzykwjj+0oSUfvvDKlhXsmbl0EEBW/4qsIASSjpO/zYNZVz/MgLoZQ1OlX/n7zyA==
X-Received: by 2002:a17:90b:2243:b0:20b:42a:4c0d with SMTP id hk3-20020a17090b224300b0020b042a4c0dmr49870333pjb.123.1666270238215;
        Thu, 20 Oct 2022 05:50:38 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b0017f7b6e970esm12885047plg.146.2022.10.20.05.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:50:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <cover.1666122465.git.asml.silence@gmail.com>
References: <cover.1666122465.git.asml.silence@gmail.com>
Subject: Re: (subset) [RFC for-next v2 0/4] enable pcpu bio caching for IRQ I/O
Message-Id: <166627023722.161997.8160242378689353670.b4-ty@kernel.dk>
Date:   Thu, 20 Oct 2022 05:50:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 18 Oct 2022 20:50:54 +0100, Pavel Begunkov wrote:
> This series implements bio pcpu caching for normal / IRQ-driven I/O
> extending REQ_ALLOC_CACHE currently limited to iopoll. The allocation side
> still only works from non-irq context, which is the reason it's not enabled
> by default, but turning it on for other users (e.g. filesystems) is
> as a matter of passing a flag.
> 
> t/io_uring with an Optane SSD setup showed +7% for batches of 32 requests
> and +4.3% for batches of 8.
> 
> [...]

Applied, thanks!

[1/4] bio: safeguard REQ_ALLOC_CACHE bio put
      commit: d4347d50407daea6237872281ece64c4bdf1ec99

Best regards,
-- 
Jens Axboe


