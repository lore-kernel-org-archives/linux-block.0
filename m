Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73FAC7EE23
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 02:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjETCEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 22:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjETCEe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 22:04:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AFE19A
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 19:04:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25377d67da9so375956a91.0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 19:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684548273; x=1687140273;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/68K125lL9bL6WoCflMYlZZAQ8g+ToodCpfnpsletxs=;
        b=hSyhyQT3VQWydfe220/ybylHfiai3qGPV21Ik6K+BriBlZqFsWS5PjjSY8OpxgSHMX
         WHiHLh0ygIgnWVbVY/SrzjFN+dJ4qFvRDDdeMsI2Qrgjq/O7vgyy/vLf6MIOtmwOzRL3
         86N/zvYDw7IqnfsXm3cVLq0qlEYfyThFL6k5CS6wnss9/Mz4DjNBz7Xpnpsaff0JVuHF
         BCDc5ucPXGZwbXIFpxVDy88xKbrO/v9fJyx9yJqQ1AOLwTrufCtOsSVSEa40EmPjdGUU
         BjBradWp/YDmzMYO7ims2sGzRmVjXNmafa33C/+JFGAbgmZBq08711LYn6e+ZAWSmMr4
         glIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684548273; x=1687140273;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/68K125lL9bL6WoCflMYlZZAQ8g+ToodCpfnpsletxs=;
        b=iC5gYae3yJ6xiXrK6iImtxxngREiigftSSfQGwTPoHhklaLp//EPgj0FE0K4nAG5dF
         hlfGg/Qkq9A5gwhFXwTPt7rJ81VsoYzysYVNTKWLqy4tXHhmdrfChaFoRstvsJAwy3ky
         0MVsVYPhyKSsP4wIf1P45dEFvZqfwjs91s0bMPRjPpG1jX9EzmH4KQAA5uPGdNi5bVjL
         Rmij7QW+wzxj0Is8Ojo4uEk2KYfu6uDJPJenq3ruvBIkzz/LgP+d1Gfe/4rkJMwHuCTX
         rM/5JdMDn6Y4FiPr9KYlgrB1BA1RN2oVXBDmZJUs43yjTmH9jsFdpVdQSxTQ+cPhXiCl
         wqGg==
X-Gm-Message-State: AC+VfDzVJIJo6rvoUm5sMrphl8WTLCaI4UOIbNpJUZ0isvSt3sgO3Co5
        QIrqPbIeNEu8a2wN/hxqgsMwkQ==
X-Google-Smtp-Source: ACHHUZ4Fj3rPDDvTWnKx7wNVhIGlt2K1y2RNH9G2g0gKow+KI+PFuyo/vA+9UHVxm0eI6EPzAwi1tg==
X-Received: by 2002:a17:903:32c8:b0:1ac:85e9:3c9c with SMTP id i8-20020a17090332c800b001ac85e93c9cmr4875551plr.1.1684548273109;
        Fri, 19 May 2023 19:04:33 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001ac706dd98bsm298922plg.35.2023.05.19.19.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 19:04:32 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20230519220347.3643295-1-bvanassche@acm.org>
References: <20230519220347.3643295-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: BFQ: Move an invariant check
Message-Id: <168454827163.386102.12050969555699630994.b4-ty@kernel.dk>
Date:   Fri, 19 May 2023 20:04:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 19 May 2023 15:03:46 -0700, Bart Van Assche wrote:
> Check bfqq->dispatched for each BFQ queue instead of checking it for an
> invalid bfqq pointer.
> 
> 

Applied, thanks!

[1/1] block: BFQ: Move an invariant check
      (no commit info)

Best regards,
-- 
Jens Axboe



