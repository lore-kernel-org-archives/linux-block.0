Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C052C32771
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 01:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiIVBpf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 21:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiIVBp0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 21:45:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C6A220F
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 18:45:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so618421pjh.3
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 18:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=Dq0iQh4qToxlEKhzB+z+PfOSTbjBSMMKmR3O23n0bhM=;
        b=n4WWiZqxOq49svpEqVTNbGrjn58Du2tA7d/uK14LhX1nJuD4aTP4xJbUhppRvCryuf
         hW+7FGatWhDmIlM64A7HkDuKafK3hUyoovgbAFRDMIlciQ8NScx+53eoofYzfT+LG03m
         1WExdnaFXLqIHShlYLLGs+t9gPwMxJgvhCsRjyzh/cRc1TLwx3mXBM4TrSxm7MzgQ/pP
         KlMYx/mBcS7Td3e5rtpV4maW5Z1fJ8fodDuumMw14Z4kmE3c/wKIK1gzL5wcQH/Gdwy3
         rh6JQr10HatJn/oXjwdiVrwBcKetmeAFHm1xSd6sHS75hNYlpIec0ghkh2F6UrBjmSBY
         jLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Dq0iQh4qToxlEKhzB+z+PfOSTbjBSMMKmR3O23n0bhM=;
        b=72tBLD7aQwLkQ4qrSBfr/vLlFRa1+b32cCwrYqMPkAvO1u4QVmZfsMZnBNbOPlBys2
         X8mmCkcCyFCWgXGTFa0EM7e3plwKFMIIOX6NWLgB7/GV33sWUCuTPFa+ycVqvYmSs0kJ
         UBDM/LSoYqxBqNoyBjoz2MzAM5eEUqeSK4c0w2XxBgryzxe0qygoDgItmnglOh8P4xwR
         YYgoG2C70S3RGAp5zBg980EvyXc2vuOXCiFV0HSAqIejoL8ineHTcMPC1BJpAELKSCQf
         CQ/NGzJRchn9GoLe7B8cvoDef74mF5zTO0Rb/7eo8kCHbH6s2AhO6VlFrQKUI0qSoPpG
         flXg==
X-Gm-Message-State: ACrzQf39Fi/r2daz6DZaCUOUdaifHSadxFrorl8r83T/t0qpWGadjTLB
        5tOozkbIqAZDtf1WKaDjlgM2d/r0rIEqsA==
X-Google-Smtp-Source: AMsMyM4VAl+/+KpX8+5ttib4ZAieIJ9DxuiypuHbg/a0eTSNiKc7Gzv1wr7VEggzUaUBrndVNstZaQ==
X-Received: by 2002:a17:902:d34a:b0:176:b8ad:ba76 with SMTP id l10-20020a170902d34a00b00176b8adba76mr907555plk.139.1663811124880;
        Wed, 21 Sep 2022 18:45:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b0016c0b0fe1c6sm2701763plf.73.2022.09.21.18.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:45:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        philipp.reisner@linbit.com
Cc:     linux-block@vger.kernel.org, drbd-dev@lists.linbit.com
In-Reply-To: <20220920015216.782190-1-cuigaosheng1@huawei.com>
References: <20220920015216.782190-1-cuigaosheng1@huawei.com>
Subject: Re: [PATCH 0/2] Remove orphan declarations for drbd
Message-Id: <166381112404.39678.3870348207045502610.b4-ty@kernel.dk>
Date:   Wed, 21 Sep 2022 19:45:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 20 Sep 2022 09:52:14 +0800, Gaosheng Cui wrote:
> This series contains a few cleanup patches, to remove a orphan
> declaration which has been removed and some useless comments. Thanks!
> 
> Gaosheng Cui (2):
>   drbd: remove orphan _req_may_be_done() declaration
>   block/drbd: remove useless comments in receive_DataReply()
> 
> [...]

Applied, thanks!

[1/2] drbd: remove orphan _req_may_be_done() declaration
      commit: a437df5f8bbc6b52231bbeaef8b4052698c9007a
[2/2] block/drbd: remove useless comments in receive_DataReply()
      commit: 7f0c1afeacfcb4c32173b5a120ec0a362b79bd71

Best regards,
-- 
Jens Axboe


