Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C7BC433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Feb 2022 13:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiBRNN7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Feb 2022 08:13:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiBRNN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Feb 2022 08:13:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9058C204DA6
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 05:13:42 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so12360123pjl.2
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 05:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=GK4rz9+seFn4xdxHvPLjlObHSp4PzOJAfGpbgOOGnDc=;
        b=X0yxpy0FpsFY7ZLcYL/hyLZTcm0tOjEZLx7X2m/1SjWaDiXAxsGjQ3/RVtMsybX1vD
         eUM4FKRSXHyTu2bsmY9dXOfKtxk6g8ka27l8MYEVjuweCvpCSeUW4UzRXSCnZQQ+pfIU
         JtbpenlRpDiplHlpX+TUFxxs2aOg+dZC2RxDFoAFK3kmkY9FunGo9ockke4UU8MM+gJZ
         2I2LNOuslQVGnctx/w+Zpz3/8yTUFqzfahTN9FFImDypH63XrQHgLszBX8NNBFm0tnew
         Xymx+whVxA8NHk7ooSDbJrHQRFalkm53OPCNNXS8CLisZbMRgXl4JQ5lnZqqPzngJpJK
         S9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=GK4rz9+seFn4xdxHvPLjlObHSp4PzOJAfGpbgOOGnDc=;
        b=hpaIwaoYjL4Nejh+UbDXFUdOVo32AjIsGfZd9nikg8yUHZ1Vuc6fSMNLQCZcwlA1/A
         E1h+5wNQiyeR2Lp5rCaIFjOJx4T3PmugyuKpUmqqkuaGf9r0Co019en/GWDupT7/9BTq
         0JlTVgcyRpFSi70+02BD77nmEnhNX6c1URp5j9c5F7IOKsGNieqRgySRQWhVH0oB8Ee5
         XRso2LPbmmzNpDXHMMNotcF0sopVX3JGxT78BAfT9NJyzYJaDYhwsLkHPw49faJm7XFa
         O69Ch4gOQoTG1LJoDJhDf5fzsndmfC6AwAdFqfJsle0Gn0Cz1JX19uM6VOdzKFkD6d9/
         wFjw==
X-Gm-Message-State: AOAM532HN11lzwgagsvu9aavxaRdfT8o/CawvGGVTAniUG0/7WtrRBPd
        sTdhqR+6OsQc1yqrGlpvi6X6Xw==
X-Google-Smtp-Source: ABdhPJxVEuInQM8ER6sR1lK2pIrJ6V0BG+s8JKZCjXNLjuXxYDSIzxEnjHU8F7msAcnMf1oHw8AiAg==
X-Received: by 2002:a17:902:b116:b0:14f:460d:bf42 with SMTP id q22-20020a170902b11600b0014f460dbf42mr7500903plr.108.1645190021985;
        Fri, 18 Feb 2022 05:13:41 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j8sm3179025pfu.55.2022.02.18.05.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:13:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, Yu Kuai <yukuai3@huawei.com>,
        paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20220129015924.3958918-1-yukuai3@huawei.com>
References: <20220129015924.3958918-1-yukuai3@huawei.com>
Subject: Re: [PATCH v3 0/3] block, bfq: minor cleanup and fix
Message-Id: <164519002068.11187.11125581863819344403.b4-ty@kernel.dk>
Date:   Fri, 18 Feb 2022 06:13:40 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 29 Jan 2022 09:59:21 +0800, Yu Kuai wrote:
> Changes in v3:
>  - fix a clerical error in patch 2
> 
> Chagnes in v2:
>  - add comment in patch 2
>  - remove patch 4, since the problem do not exist.
> 
> [...]

Applied, thanks!

[1/3] block, bfq: cleanup bfq_bfqq_to_bfqg()
      commit: 43a4b1fee098bd38eed9c334d0e0df221ecdf719
[2/3] block, bfq: avoid moving bfqq to it's parent bfqg
      commit: c5e4cb0fcbbaa5ad853818c4a2383e9bd147fad6
[3/3] block, bfq: don't move oom_bfqq
      commit: 8410f70977734f21b8ed45c37e925d311dfda2e7

Best regards,
-- 
Jens Axboe


