Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A590BC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 14:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKBOpQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKBOpP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 10:45:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0862C2982B
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 07:45:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 11so15228400iou.0
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN/nbg0NqP+NEJxaNuJMBwfso2nkMgjJidOrNm8QtFU=;
        b=bQBxfhiwJB0A4fnRM2tR0zguyn2rI99KjpRcf0nQeq/QIVCJGTuiYvCHKuBlLL0NNj
         /mANaogE5KnAetT3XRwoZSlT7BR8O4rLYKBjefVL4hXzv0tGCMZIpBk0qFzkbBB22gCl
         It7iC828jxpzx6GVOb2AmbCsW0xvONfcUTX2LdpBqdzIhRjfL3uxdWLq4PCD13KKNAgx
         /rRrGLJLXOMTNQcyF/cmUMs6c6Ci+CsLysZKYxxyco5j0gejhEXRRaZMiteuroGkZu+e
         y75GXKMoexi6OXL36K/R+V0+9aV4EJj8NnsuG1eV9E2LCX1vCE/OUrOrQTUWDTzMyQdX
         4CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN/nbg0NqP+NEJxaNuJMBwfso2nkMgjJidOrNm8QtFU=;
        b=7a+NlfBE+a6FWb61kIordrLQgZj0PdGgFslhd+fVuaNm2hMttrsg4KDqaX7I/cDLfx
         6u0ntZouvfAdjNo18aEi3L8ChEEJuYquug5D8FsDcnmfJHsynFW38u47ySK6YMkxvnGD
         3441zsuFVR/CoiScb2ofbp+6zd7Yqx0Zs3kx/yiCgy+hDAD9MQpgbd5u6sYnJmJbF8Dz
         ClZxL61TZLjXRPwxz0qHPJbPaDelpt1WJ9Ws/RxZZWWmuKzrHNYYzNxKISweTyf4YKc4
         GLZ6Uh0VN8NaJ4JBkAEz/7YG+8m1LhPFZItAikQ1vKvDXxtyyMFOX5CcVSS4ka3PHzJx
         c39Q==
X-Gm-Message-State: ACrzQf0YMUmC5XeqnAdQotS3JpW8PhLf8H7k/cyTNHFovJP8WczVImoz
        UlWhaoiZV82Ns5QPUTNGi3lUZvA2YaUvepPy
X-Google-Smtp-Source: AMsMyM7yWb1iHppp84a2Y0gyk1Y2/6pYyWpNY0suhiLLKynG3JDkyOIyPAPGHLSUj31cTL6X3dEb9g==
X-Received: by 2002:a05:6602:2d82:b0:6d4:cc5d:b980 with SMTP id k2-20020a0566022d8200b006d4cc5db980mr1891378iow.80.1667400313218;
        Wed, 02 Nov 2022 07:45:13 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t4-20020a92b104000000b002ff32b2ab1esm4615692ilh.1.2022.11.02.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:45:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chaitanyak@nvidia.com, hch@lst.de
In-Reply-To: <cover.1667356813.git.nickyc975@zju.edu.cn>
References: <cover.1667356813.git.nickyc975@zju.edu.cn>
Subject: Re: [PATCH v2 0/2] some random cleanups for blk-mq.c
Message-Id: <166740031203.45892.11870428706627551730.b4-ty@kernel.dk>
Date:   Wed, 02 Nov 2022 08:45:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2 Nov 2022 10:52:28 +0800, Jinlong Chen wrote:
> Patch 1 improves the error handling blk_mq_alloc_rq_map(). Patch 2
> improves readability of blk_mq_alloc_cached_request().
> 
> Changes in v2:
> - drop wrong and worthless patches, suggested by Christoph, Jens and
>   Chaitanya
> - remove silly goto-return-NULL in patch 1 (patch 2 originally), suggested
>   by Christoph and Jens
> 
> [...]

Applied, thanks!

[1/2] blk-mq: improve error handling in blk_mq_alloc_rq_map()
      commit: 7edfd68165b8dab8cde231728ff092a625469eb7
[2/2] blk-mq: use if-else instead of goto in blk_mq_alloc_cached_request()
      commit: 4046728253751adb41b05e85ebd686210efde1ad

Best regards,
-- 
Jens Axboe


