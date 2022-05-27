Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C3BC433F5
	for <linux-block@archiver.kernel.org>; Fri, 27 May 2022 12:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352660AbiE0Mnc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 May 2022 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352708AbiE0MnX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 May 2022 08:43:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A53335A8F
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 05:39:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p8so4227705pfh.8
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=V8h8ENXY3OfHxOG1UL16nytkTQ7epj4ERCCR6IHz+vI=;
        b=cCYM4rZGfenuqmnKHVL2AjQcHzqfSQnRYNq/BkFTq04FG1+6cC6qStvtMmL0JVou8d
         ea9udzRLh/L0v6nFLaB87gCEjVkm7RZf0NRUrZT7g2mp6WedZn0GAFBkNjfdRpaEE4NE
         JsEoCXK5qFqOAoC8nU7SIAXfIfyPIAiw8j78JV5MK9L36UVu+1skfc3KD1p40vEotpvw
         Klt20S5o/B0wv5jYoNhjKiDPvKuAn26Lv/kscrkph5l2Y35P/JJmGTK2yfVk+GyDM4DR
         B3ofJM4VcBJegyv7EgmG73JpQotfwGYJXd4Gald45sVvHUc28KbBtGCW1E1LxBn9HmXp
         Wn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=V8h8ENXY3OfHxOG1UL16nytkTQ7epj4ERCCR6IHz+vI=;
        b=Brc5PCP4JMsx24oufKEyvM2EbTR28QrpTGkRwgRyHmen92G8zsP+6u55sm14UqWN5D
         7+qrc/Ko6s+ByjJSHzF34fvVfJ63Hkp9Msmd/qYjWF2JDScUKfV+h14eVLlfmw3Dxs+k
         wyqPlxC3CuGyoCu58+rOUGzvKBzEFf2GiqsUiPvS5Qf/YjnzNlJ8VCb3htpI43YJlmZA
         DB6Cgnu3Y3p+JgIOZV9zUs1/byCmeTj8qLrk0GIIcpWL1Um37d6E+0neZlzKCIODnTRJ
         +ebEZ0SszxwSy20HgHgVGGlh5ddWYd3lm5och28xU73r85yi7xQwXpid+2jNTZIzHdux
         +2Hg==
X-Gm-Message-State: AOAM5311vPHM7HgR18mVWZ/Om4UUY1c8pD97/sypynRPUNe8eNz3MR2D
        iCnfHuQ3hWaA5uv48wpNZZV+FwbH5exsfg==
X-Google-Smtp-Source: ABdhPJxZaWMzAVgtpZ9iOwn8n75cZ+1MkqvcmdkAKEiILgRJS7NqmDi/2Lfhn5k3gErQjmOxPf6z6Q==
X-Received: by 2002:a63:1804:0:b0:3db:2d5:3efc with SMTP id y4-20020a631804000000b003db02d53efcmr37549542pgl.250.1653655165609;
        Fri, 27 May 2022 05:39:25 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902a40700b0015ea3a491a1sm3553876plq.191.2022.05.27.05.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:39:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
In-Reply-To: <20220527055806.1972352-1-hch@lst.de>
References: <20220527055806.1972352-1-hch@lst.de>
Subject: Re: [PATCH] block, loop: support partitions without scanning
Message-Id: <165365516479.10701.6499184286153759813.b4-ty@kernel.dk>
Date:   Fri, 27 May 2022 06:39:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 27 May 2022 07:58:06 +0200, Christoph Hellwig wrote:
> Historically we did distinguish between a flag that surpressed partition
> scanning, and a combinations of the minors variable and another flag if
> any partitions were supported.  This was generally confusing and doesn't
> make much sense, but some corner case uses of the loop driver actually
> do want to support manually added partitions on a device that does not
> actively scan for partitions.  To make things worsee the loop driver
> also wants to dynamically toggle the scanning for partitions on a live
> gendisk, which makes the disk->flags updates non-atomic.
> 
> [...]

Applied, thanks!

[1/1] block, loop: support partitions without scanning
      commit: b9684a71fca793213378dd410cd11675d973eaa1

Best regards,
-- 
Jens Axboe


