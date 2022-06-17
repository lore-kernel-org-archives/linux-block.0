Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34137C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 11:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381341AbiFQLhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 07:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380908AbiFQLhX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 07:37:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9636A43B
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 04:37:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r1so3639909plo.10
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=8AfYD4SPmxQvIuUt9XI/GcV9rz3zOpiWf2MVLvb6oec=;
        b=ahDzn+erWJh3q0QN2z11RoEDTGy5LIUgj1tgsfHiQpVqgeOm4oiM1rgrM2Vi3Q73gd
         LlxI5aNoL9ZgVdmjjshOvvxhkbvYBObcA8quzwCZPoDuND2ZKrEPG3cNc5WL66x8TnDz
         X3n9/m3oEwJdEsUO8F/F09zl0u5mIZfcE03B5B6/YHGTPvASvajPxjswhmDSQTTHTA6N
         0mtZ61/k7TBQKNGaphESxiMQZ/aBRtZiXnGWes2ww5qICvOf5/phIOdDuyOvdkBmlgdH
         OCk83sIChv79WX9HpWGlCv6RhOxGnHRe0OCnfX2nRhsQku8Obzri87zDK9YWwax6DQ5+
         SbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=8AfYD4SPmxQvIuUt9XI/GcV9rz3zOpiWf2MVLvb6oec=;
        b=qkRF24AJOEJpl8n5XxZ6HkQAdMmgwq6FOH1Te0O50XJmQakwktVyw4uBMelqhTQQmv
         c9/Ldpc1pG4egtbe89dCAoUPMShR+3a2ObyEKRIIhaKxrlCL1ZGms7KkVKoyGLHUvTuE
         7bLik+y0xpU/vHI2ddBwJFfXgaRuswCvVMlSOfttBi0Q4c7Xb8ofNrgRw40BZ9vjp6j/
         b01Lj/sIMcJcG2bYKY3NEA+qbmJzSjRUZC2duBAqTRLvbsyrcLHwz60etM5WNYmLKBXY
         3oWN5KQ6Z4kQhMbYtwnaCiDPagOwLO4dM/0ub/sRv9381O68G4BJKYzxrYTA6Ei3Vmp4
         g7yA==
X-Gm-Message-State: AJIora9scXj2c9kXj+ywwqje1747JacAqG73tQOxGCOJjkmOwyKl+YcF
        73suKA9DySWHkfn1eo/voAipdGDFbakWLg==
X-Google-Smtp-Source: AGRyM1vVkWdF7KXfexM/l4bmnWtd+MS3F3KdHk7FeyprZzMlq3cFY+cH2SqeFPAi3m+vO8RdUcO6yQ==
X-Received: by 2002:a17:90b:464b:b0:1e8:7881:b238 with SMTP id jw11-20020a17090b464b00b001e87881b238mr21223495pjb.166.1655465841562;
        Fri, 17 Jun 2022 04:37:21 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u8-20020a62d448000000b00518285976cdsm3602889pfl.9.2022.06.17.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 04:37:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org
Cc:     jack@suse.cz, hch@lst.de, linux-block@vger.kernel.org,
        cixi.geng1@unisoc.com, yukuai3@huawei.com, paolo.valente@unimore.it
In-Reply-To: <20220613163234.3593026-1-bvanassche@acm.org>
References: <20220613163234.3593026-1-bvanassche@acm.org>
Subject: Re: [PATCH] block/bfq: Enable I/O statistics
Message-Id: <165546584015.253422.5581899388403551608.b4-ty@kernel.dk>
Date:   Fri, 17 Jun 2022 05:37:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 13 Jun 2022 09:32:34 -0700, Bart Van Assche wrote:
> BFQ uses io_start_time_ns. That member variable is only set if I/O
> statistics are enabled. Hence this patch that enables I/O statistics
> at the time BFQ is associated with a request queue.
> 
> Compile-tested only.
> 
> 
> [...]

Applied, thanks!

[1/1] block/bfq: Enable I/O statistics
      (no commit info)

Best regards,
-- 
Jens Axboe


