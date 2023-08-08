Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA1FC001E0
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 21:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjHHVqx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjHHVqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 17:46:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD821BEA
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 14:46:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bb91c20602so12673405ad.0
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691531211; x=1692136011;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVvoOD3a42GY8Ebmz0RgOSN9u//C9LOSXpl4Qlkoi1A=;
        b=vwzjw4SdDejKeetWZRaBDTicu9grb6ugVg7T8YnuZUbdMLc9dfk1EMR28ENeqt+GpF
         5Rftbu+6VKu4oW+ZTSpphTvNyOs4WfBzS8pdunUrA1UR90wPfLYwrUUpwfE+3LXAJPZi
         //6RRyqPEptBY+xWLXIGTNZlhPmvBI0xPp6Ep7MQ+0r9HOZxa9TrayL3wT56TrFxqpC7
         HIhArHuxT/LqzgRoWWDriK7Xhw47A+R8jvgfLMe44CV+MAQ05uet7T/RxO58soSzeFPY
         gI/ZdmtovekPQBX/fxueb59ytj+PV2hGQJMaanSIemuwCUQAiS8sBVPeKddRIzQVpBFr
         zzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531211; x=1692136011;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVvoOD3a42GY8Ebmz0RgOSN9u//C9LOSXpl4Qlkoi1A=;
        b=CGdxkfHPAiYdAbhPCpJCHjYJsY19j0h7Aspf0vqbS232nw0erhjkNuI1QukH0bNSl7
         H0/qhdDxZu5dcMoVXK63es1mgHv++DV7o0s9bw7WHANXSx0/EGDaSL0op8uEZ2IhwR9B
         ugPLdkHy/6lT4w4Tb7rM2wUCjh4Q2niGePWEIFfPz7Mg61WwlXS1Fgi2B+y8wrgROkT/
         2eiowNXiAy9PTNgZtAG/jnx9pXPhOJy8xqknEoY8jcBvV9S/hDrYg1znG00pTA9hczHI
         UmQG8UMKzUpOzU/btKMFcc5so8T+4wvTa6y74xdxvWzDaT7Mmhrxu4vYltJR+ho5yKqd
         SXIA==
X-Gm-Message-State: AOJu0Yx4VnR7/6oQPC7GQmlzKoF3FQ8MEB0t2gcKH0SY4TXBkSiBXJgG
        sV/eKQdBtu9xMSavAnKbIHks3Q==
X-Google-Smtp-Source: AGHT+IEBaw5bcF1S5gfk8OAPjNSNb32ZmPfHsUgxSa1VUvAiECqC/ErJwgsi0eVABsUaVuyoaxnLWw==
X-Received: by 2002:a17:902:d2c2:b0:1bb:83ec:832 with SMTP id n2-20020a170902d2c200b001bb83ec0832mr1035725plc.2.1691531211359;
        Tue, 08 Aug 2023 14:46:51 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709026b8900b001b9da8b4eb7sm9476577plk.35.2023.08.08.14.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:46:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org, Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        niuzhiguo84@gmail.com, hongyu.jin@unisoc.com,
        yunlong.xing@unisoc.com
In-Reply-To: <1691061162-22898-1-git-send-email-zhiguo.niu@unisoc.com>
References: <1691061162-22898-1-git-send-email-zhiguo.niu@unisoc.com>
Subject: Re: [PATCH] block/mq-deadline: use correct way to throttling write
 requests
Message-Id: <169153121035.141127.745815954316396191.b4-ty@kernel.dk>
Date:   Tue, 08 Aug 2023 15:46:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 03 Aug 2023 19:12:42 +0800, Zhiguo Niu wrote:
> The original formula was inaccurate:
> dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
> 
> For write requests, when we assign a tags from sched_tags,
> data->shallow_depth will be passed to sbitmap_find_bit,
> see the following code:
> 
> [...]

Applied, thanks!

[1/1] block/mq-deadline: use correct way to throttling write requests
      commit: d47f9717e5cfd0dd8c0ba2ecfa47c38d140f1bb6

Best regards,
-- 
Jens Axboe



