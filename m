Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3ADC4332F
	for <linux-block@archiver.kernel.org>; Thu, 15 Dec 2022 12:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLOMZz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Dec 2022 07:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiLOMZ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2022 07:25:29 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315B713F3F
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2022 04:25:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so2572576pjp.1
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2022 04:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/73M0DNtQgyuRndF4NIlkV/I2VZcMXTamkSjavQvl4=;
        b=tTkPLj6burO+K8np9jfNiBbUJV8kRIFJc04mJVOm5hZwtD6XZpqTb7bvEv2ifBVAcq
         BzYtHyVFVbH1dcgI26YhLLqSP3BLIhsdoXs8TcZc3laRMxSKL2dXvWu5BVDBAwZ7Ddhk
         e6FQnIO8dmMQmius5D6e8u5NDk5E15cV3fVnGqeqlHNyKNznQ+TpvS3cv+HFitIbo96+
         LB+EnzpeASuwbGL+eQ30fgHXXX7w8PNj6YFtjYA77H3zfSOJPeOhyuqAouHocPJ88sDJ
         5OOKbmJACAYbazZ4W6N9L7R/s4KqUvBOPspuQtmalCGGIuiEdKINeZBt2C/bCDaFHwv6
         FhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/73M0DNtQgyuRndF4NIlkV/I2VZcMXTamkSjavQvl4=;
        b=CeUl7GDccf3Jl+tcY6i/XFrW6D6PXBe0cnwPHkBxD9wDJ5fmhJVjQEQerxS9MlYqpD
         9V/T/TWKtzL7Rinuur0GJwRYhCMaiT262qZ2H6hgooPSNTNFVY1OpXUfwSAbegUOyN6V
         rSOMI4MCtEboJeXJYKYrpdBRkYb2V9PRclLZKc642sL09UFRWLp3oBXUgBPiVxGZjl6l
         oA1eGwtP/8sONs4bxeps85uha8O6T6ZdvZOP1XIk/+rgNWJVtI0rDIJqr+j9A+RIBUfZ
         zzQdaQ65tJSs4UTm41YOK/iK+dO4jsetB97+PUaQXdAMPfEilvhqAhX73KGDVl9Ext0X
         HcFw==
X-Gm-Message-State: ANoB5pkUy5Oz1nn3nB410XyKWptjuDqiF7QiRsHlk06fxrSQFxAce+IL
        4pJT6VIkuFi6jKuKlNS8CiVgSQ==
X-Google-Smtp-Source: AA0mqf6QmQNVNKm4BgWY33J2vQjUiyC8U3MjZDRFbnbaB+N2WOi+0p6uv6jLFAXJGCU9hBdFo3bBWg==
X-Received: by 2002:a17:902:ea10:b0:189:b74f:46ad with SMTP id s16-20020a170902ea1000b00189b74f46admr8377919plg.3.1671107112581;
        Thu, 15 Dec 2022 04:25:12 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902bd9200b001868bf6a7b8sm3700999pls.146.2022.12.15.04.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 04:25:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Zhang Wensheng <zhangwensheng@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai3@huawei.com>,
        Dennis Zhou <dennis@kernel.org>
In-Reply-To: <20221215021629.74870-1-ming.lei@redhat.com>
References: <20221215021629.74870-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix use-after-free of q->q_usage_counter
Message-Id: <167110711134.47123.15435164400352739613.b4-ty@kernel.dk>
Date:   Thu, 15 Dec 2022 05:25:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 15 Dec 2022 10:16:29 +0800, Ming Lei wrote:
> For blk-mq, queue release handler is usually called into after
> blk_mq_freeze_queue_wait() returns. However, q_usage_counter->release()
> handler may not be started yet at that time, so cause user-after-free.
> 
> Fix the issue by moving percpu_ref_exit() into blk_free_queue_rcu()
> since ->release() is called with rcu read lock held, since it is
> concluded that the race should be covered in caller per discussion
> from the two links.
> 
> [...]

Applied, thanks!

[1/1] block: fix use-after-free of q->q_usage_counter
      commit: d36a9ea5e7766961e753ee38d4c331bbe6ef659b

Best regards,
-- 
Jens Axboe


