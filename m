Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD62EB64DD
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 17:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjFNRPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjFNRPJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 13:15:09 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5059D1BF0
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 10:15:08 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-77af9ee36d0so52305139f.0
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686762907; x=1689354907;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B26eBiSEO8OUhK8kpmF2mZpYPqAE55XIYMWNVoLAx3Q=;
        b=ElLhn6Vb6ONuH/yutGqRSu0BujuRvECftwA7kC+v3U5p8cI9B7BHt8sPFm/BkMq3tZ
         6XjPfdFsjXPyAoShZE+Osiv+ldN1nwOXeKOFR2BO8PqYOgZSLTzy6CMkcaZWPhIY2wFs
         ErcB1uFEtThSIv6jHwmhqkHhcV86rA5IYgaciFlzM9hyq+23TVqgcEcOlcbY53Du0E5F
         28Mg28TpN68OhQbulzBIznABi0RNr33khib7/hGrXBcuuJsYEyi0qoM8YOz16u8f2iEj
         o/td+WXtr0EhGLPQdIEK8OrFkdRqSk9L3evTJSdmlFfqj0NqwnoX3EuigxSB6nqZHpLH
         cTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686762907; x=1689354907;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B26eBiSEO8OUhK8kpmF2mZpYPqAE55XIYMWNVoLAx3Q=;
        b=LRM6OZ510/3VyV5x6nKCWH6jYpbumhPb9l60l0MkdHDnFTcV2XD1AnCAK/hkz48+DB
         LbBOfjaxGiEGWzxkT4dbQd9wnp/WxRKius7dpIfDpXsgfTapt+D4HLsfu9vQwXstoGYu
         OyAMAok2cL5WYSEAD5Lc/nPRLprm+SFCY7zDCjnM1MMPKs/Z27DPP0vmfGyeKmwDAk21
         6HkVrMSMf+QZulqyCX3toHGsOaeSw8mSBDrkFBHadIztg6aYFkcGLKRDShLiReXXrPSy
         0dUdMTgAIhZPKYrUaKkV4kgwvoPmoNlcIJ4dvSRZtlL81Sq814ChPvJgUXf73Xt0ir8w
         dS7g==
X-Gm-Message-State: AC+VfDzMaQFausfn4R9TLAPeOkyFxC5/NEsb8d3ORtqrb/OdX6gHM5IB
        2PeKX31gZ0yXDmiucdxpgmST2g==
X-Google-Smtp-Source: ACHHUZ6kZIXJ4WVd6TtuAzwSart7NeuZwYzm8p682e/ql6LucW3pz+VE49BLOS3W2aHX2uzGaLLXdg==
X-Received: by 2002:a05:6602:2d56:b0:77a:b7b7:acfc with SMTP id d22-20020a0566022d5600b0077ab7b7acfcmr7462109iow.1.1686762907709;
        Wed, 14 Jun 2023 10:15:07 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t12-20020a02c48c000000b0040f94261ab1sm5160089jam.12.2023.06.14.10.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:15:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, hare@suse.de,
        Matthew Wilcox <willy@infradead.org>
In-Reply-To: <20230614133538.1279369-1-p.raghav@samsung.com>
References: <CGME20230614133540eucas1p1a761c184d7d571cfcd893ab5f8b759fd@eucas1p1.samsung.com>
 <20230614133538.1279369-1-p.raghav@samsung.com>
Subject: Re: [PATCH for-next] brd: use cond_resched instead of
 cond_resched_rcu
Message-Id: <168676290645.1832065.8226937574445830901.b4-ty@kernel.dk>
Date:   Wed, 14 Jun 2023 11:15:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 14 Jun 2023 15:35:38 +0200, Pankaj Raghav wrote:
> The body of the loop is run without RCU lock held. Use the regular
> cond_resched() instead of cond_resched_rcu().
> 
> 

Applied, thanks!

[1/1] brd: use cond_resched instead of cond_resched_rcu
      commit: 6dd4423f3f247b6f0ecb828cf62ea2bc4604f0b5

Best regards,
-- 
Jens Axboe



