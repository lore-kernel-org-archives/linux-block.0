Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011C1C32771
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 01:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiIVBvU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 21:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiIVBvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 21:51:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD6DAB1AB
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 18:51:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fs14so8281683pjb.5
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 18:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=h4Kwmn7hqUwh3kMaZJNQWoMofGS1FvQqiYWd/u7nFxU=;
        b=BGvpEJ72iO04HRJwX3rugnN64sqyRJc0JPkQRatA9hDscWi81JvPCyu7u6e8oZI9PQ
         xLh8Hvldb7Uv7vIyzvUpp1nMVDpFnj1/423ErT+/RqgxvUmYrN8ziptaE4XAseSt2Ppn
         coKR3X67KheCk/ab+iLKqFms8LrkY/c3wGK5AQ2pMh8O4BX2ZScuqaU3hg23+7MF+N6O
         W18oHXUUnjioGCrnY6UWKQlobvm8g/5guw0rUNwmUCyC4pFzBAovpKB4nZLV4H1/oMvE
         z3qkONH81esETJfzVD844k+v5Pho0JaROljiCmXDDXN/p+j0QiECXSlBGLIEPQojuFZD
         88Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=h4Kwmn7hqUwh3kMaZJNQWoMofGS1FvQqiYWd/u7nFxU=;
        b=clPp5ipDFnd/or2HwPRteuagF0XNkATYwVz4OyvlGMO3orWxatIqs/xBaKWDt6uYaR
         MpS6MZiLmF5E0VsizJ2OQqfNV189edHMj4UR70AzdsJnlbEijqO2q9M1c4+gV8gIp46v
         bLJP4bztwu0LWFNpwhV5/x2sPnBGoD5GXKi8FMZl50y4leHTO2ME534dl5OuxxObSYUq
         jvnVfb+bRy4XX91LmVej3LwquDJJszHx4HzoFDrxo+mORe+V79urXrdIRbzxmwH5K2bB
         aAFoIzs54GMw1dtVdycIgw8PVv9jXzYUpQ1GRsGIpDIdu9lRKCF5LB2yai4y9MudkPKx
         vAZw==
X-Gm-Message-State: ACrzQf1MQWDY0QoBF10SIPfBe18U+JnDwf4aCjsmOhqxG2BrqO/qIsKJ
        w3Ih+eR7jWjQPaf5WKxMKAmg5v0tzB0XnQ==
X-Google-Smtp-Source: AMsMyM7BsrbAoYllEABjTpvMveOdZJXGgY0k0oovDDSXLpIHCBTt2Fo+4yCR/nBNSC4z8cJ05Nl7bw==
X-Received: by 2002:a17:902:ec90:b0:178:a0eb:bc7c with SMTP id x16-20020a170902ec9000b00178a0ebbc7cmr952842plg.78.1663811473508;
        Wed, 21 Sep 2022 18:51:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b005383988ec0fsm2846996pff.162.2022.09.21.18.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:51:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Li Jinlin <lijinlin3@huawei.com>
Cc:     linfeilong@huawei.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20220916023241.32926-1-lijinlin3@huawei.com>
References: <20220916023241.32926-1-lijinlin3@huawei.com>
Subject: Re: [PATCH] block/blk-rq-qos: delete useless enmu RQ_QOS_IOPRIO
Message-Id: <166381147269.41047.4484959473511395391.b4-ty@kernel.dk>
Date:   Wed, 21 Sep 2022 19:51:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 16 Sep 2022 10:32:41 +0800, Li Jinlin wrote:
> Since blk-ioprio handing was converted from a rqos policy to a direct call,
> RQ_QOS_IOPRIO is not used anymore, just delete it.
> 
> 

Applied, thanks!

[1/1] block/blk-rq-qos: delete useless enmu RQ_QOS_IOPRIO
      commit: 9713a67067897a9e372c52124f72f8e00b2e6031

Best regards,
-- 
Jens Axboe


