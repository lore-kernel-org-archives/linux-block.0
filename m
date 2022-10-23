Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C9C04A95
	for <linux-block@archiver.kernel.org>; Sun, 23 Oct 2022 03:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJWDFz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Oct 2022 23:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJWDFf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Oct 2022 23:05:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B293337F
        for <linux-block@vger.kernel.org>; Sat, 22 Oct 2022 20:05:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d24so5729923pls.4
        for <linux-block@vger.kernel.org>; Sat, 22 Oct 2022 20:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6nyt/5u3IthVwqu/EgKeaaSGqRzZm+NuwSgy/ByAnQ=;
        b=BQUulmnWAODhNl7IA8u3VpgVN/eggkKKzao910c4xLqJyB1jyq3BkcP9Ryiu67ivCZ
         Jzct/LQ8D7M3jPRzoEobMLF8xfouzgb8q11+Zgv34VHFD/0hNtdq6sU6v2niN3KXK/Av
         jXrkGqfUrVytCyFRrgNCVMcdcrtTWHfUBiit6JT6ipoYlTiUDYlySC2D5LmM5ioYc3+d
         9YrpW/evtcVC2OSL1XgZrnMS40hX7acs2R+XZi57a8Hwa9asJAsg2gwUeC+ST5iyyicS
         eBYGVa3zeuoMapdqHweTVrWhwvmRkRtOuftu4pob2hHKm/JqXQXBFLxXU36hvcaK3MWm
         O6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6nyt/5u3IthVwqu/EgKeaaSGqRzZm+NuwSgy/ByAnQ=;
        b=BM6qoi51X9S4xLdGqmJgVYM3gHr7jjWWeRWf4FCZFRhcZ3OZQp5+ZFIqCTqvyL9HlB
         qVBhfyWPbuxAPoB/N3M5W7KbSUDsbv9h3kpRN8PWLtQivD8uwFWz2HEVsEUuVaA5Yesc
         WF30+nTYBuveMrW8nJq9l/+BqdwneM2DF03rXzR8oA8yBmH9P8CJJjimu2LZDiQNjn8R
         0kpNGCftvaWlz6XBoYtBNoEnaROB/N20tjkytnGZfQZVC50c9Qz7YhylW79yDBD/bOcq
         WjzgenzMgtN8VdJnpZAeyImXy09ssdlKF81Yqrv62n4VFrxFcuwJCz7B2+4AcHyi5mU7
         mp5Q==
X-Gm-Message-State: ACrzQf1NBf/ehb+z/GOqba4thqzwAtQnPP9f6FfBbjB/4jxYn8hRfIqg
        zzjgzKdali1B7h9qB/1OhK60fw==
X-Google-Smtp-Source: AMsMyM6DbCJC9squZcIC4uX4gg58vyChOuuUTQMv6f2ZPJCe2aV035QMTQ9J9WwAhOdH+VLBdHdE5A==
X-Received: by 2002:a17:902:e9cc:b0:186:8816:88d4 with SMTP id 12-20020a170902e9cc00b00186881688d4mr7042387plk.59.1666494309309;
        Sat, 22 Oct 2022 20:05:09 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090a859300b001f8c532b93dsm3793321pjn.15.2022.10.22.20.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 20:05:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Jinlong Chen <nickyc975@zju.edu.cn>
In-Reply-To: <20221020064819.1469928-1-hch@lst.de>
References: <20221020064819.1469928-1-hch@lst.de>
Subject: Re: elevator refcount fixes
Message-Id: <166649430855.43600.8976048007637469347.b4-ty@kernel.dk>
Date:   Sat, 22 Oct 2022 21:05:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 20 Oct 2022 08:48:15 +0200, Christoph Hellwig wrote:
> this series is a take on the elevator refcount fixes from Jinlong.
> I've added a cleanup patch, and one that improves on one of the incidental
> fixes he did, as well as splitting the main patch into two and improving
> some comments.
> 
> Diffstat:
>  blk-mq-sched.c |    1 +
>  blk-mq.c       |   13 ++++---------
>  elevator.c     |   43 +++++++++++++++++++------------------------
>  elevator.h     |   15 +++++++++++++++
>  4 files changed, 39 insertions(+), 33 deletions(-)
> 
> [...]

Applied, thanks!

[1/4] block: add proper helpers for elevator_type module refcount management
      commit: 61e1f359c2bc78360cf9741959918934d9362aa5
[2/4] block: sanitize the elevator name before passing it to __elevator_change
      commit: d1368d8c074010b221be1e5474e0d318567bbec7
[3/4] block: check for an unchanged elevator earlier in __elevator_change
      commit: ffd37387225f6ccd47765dc33fc56db14a7a8487
[4/4] block: fix up elevator_type refcounting
      commit: bcd3010074ec9dc1bd65c210a2ec3815dc653340

Best regards,
-- 
Jens Axboe


