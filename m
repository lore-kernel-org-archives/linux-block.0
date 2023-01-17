Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A30AC54E76
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 17:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjAQRzx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjAQRwu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 12:52:50 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908E4E534
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:42:17 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m7so3199896ilh.7
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzwF5BzfZiEwMc8JLNxN1UV7FuteYj/Hj6+tT0FWNZA=;
        b=Vuatbj30pmN4rjk20ihgJ7Zg9SqQwFKjf3Ujz+Q7VpE7HeLb/KBgCBd8p3qZ4GC3F/
         VAcMZ3aKsiXUTgwRtRdAJJh4rxhrWKNk7aSIM/04CQCeuZjHLknYqug9vDT5enw/ZVgX
         JF9gPzKnmWS7ksJJ042s0osBMwj9tQXZW3gutFtj9oBGDFrFnm/NUogZsSNvvMFRWuRM
         e/9j3up6T0QxyP0gr4E179qV30bXOwnhwbyibx867PYPMrKvULntAxSxXRZ9ar5LYyiH
         91Ht/+hQ0WlBPeySnjFhFiBN2sIPSeqEPBHJ+Sk4Jiiu/0ZSOS/T3YJrjn4pem5+umfl
         j/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzwF5BzfZiEwMc8JLNxN1UV7FuteYj/Hj6+tT0FWNZA=;
        b=DL8FtsjjKIxGXKtHQHaRgKtW0W1GyCqsFmARV2z8iDOTgOI906FvM8Q3yigoJjwJFi
         351tchAxGL9QCkGPEd/Hh4Cs1B5EuNwvEXEJcL9Puz0zqXzOjAKrjtVE/g/2hZ0N6yKZ
         F1DzboyrvsysfXAR97c8NPliEAeFdVdSXfxqNYynuZ94wf5d5LhieR5+zWE0NjRiAFqv
         EWAy5SmwRVM/ON/MRd6vIjjbv/WTUpnglkhS+Dk2yM4yPfIch08vE4KQihbN8Z6TklP0
         TSlKBW4VLEvOmzfcw6JsocXmFimzlG+qrwCnIQ0cUvF1JdBR7l/Cc88v+VFEB61k7wbH
         03fw==
X-Gm-Message-State: AFqh2kqQ7fCDg8f+UILrYOnrmEvJv9rfZtaR1RcilglI6S5B8OL/MwvX
        uGuBwmKU6/IGZHx2TBIfbYRqdQ==
X-Google-Smtp-Source: AMrXdXsl9aUQNyQY9A36xgDC1oRBAbg4qdu4YRmacmjQXY6rAMn83tdIyxJlvjLYVCB9d4oevmnOMw==
X-Received: by 2002:a92:d342:0:b0:30b:c9ec:fc23 with SMTP id a2-20020a92d342000000b0030bc9ecfc23mr744371ilh.2.1673977336475;
        Tue, 17 Jan 2023 09:42:16 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o36-20020a027424000000b0038a13e116a1sm9670735jac.61.2023.01.17.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:42:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com, snitzer@kernel.org
In-Reply-To: <20230110143635.77300-1-p.raghav@samsung.com>
References: <CGME20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2@eucas1p1.samsung.com>
 <20230110143635.77300-1-p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/3] block zoned cleanups
Message-Id: <167397733558.19825.2181123982002401602.b4-ty@kernel.dk>
Date:   Tue, 17 Jan 2023 10:42:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 10 Jan 2023 15:36:32 +0100, Pankaj Raghav wrote:
>   It is still unclear whether the support for non-po2 zone size devices
>   will be added anytime soon [1]. I have extracted out the cleanup
>   patches that doesn't do any functional change but improves the
>   readability by adding helpers. This also helps a bit to
>   maintain off-tree support as there is an interest to have this feature
>   in some companies.
> 
> [...]

Applied, thanks!

[1/3] block: remove superfluous check for request queue in bdev_is_zoned()
      commit: ef0e0afd782eff20d4bd0c145c647fa01aa16bb1
[2/3] block: add a new helper bdev_{is_zone_start, offset_from_zone_start}
      commit: 3b1c494c4317777da0c5a96b002f954583611345
[3/3] block: introduce bdev_zone_no helper
      commit: 803e2ec47623e5625dd3f5808c175b49f92da9d0

Best regards,
-- 
Jens Axboe



