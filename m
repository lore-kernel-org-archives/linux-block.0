Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9443C43219
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 01:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiCIBOM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiCIBNe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 20:13:34 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7825015A202
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:57:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a5so881937pfv.2
        for <linux-block@vger.kernel.org>; Tue, 08 Mar 2022 16:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ibcGiXk54OeOBvZ0Vlw4BQsX8FRRv0YjF+xcJTv4Uo0=;
        b=UOTc77FA0Rwox8zdOgpA7CUmPD50ywbmTa3N19iM2XyrZc0FqA/+xYy8fE5+e4DRXy
         yd+3fLuYiRpEOWiV9e4oMomqLzYSnknSExKr48gq0Qphs5b+9WaY2yQhBBy1OAAH9x3o
         GkxSH/EWinYST+JcuJLsaiPQyYEBEkQb2hyfgdgu5BWjy3x4bEg4MfVlQ2Is5kGm/K23
         tSUg40/um9ETrFYQsYXJO00ly4fVZZAvnGtEmNUjWIhXmrukgMMqKuMaFkJI/I2/hvWU
         d8OhAw3iVZ00xgNVPWIWxNlO6VdB+mG3c7dhWgHRp+fBIJ21bQxKJ274+iCA7xJPbdDP
         su1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ibcGiXk54OeOBvZ0Vlw4BQsX8FRRv0YjF+xcJTv4Uo0=;
        b=dJMNTojse9sgUCILCKGVr39Q1NN2c5Nir/PYqzEoXuoWa6y28yILwlfDVaSRj/Uqun
         ktFI4GNUps4DSwAe6zIomPU1qlQtyXtQ3zTyRT/KH96KxaEwYCyx0+qgPrcDNj5oDY7h
         34UpGL6Pf0OKHXrKCQ8PnJ2JP1OfD3dPzg7U7HXHTHzvt9UKZ7bGqqYJE1M/nvoKvpH/
         dAHdqzbOtaKf3m/LGnqPCs4c4I8mZYfBm7W+vSHJNVAAfICqcdA4Guzho2JeWEAXm+e2
         V9rVahVWMlO7jQHZ7ZijYxsf78sx/wbPaih8iFflfWb8bP9q3x9JdDOGCX/w5pqwQRnL
         /sbQ==
X-Gm-Message-State: AOAM5316Ji7Ox/ABwNzG8yGNlZn2Y4hpAHYw4l5go/tF2r/KylebW/Sz
        9Vjhd+TA49XlgQ/plnxE938Q27aCXAssjnFh
X-Google-Smtp-Source: ABdhPJz+xKfxwokBKXnHLHFlCfMI5IKWjfXAWA5GZk+/gdwzZHhH4ItVropgdyfDbqnvnSgHwpfRLg==
X-Received: by 2002:aa7:9e07:0:b0:4f6:a7e3:1b57 with SMTP id y7-20020aa79e07000000b004f6a7e31b57mr20824465pfq.13.1646787462899;
        Tue, 08 Mar 2022 16:57:42 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id lb4-20020a17090b4a4400b001b9b20eabc4sm305044pjb.5.2022.03.08.16.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 16:57:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
In-Reply-To: <20220308073219.91173-1-ming.lei@redhat.com>
References: <20220308073219.91173-1-ming.lei@redhat.com>
Subject: Re: [PATCH V4 0/6] blk-mq: update_nr_hw_queues related improvement & bugfix
Message-Id: <164678746208.406543.6112092653609180672.b4-ty@kernel.dk>
Date:   Tue, 08 Mar 2022 17:57:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 8 Mar 2022 15:32:13 +0800, Ming Lei wrote:
> The 1st patch figures out correct numa node for each kind of hw queue.
> 
> The 2nd patch simplifies reallocation of q->queue_hw_ctx a bit.
> 
> The 3rd patch re-configures poll capability after queue map is changed.
> 
> The 4th patch changes mtip32xx to avoid to refer to q->queue_hw_ctx
> directly.
> 
> [...]

Applied, thanks!

[1/6] blk-mq: figure out correct numa node for hw queue
      commit: 4d805131abf219e0019715f1cf29763c613aae07
[2/6] blk-mq: simplify reallocation of hw ctxs a bit
      commit: 306f13ee16424805d602d427a66ea38078d473b0
[3/6] blk-mq: reconfigure poll after queue map is changed
      commit: 42ee3061293e206bc0f3a084feea1304c61c137a
[4/6] block: mtip32xx: don't touch q->queue_hw_ctx
      commit: de0328d3a253a339be14a80fe2a0256ec26867da
[5/6] blk-mq: prepare for implementing hctx table via xarray
      commit: 4f481208749a22d3570073e629dbc27d7d27c8da
[6/6] blk-mq: manage hctx map via xarray
      commit: 5b3d92d1f9ac5c21b19c90a16c4a1668827aa75b

Best regards,
-- 
Jens Axboe


