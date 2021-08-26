Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638EDC432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 17:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FCF61026
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 17:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbhHZRAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbhHZRAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 13:00:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BB0C061757
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 09:59:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so5920446wmh.1
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qnQKMtCrpxtD4U6aslleaR7YtsFiPfp2usl//RcNAcU=;
        b=EadKsHtvrcU131xZgzMiSYw6FjuaMEuHOm/hq9bWSmScHbENdNds8jqP3fApIjykZW
         BAoVYRzrSmHko2nzeg1AamqiHWPctdMy547Tf5MlI7GDibYqJR12vHZoOJer/jLWwGTI
         CtLSYqFxkwcx9nHYrknQSswOzb0FXilXEJDKr/aQHQKebj0+7GbD9O7AfwalJJbsL+Jk
         GcHK/5Wsh01LvVACprLcBZj8UTr0ti7cMHRgG/+FGQyvdtFbF9bkVQ0dNCiGKAYD1e+4
         wijc+yMCobosUr556uTNz4eXD9oeM44x1e5TcLuc5pHytOnquNSjydwX5CcleKATSBu7
         u7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qnQKMtCrpxtD4U6aslleaR7YtsFiPfp2usl//RcNAcU=;
        b=ZagLo3r7OYSjXupZQofvFQVWHiWSBnNI6+Xw2E1Wt/XOS3XLmhjYZPSLay4ohz0ccz
         wyHnagg/Scmke+eU74znmHpreNygZK2nwT9WlyTfrkO1meBZY1aYLY5WBoZR65wcitXV
         9fK1XYpXojqXUK3/92ZCzwNaRSlEju1EoytXTrK75yImmIYdQ4pCsACYGh2EbC2UpyEi
         dZHOE9Kw0HXgMlz4+vaff6gNi6Y9c6Z8Q1nWBARAWrNjuSAHjep3qnLrTWyzL832rqTC
         wq7M7e4FfUXwRDFL1QKp5/mseKjP/OKjjgbOEnj8vfBvmQcA19TF3XYMBqhcku6WDFOU
         y6/A==
X-Gm-Message-State: AOAM530Zw0a0G4IvqOp/uvpW+sJ6+3nWleVXuIi/i2nSoV4MPPCqKF2O
        taytVHgdxYuOknZSHJuXmX96IQ==
X-Google-Smtp-Source: ABdhPJwPgeuBh6v9VCnH1N8xiLxNFkZx/GLFIh0UmWj+okTfsy42zvtTHybKYkq3vqXOwd2e/cXQ3Q==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr4746792wmc.42.1629997197947;
        Thu, 26 Aug 2021 09:59:57 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t5sm2552698wra.95.2021.08.26.09.59.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 09:59:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 0/4] optimize the bfq queue idle judgment
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210806020826.1407257-1-yukuai3@huawei.com>
Date:   Thu, 26 Aug 2021 18:59:55 +0200
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A983576-4EE3-441A-8515-14A819A94B8B@linaro.org>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 6 ago 2021, alle ore 04:08, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Chagnes in V2:
> - as suggested by Paolo, add support to track if root_group have any
> pending requests, and use that to handle the situation when only one
> group is activated while root group doesn't have any pending requests.
> - modify commit message in patch 2
>=20

Hi,
sorry for my delay.  I've just finished reviewing your new patches.
As I already said, I like the improvement you are making.  Now the way
you make it also seems effective to me.  I still have a design
concern.  You will find it in my detailed comments on your patches.

Thanks
Paolo

> Yu Kuai (4):
>  block, bfq: add support to track if root_group have any pending
>    requests
>  block, bfq: do not idle if only one cgroup is activated
>  block, bfq: add support to record request size information
>  block, bfq: consider request size in bfq_asymmetric_scenario()
>=20
> block/bfq-iosched.c | 69 ++++++++++++++++++++++++++++++++++++++-------
> block/bfq-iosched.h | 29 +++++++++++++++++--
> block/bfq-wf2q.c    | 37 +++++++++++++++---------
> 3 files changed, 110 insertions(+), 25 deletions(-)
>=20
> --=20
> 2.31.1
>=20

