Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A76C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 14:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiF2OhA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiF2OhA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 10:37:00 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D6F39148
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 07:36:59 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 68so15493058pgb.10
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=8OMjA54YB5/fjN7ZCSgm2M8RP9kWgfJthpUuTA9taMg=;
        b=Vo/rqGL1nRRDNs7qbgHkfJXiFhzv50nXPbF3b8I9TMDkjuhNPbhQKWoa8cuDSIvqPG
         +S1HrfC/mj7Q4u/q3gTlVdExzGLO7r58AFX2rMpKDG/9CBI/gdpb8A4Es3efFRYMho04
         qYDHvC+T+d1/4C98y5YnsX5dous011EBAsHFecZ1hDv7ucB72d6+M8uDGlss3C9ZLwon
         vBVfb1Eqcy+7i1ac4gRlGmQY2LC3PD39KCTmE2xwZud8iacfFgKs79QZ84ly0S1dM/v/
         Qr/giZ14ouiwobUV0XUImtqSnI4OboZ4TinsP5lQ1JPutudTur8t5luCj7hiV0XidIkx
         Mm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=8OMjA54YB5/fjN7ZCSgm2M8RP9kWgfJthpUuTA9taMg=;
        b=s+/oz49i5xJftwMlabMKRdrMhga60Kxmd+zmfUeEgEkGjzERftkeQKDF5/e0rrqcNi
         IIS5FCqlM0/Hwft+/ST4gwtQ88v2B7cOKhRbK1nYrupH+Jwmfi1JPd7y/BJjs5FUO9u0
         wWRAkUIKF62wFN/BhnzyKA2I0A5hMxDUZnkKn8Fzmn6anUvg+EjLevY2hcq2ctC5axHM
         egHBmeZK4sO8fEob7d4f3WsX7moCIHk8ziSfLSezqctSWCjARzQ8NuL6wS4v3Txo1zXL
         sahfV9T7rP0fPukyus/+AY1JLmA5KHest3FnfBedKggLHZagAjB1xIiiweHJWRZ+bvXg
         644A==
X-Gm-Message-State: AJIora9YoSPMTgIzhj1vmFygPC5f7Md/65s71XIdxGxgwYIv3hb0vhuv
        mgNuicF23CxRMu9Qm1n+J5X8Ww==
X-Google-Smtp-Source: AGRyM1uu8CJkuDKrDgX4mYfKOb9EdZvU2V5AKx9ueTNLC+e6vXHbHyt5fNxMAxHNjJHvfyWuZ2LKNw==
X-Received: by 2002:a63:7a0e:0:b0:40c:cfa1:550a with SMTP id v14-20020a637a0e000000b0040ccfa1550amr3234851pgc.514.1656513419245;
        Wed, 29 Jun 2022 07:36:59 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a42-20020a056a001d2a00b0052546961424sm11367959pfx.1.2022.06.29.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:36:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>, damien.lemoal@wdc.com
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220629062013.1331068-1-hch@lst.de>
References: <20220629062013.1331068-1-hch@lst.de>
Subject: Re: clean up the blk-ia-ranges.c code a bit
Message-Id: <165651341843.6730.16258965538046349662.b4-ty@kernel.dk>
Date:   Wed, 29 Jun 2022 08:36:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 29 Jun 2022 08:20:11 +0200, Christoph Hellwig wrote:
> this is a little drive by cleanup for the ia-ranges code, including
> moving the data structure to the gendisk as it is only used for
> non-passthrough access.
> 
> I don't have hardware to test this on, so it would be good to make this
> go through Damien's rig.
> 
> [...]

Applied, thanks!

[1/2] block: move ->ia_ranges from the request_queue to the gendisk
      commit: 6a27d28c81bc5843de2490688a04ee5baa6615e7
[2/2] block: simplify disk_set_independent_access_ranges
      commit: 22d0c4080fe49299640d9d6c43154c49794c2825

Best regards,
-- 
Jens Axboe


