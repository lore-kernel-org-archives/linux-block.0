Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DE9EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 01:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGMBnO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jul 2023 21:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGMBnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2023 21:43:14 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4FF1FC9
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 18:43:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b898cfa6a1so357145ad.1
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 18:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689212592; x=1689817392;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGT0tKKHMMw4Wl9tT/nwV3u2hoHFKfnsdNNPLl4wC68=;
        b=qQpqFerGWuXSvt+8poH6Xx3xZMcHUkj4wJo3BILsU9QLzzRklIFcFH5FS7smL1npcT
         avGOo+/S00y6RgopLKTu5ihLy4ftcFNFNKQivsPJCU2Jt7fmf3ZUpkeqTKW0OJ2NSzvp
         sduGFy2UCMONJvaxCLw0eMJ6vII7TXOQrHtExV216Gsn9nwk2BwQACse3eScktfjZT35
         dcr8NXqvH/TZ8GyhdD+wjqMmdjceA0aJ7Bia+O2lwstaS+0ynX3l7Dl4mWYXrIsDP8Fl
         CqbRq/zCWqRp1mdqe2jf39HcP2YTfL+oFQyXBgVp8fl7BoZEXNlzP80MZdQDSPcD8ZrS
         CcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689212592; x=1689817392;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGT0tKKHMMw4Wl9tT/nwV3u2hoHFKfnsdNNPLl4wC68=;
        b=DMCtg6UNtsqLPSTLhT+2x3P9LnsGnGZvTx/w+pdZHq1DGXL1saAahXZmM6CuzDS4vg
         LoxR5ce1qC5vlMq0WFgDzaGLliPq67Fvkwnk0KhIULnenwbepOPWBzTXFdF800iDwyJN
         8BtXECVWE6gzUoGyCUOnXP06j+KZV+ZHwsnR6xLGzaKVRp5+qMQ1GhOlVQ72prtjTRvz
         VrG/LVT/hOoGeD2D0OMW1sdaW15J/zF3Cef6KoEUB9UNwsbwyTe+B8GjR+rL/8xX8ouS
         R7JLvZD4AzSUtoOvWuG1irwzdzdkiQ+V3mBDT7tDY+qprnCB3bYIQ31vd/H5IBS0SL2o
         ysrA==
X-Gm-Message-State: ABy/qLYOnS5MhRwDH8GZLFnNRAkIF6uE/JdLpADjz3HgcrfqoSpzJ6nV
        z2Gl3svDc/VA05ZIZkiYfH4slIlkwtWNgWHHXfs=
X-Google-Smtp-Source: APBJJlEHzBlIBzCEVlM1rGx5IzuKFQcplBDRTogMCp/5EGZIKWLW/W9FlpXcoZDmIOSAGw8MqoYbXg==
X-Received: by 2002:a17:902:ce84:b0:1b3:ec39:f42c with SMTP id f4-20020a170902ce8400b001b3ec39f42cmr391255plg.5.1689212592339;
        Wed, 12 Jul 2023 18:43:12 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902b09000b001b8422f1000sm4617080plr.201.2023.07.12.18.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 18:43:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230712173344.2994513-1-bvanassche@acm.org>
References: <20230712173344.2994513-1-bvanassche@acm.org>
Subject: Re: [PATCH] block/mq-deadline: Fix a bug in deadline_from_pos()
Message-Id: <168921259077.435341.4877413237858137000.b4-ty@kernel.dk>
Date:   Wed, 12 Jul 2023 19:43:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 12 Jul 2023 10:33:43 -0700, Bart Van Assche wrote:
> A bug was introduced in deadline_from_pos() while implementing the
> suggestion to use round_down() in the following code:
> 
> 	pos -= bdev_offset_from_zone_start(rq->q->disk->part0, pos);
> 
> This patch makes deadline_from_pos() use round_down() such that 'pos' is
> rounded down.
> 
> [...]

Applied, thanks!

[1/1] block/mq-deadline: Fix a bug in deadline_from_pos()
      (no commit info)

Best regards,
-- 
Jens Axboe



