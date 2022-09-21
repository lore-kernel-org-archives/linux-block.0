Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EBAC6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 14:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiIUOhJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiIUOhI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 10:37:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F4F8F94D
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 07:37:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h194so5184591iof.4
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=mKufYrI9efEtcSEmkR69hsileKiw0XznPKLOMsSFNOQ=;
        b=bV1KrNrGuDRIxBmli31Li8aw2Xq1hNxwCyw5zOffRPCukM/5caXwEUOQkdVNLF6yoR
         lDp2BdTW1hd3RDm4lyLdPiR/1SdkbpZNsbMhALrcyO+3IHsS0d0CIbFv9K1lELU7+FpD
         pja+JAPgJAsr7Eq5DJwOBxn1VRyFWaoQ+Wo4OopVheRi4MKGFJmozNtYdcKD+ur0JqiL
         pY6jkdZWYz+BJBYmYIkRn98EIVD6oYf2X+n+FsTjkqwQBfOGDyIsEm7Q2oL11uNpW9k3
         Fjaf+zU1MrTkF58N/fzE2MYrmxeURZZwJGB/OU/3paelXRLsISpFGgJs8jrmkMo4nhOk
         trjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mKufYrI9efEtcSEmkR69hsileKiw0XznPKLOMsSFNOQ=;
        b=SF0hH7Kw4HQYLC1HGeha3RXh4ZZDAp44MFxOH2eZx4cEcqFwlXk9teW4mETW2fqLj4
         QdUvx39iNEpLgQenVp528r0zr251iJBANczNht0oq+fWQ+CvIQx58Uu76HPfraZ2EsrC
         472UUvUVKXm9vh/F6FSDtneEuZuCkeKF3zNtxb/nhKfm8rBk2PoQ7aG+OReyqp6aslJG
         fno/PWxjkbnVClz0wUI15eHRHSfbr6hVkZBHsJ5aO6aclPsrIIkPFXQILL1GnLRT7ptf
         2tHWhRw6iphn7I4/m1LtjYI1qAP/jFbdIRcwncGZ6m2RzezD6V7udyHTbyKoqg6mV4nR
         kuUQ==
X-Gm-Message-State: ACgBeo2JWgbcudpq0eyDWgjI6voj7TGFV0y4T5GAXk1PWs7L8Rb8Zv14
        5ZS0VV2/cZBuifC3+Y6uvLKeoQ==
X-Google-Smtp-Source: AMsMyM43cpGD7HJYtchyGbr3NH4yqKIXCC7/JYBY/qJSVfFh3Yn1mhcB3lwOOrmS25Yi/qVEOReUNQ==
X-Received: by 2002:a05:6638:1683:b0:35a:4772:edc2 with SMTP id f3-20020a056638168300b0035a4772edc2mr13203929jat.128.1663771026732;
        Wed, 21 Sep 2022 07:37:06 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p27-20020a02781b000000b00356c40e75a5sm1104452jac.54.2022.09.21.07.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 07:37:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220909131509.3263924-1-hch@lst.de>
References: <20220909131509.3263924-1-hch@lst.de>
Subject: Re: rnbd cleanups v2
Message-Id: <166377102584.42852.14912801048047707112.b4-ty@kernel.dk>
Date:   Wed, 21 Sep 2022 08:37:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 9 Sep 2022 15:15:05 +0200, Christoph Hellwig wrote:
> this series has a few simple rnbd cleanups.
> 
> Changes since v1:
>  - rebased over a trivial cleanup in removed code that got merged into
>    the block tree
> 
> Diffstat:
>  b/drivers/block/rnbd/Makefile     |    1
>  b/drivers/block/rnbd/rnbd-srv.c   |   92 +++++++++++++++-----------------------
>  b/drivers/block/rnbd/rnbd-srv.h   |    2
>  drivers/block/rnbd/rnbd-srv-dev.c |   42 -----------------
>  drivers/block/rnbd/rnbd-srv-dev.h |   64 --------------------------
>  5 files changed, 39 insertions(+), 162 deletions(-)
> 
> [...]

Applied, thanks!

[1/4] rnbd-srv: simplify rnbd_srv_fill_msg_open_rsp
      commit: 9ad1532060d9bfa734cc22517e41683eb9726daa
[2/4] rnbd-srv: remove rnbd_endio
      commit: 2ecaa58104c7f9d58a818ddab7e14ee021e66553
[3/4] rnbd-srv: remove rnbd_dev_{open,close}
      commit: 6856b194b29f066b2d6d9e10b91ca1a4c9d8fbb2
[4/4] rnbd-srv: remove struct rnbd_dev
      commit: f7de4886fe8f008ac4f7beeacd9bedb6b91241f5

Best regards,
-- 
Jens Axboe


