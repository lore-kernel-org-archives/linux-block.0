Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0FEC433F5
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 12:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D2460295
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 12:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhJ2M5Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 08:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhJ2M5Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 08:57:24 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAB0C061714
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 05:54:56 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e144so12389601iof.3
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=MZmgRDYVVBp3i+ee4X3kdd+CrfkZ0zYRvGBphpmPlc4=;
        b=YD0NduDlFwx5ja58DH6/+BBbB8bHKk753qkbJHzoe9oTH/S8p5fhfWt3KkmuUrk9rZ
         IKpdEyAO1KAvTMOVV2GCqzWMm6odyh+Z44DbJimgw8SBmqmKuBEeiNYE2wkRuljhR8Lj
         NaTK6Nc7SSMT54rBGlDstk2gZkws8pvJrCG5PIl+MW/qgl8lKPBmpUIsWvctOX2Pv9mY
         +CiuLxcbi8jz28y+0nLkUDEB6Z0awpMiV5LVQAzy9NcugOaC3YfkbdBajqcEGnNzIGJQ
         CRDgt2TyocHrRHQ2TN8iGQgaNz/RMF7X9ahRIUELqTpStp/HNKrTNUFtG83H5dsgushE
         FyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=MZmgRDYVVBp3i+ee4X3kdd+CrfkZ0zYRvGBphpmPlc4=;
        b=vzP1w0lzKuWuDblbzLKBu47Km0aP1VPDNsSVIC0IttJsVUxuS9M6rYP7B1Z/39L/VR
         TugYgrW4Vx3aEtRphkBPTBEPYB1H6uIvqpWSEvDfbcLN9cia2kbGOQdMROkm5T6Cmz3w
         Dqw4EiuOsmT+BhpS45uJ4T4lKeNdZIyvR/ZQTUu+tHcNx3zA5e+O8k45dbAWLSLU20Ec
         du9MPAI/ZuF6/tdWEni7+0hbYXV4rmbq1sHNgbyBWWpHWh2/CaNUHMSsolZcErMU7YHr
         jbUSvlJFtZUaICKeqL8yX81+zAGyLzBUhZEw+9g3dIRHsKCIQ2YfuzkEo2C5mU+F2Uxk
         BpNw==
X-Gm-Message-State: AOAM531IPoIhAqWwJJ4DcCU/4FoHLMGNh1qjDKw9wqxfFPTnTWn114Uo
        ONEKqWNBHRfMFfSgpXvArnIFgY2ukrMdRA==
X-Google-Smtp-Source: ABdhPJz6ALJjMGVimG+Ur3NvtmUdOzAnqb6E0Y7He6pZ6HfMELBLz/JbBIKmiCUIRp5v7fqP7T0+jg==
X-Received: by 2002:a5e:9246:: with SMTP id z6mr7748452iop.168.1635512095808;
        Fri, 29 Oct 2021 05:54:55 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i15sm2915665ilb.30.2021.10.29.05.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:54:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1635501029-81391-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1635501029-81391-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] block: ataflop: Fix warning comparing pointer to 0
Message-Id: <163551209402.85558.3310618664405853186.b4-ty@kernel.dk>
Date:   Fri, 29 Oct 2021 06:54:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 29 Oct 2021 17:50:29 +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/block/ataflop.c:1464:20-21: WARNING comparing pointer to 0.
> 
> 

Applied, thanks!

[1/1] block: ataflop: Fix warning comparing pointer to 0
      commit: df75db1fc1e5608271397de37cab43371bb838d2

Best regards,
-- 
Jens Axboe


