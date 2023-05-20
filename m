Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C2C77B75
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 01:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjETBtZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 21:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjETBtY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 21:49:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C413103
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 18:49:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d2f3dd990so73648b3a.0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 18:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684547363; x=1687139363;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm4OhK5qKynp5k74uCMK8uXMYd8U1EBtCIZ7cxXhkoI=;
        b=EEzubw2EavpiQywunOxFLwHTqghJuHikfn+ulrFFesbBaPetyIfMXG+M8yuSzYffVu
         zAd1yYgNAaycPYkClMgFLnmu8OeCofwFzkzMQBuF6TfpZTIaloEXWos6jwdBPQN77uJa
         pxksCHuZbUYarMPoB5mGmr3y1jI/nPfprK6GpKhfz1evqxpQ7R2bWaN+smEUnxxxQrXY
         lpv7FVo6U4r7BPCJL3Z1f1Mro9cHtVIewAbHZ1+KRQsTxjAZOYU88vy5A8j7cB6+Aw2O
         2fUbIkY1lBs7VDe9nyMkMIOdfLGLY5EMExsNrMjlOTnzMCNjZ1HQEW6dmQaU1H+N6h0N
         nhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684547363; x=1687139363;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm4OhK5qKynp5k74uCMK8uXMYd8U1EBtCIZ7cxXhkoI=;
        b=NG0GrCAf0TdNx3sKxLNyMVulqlAwGqgWP3AhkHJPe3i+oMar9g2O7LRraU+qNdoNRe
         s7FKixRIPfyg9G8bZr8o5iPXJm9xA/228pAifeOshtrCigg4sVUggEbZoblvAGI1sgSc
         kvZpln4OuZuIeBQTl1FLzdtyW1gdPThPkkllzwYI2ZBridcedOKT2/JdGREcnDyqeIqj
         dPPCHDuWNHzwkLaoUjK1IPKb6KZ26McROMZfr5dEyceFFzJLYdaeShMWY+vpbsEVrU1h
         p2O0YXQF8LZ2ndQF3l4MNEDUhFyoURr2wiP7E1R/Qcm1MkY8tsGi94D7SUbwZlcLd+9W
         JwYg==
X-Gm-Message-State: AC+VfDxkg7ZktWc9dZG/wj2zFg7T32d88WQwBlmEUMLsj/hHXUlpG2kp
        a2NrjjiYNGN7FTMVIEUhmmJhJQ==
X-Google-Smtp-Source: ACHHUZ4SUX35/ERXxIOtV0arcaZvpOc/ASi+cqmPgKGBU+YWulY2zYVPBBPclSK9XDU4K2rtz+Ta5g==
X-Received: by 2002:a05:6a00:1c91:b0:63d:2d6a:47be with SMTP id y17-20020a056a001c9100b0063d2d6a47bemr4278163pfw.2.1684547362776;
        Fri, 19 May 2023 18:49:22 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e3-20020a62ee03000000b0063d375ca0cbsm268138pfi.151.2023.05.19.18.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 18:49:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20230508144405.41792-1-hch@lst.de>
References: <20230508144405.41792-1-hch@lst.de>
Subject: Re: [PATCH] fs: remove the special !CONFIG_BLOCK def_blk_fops
Message-Id: <168454736152.379549.7834683815453232435.b4-ty@kernel.dk>
Date:   Fri, 19 May 2023 19:49:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 08 May 2023 07:44:05 -0700, Christoph Hellwig wrote:
> def_blk_fops always returns -ENODEV, which dosn't match the return value
> of a non-existing block device with CONFIG_BLOCK, which is -ENXIO.
> Just remove the extra implementation and fall back to the default
> no_open_fops that always returns -ENXIO.
> 
> 

Applied, thanks!

[1/1] fs: remove the special !CONFIG_BLOCK def_blk_fops
      commit: bda2795a630b2f6c417675bfbf4d90ef7503dfc7

Best regards,
-- 
Jens Axboe



