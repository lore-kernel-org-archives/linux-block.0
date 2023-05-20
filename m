Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2439EC77B7A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 11:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjETLiv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 07:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjETLiu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 07:38:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C56DC
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 04:38:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d28c9696cso574838b3a.1
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684582728; x=1687174728;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaflJFLNdzn3ywJbH+hnjHuddxhAIuiH/nVu90LT80c=;
        b=Id21j1hi7ZDHMStkesDaiuSv+xMwE53FpDmGINmcA4cXO+Ogh4AnAGvNHM8Ski4SQs
         DQUfklils5ez6A85VTNupa8LcVj+zYK/wCwf2uA4wAinTN9MUNvxAXbuIVlUtMeMgisu
         CYHcJZTCWTZLYL5gsCkj0vfy7B8iM11foIXnrgZQ5Ot719hOrjiHrAkdB5p6xCUVL1M8
         TrDqBRxjxNU7Txcfy3vML/9zyc4HgEtmoFPBThOJ8qioilEIyN/Z9UxHZ+F/Wmlksuky
         dAVGftPIhHqu5ux8hpj+GpNtqq+YHdcVqmFlcuAWioUNBU+j2v8qgAo1eoKiMyFmU6/q
         6jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684582728; x=1687174728;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaflJFLNdzn3ywJbH+hnjHuddxhAIuiH/nVu90LT80c=;
        b=LX0Zc5sCyE8hr0ciKArKZpyHbqooRcUrftelxpho9fqAB9mlqF2PIiyI4wDPERmY4T
         /bQ5ZSuhxfrCxbVlYjDyQSS1iwobYeqMN5nFfZGO7oIcPsOn8Lvw8SfnlHSUakc1WnJj
         16LRPBl/IXpErGWH/fnkOPrYZg/SZc+gahffLkYnCdMlUg9C32jeESJV2G5IS3tB1Gzu
         a9k143vfO1qkHzBHGS2DRPO42G6BE2oEgDVWMdKFqpj0m77Ar/k3otM1s5CLGwYRhby2
         q24aUipIFfLAXYbBWmDHB3e9fkSD2XLUGvSsv0WvlvLlB5u5ZZV33/UHiRFcgNKT2HbG
         x50g==
X-Gm-Message-State: AC+VfDwzangrZDRvEIj1bTDxq8Nom4hgXKfSfprno3RFshQP+ap4kYoj
        PrdEWEVNKcplISgPQ7Ib9Q8T4788/dHasRqsou8=
X-Google-Smtp-Source: ACHHUZ6lkYXM4JVn8wNZisOOnkacIWEDuNFUhLQHSgqRBDfYJX0ArNhZ9hkinxaV8eaStRreY/KJwQ==
X-Received: by 2002:a17:903:2343:b0:1a1:956d:2281 with SMTP id c3-20020a170903234300b001a1956d2281mr6144909plh.3.1684582728493;
        Sat, 20 May 2023 04:38:48 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d70600b001a6a53c3b04sm1284468ply.306.2023.05.20.04.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 04:38:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230520090010.527046-1-hch@lst.de>
References: <20230520090010.527046-1-hch@lst.de>
Subject: Re: [PATCH] block: remove NFL4_UFLG_MASK
Message-Id: <168458272736.538009.11197962529943582433.b4-ty@kernel.dk>
Date:   Sat, 20 May 2023 05:38:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 20 May 2023 11:00:10 +0200, Christoph Hellwig wrote:
> The NFL4_UFLG_MASK define slipped in in commit 9208d4149758
> ("block: add a ->get_unique_id method") and should never have been
> added, as NFSD as the only user of it already has it's copy.
> 
> 

Applied, thanks!

[1/1] block: remove NFL4_UFLG_MASK
      commit: e3afec91aad23c52dfe426c7d7128e4839c3eed8

Best regards,
-- 
Jens Axboe



