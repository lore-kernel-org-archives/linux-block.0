Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC2DC6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 14:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjCOOu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjCOOu1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 10:50:27 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE17A19105
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 07:50:25 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a13so4084365ilr.9
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678891825;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urXmFSAIqf9cS2Q7Ffm5vzZ5mhS0kxXVV0tqFPT2Av4=;
        b=5af9DsZG3gLmtc4J04ljgHUvZkX42GJGypgA/wbIfXI7i8e2f57gALNgN4aDUId3hD
         JGKSvb3tDvcfJKePSqk6+Q0/dPuVKxfzDLX9JDl+2Vcr1LBzoWjvbNek2Rka2E8NCaSA
         YCUUlkXkApkadJh2KiirsgKfv86VfmlGkQgbsprQ1Stxs25JtGEQXAQoK0fV4WWWfwRI
         fJ/4tkx9/V6J+FLb5En1NXB7lBRxOnlbAUdw7ZhdA8DFf+IBit30bWSq6Rg4WVLvh3Ik
         5RBeboHAinH1IsTgOtmuOdex64xzr56SAvZoh9Z9wSuuJvV3d5V3IFW5isK7G+WfGH6q
         HECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891825;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urXmFSAIqf9cS2Q7Ffm5vzZ5mhS0kxXVV0tqFPT2Av4=;
        b=AeK8LpyiQ7rj00ypdaC6D4kBgWQOrzE+Mu/94R9bQ/EbGU2D+sHzB/Ac3Qf8ry354m
         qsoR+evB3OmlKJ4KKR4ImHREUcD++rQbiJZfhGf0vsgBivY+QPgD37avcVhNT7FrIXzD
         RgPX01oihoaHaML7NoK749MR21xncjBNj9X1SApxe5FFgOlcFrHPPy/qyRn8InTMQmJB
         hgpBPdFWRjI/nH9vl/uQ4pbz1AHM3oLPwphY1Cbzvn0+NzrGLqNlbtRdg6F99B+9XaFv
         ay2hDSiVaglqaqEbyMFaOTW/ctmRdua+dZjAzK+9Cak5zKmpa4mDQz+k223g+SAQf7Tw
         un2w==
X-Gm-Message-State: AO0yUKU2PAegFZdPyjWiEw0O81d6Rngmx4QIEPvRCFgCWk7Algfl1FcH
        PvZ37vlRv4/VB2Fcq5gUnYj5irbdq973TQ7o009b9g==
X-Google-Smtp-Source: AK7set/6/dLlRlJxLEVfGwJ5YXSxzZCp1HL91wY/z22IQmFtcz+ZhO0jmLsZzsKMSNgO63CrwAI7AQ==
X-Received: by 2002:a92:b10d:0:b0:319:9153:3750 with SMTP id t13-20020a92b10d000000b0031991533750mr11925734ilh.1.1678891825021;
        Wed, 15 Mar 2023 07:50:25 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g7-20020a92dd87000000b00310f9a0f8a7sm1662460iln.76.2023.03.15.07.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:50:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Liang He <windhl@126.com>
In-Reply-To: <20230315062032.1741692-1-windhl@126.com>
References: <20230315062032.1741692-1-windhl@126.com>
Subject: Re: [PATCH] block: sunvdc: add check for mdesc_grab()
Message-Id: <167889182429.39055.10570504254967369328.b4-ty@kernel.dk>
Date:   Wed, 15 Mar 2023 08:50:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 15 Mar 2023 14:20:32 +0800, Liang He wrote:
> In vdc_port_probe(), we should check the return value
> of mdesc_grab() as it may return NULL, which can cause
> potential NPD bug.
> 
> 

Applied, thanks!

[1/1] block: sunvdc: add check for mdesc_grab()
      commit: 6030363199e3a6341afb467ddddbed56640cbf6a

Best regards,
-- 
Jens Axboe



