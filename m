Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C248AC4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 12:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiJTMrg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJTMre (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 08:47:34 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351C618B091
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 05:47:33 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so19116892pgb.4
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puPrUXZK0sU2nL/Dv5W0joxWJT4bAL8pPriVwGk3Wbg=;
        b=JTLNeaBJ9BU2HAKbhIriPxN7ME+Ztp20XUO4VooC0vV+9vUoAoWvfpopmZZHJVoa9P
         d0plpmcIv91CQF5bgQQel8l55bJjdtC4D5amwT6sWW+UlidZkTQ5Yw6kapRll9XntNax
         DHlm+7qi46CM+9W2CB6UGqqWzarVxicTSxU9ZIuYyRFvWSB2Sk2UAMNoMLmu/fWYWNL4
         ILMlGroW/iFE4YrL9l4PrjL0O77MrWROeJeQytgJwfCVwpRSPb1kNzt2E1kNGRgWXSWb
         JpmfmCGy7Zs+P7TV7u13hhUyn4ptlXshAnY6iXfMVzrqE+np9MPOUF7S54Nyg6IuhPXe
         4o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puPrUXZK0sU2nL/Dv5W0joxWJT4bAL8pPriVwGk3Wbg=;
        b=l6lMJZOpfvBwQRo2X5nx1/o9j5EfxC9ICU9Obd5nWAa07v7ngb/1sLMMewXnQUKQmz
         kZFmVAHYGKzf+tV69btj2Q5w7S8Ds1HZMibj1PoDqdt1gKbYZ7NUwYhe/kW7w6ZA0wgR
         /h/o9v9/nWYTxTRKOIAyA8jpqTuDiu5AAtjfQ6LDnKK1ZSMqgKTpy9pPHEO3z2qfFaz3
         BZbPEbUpuH3YvzGl9D+yc4i5EylvCf5iM85++Z5dXWOgKdt8oK2zzyjODWiVdCaw+0HL
         L1qvXvi+mRv2y8Vezi6RrGSmY1QA+mqvwJ5+8L2QLe1L3b9UpW+g8x6gANMqb3Sk00ea
         7xnA==
X-Gm-Message-State: ACrzQf1kIPnTggF8yO5FyFpYz3KKuqlGmxlZH+DbS/uNFpWt7gjd640v
        +wtnd+jItrepl5VepxxY4IA54Q==
X-Google-Smtp-Source: AMsMyM76/lj6+QAOB8gUCoxo0XMSw8YQQEYhAHX6BidP3Tl0NBlXJswP4vJMdhg+Sci4wE/osjNKVw==
X-Received: by 2002:aa7:8011:0:b0:567:70cc:5b78 with SMTP id j17-20020aa78011000000b0056770cc5b78mr9768392pfi.29.1666270052667;
        Thu, 20 Oct 2022 05:47:32 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902768c00b00176675adbe1sm2035164pll.208.2022.10.20.05.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:47:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yuwei Guan <ssawgyw@gmail.com>, paolo.valente@linaro.org
Cc:     Yuwei.Guan@zeekrlife.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221018030139.159-1-Yuwei.Guan@zeekrlife.com>
References: <20221018030139.159-1-Yuwei.Guan@zeekrlife.com>
Subject: Re: [RESEND PATCH] block, bfq: remove unused variable for bfq_queue
Message-Id: <166627005112.161439.5489216534046304449.b4-ty@kernel.dk>
Date:   Thu, 20 Oct 2022 05:47:31 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 18 Oct 2022 11:01:39 +0800, Yuwei Guan wrote:
> it defined in d0edc2473be9d, but there's nowhere to use it,
> so remove it.
> 
> 

Applied, thanks!

[1/1] block, bfq: remove unused variable for bfq_queue
      commit: 33566f92cd5f1c1d462920978f6dc102c744270d

Best regards,
-- 
Jens Axboe


