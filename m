Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBA5C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 17:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjEWRN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjEWRN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 13:13:56 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDE2B5
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:13:55 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33110a36153so1329855ab.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684862034; x=1687454034;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHqkW47AY8QARjZ5sy2gHsO5riEq31n+nVihbrRMHeg=;
        b=eYmYusKwHer1Vddz3pPV7eYUdrCDXog4GbnNmTtVn6yjEa5nW+iLa4GHdG/+5J9Jtq
         vQQrEo+AbKTYqOkM081VcPtdOP4uTwol/9BWtYm0THz/MCQPrRBOT29fRaspDpoJzNDf
         TnEvF+e/w1115/oI2u6MJ6I/SJoXuxb8Mco/v9TUerlWvYy8EyTRs2zKSOSc/zza3cAd
         R/KQgtfcR1IbkLiYvMCFqSoSW5G+9jWmcoCSHLsZN/DPMp2v3BsJ0CgrQ6yU/WceRx7h
         sapeU3+G0pBWIblX1cgB+DnnUBThOhBmT7kYFYAisuOMqZMAA1l/Y0ZYCmkR35O+oAqU
         acbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862034; x=1687454034;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHqkW47AY8QARjZ5sy2gHsO5riEq31n+nVihbrRMHeg=;
        b=fWU0WeAL1mX0Bk62qG4eL55xCYRhje/7pDs7f4pRzL5ml/yYxuacEgqKkxwwTlh82r
         FouRDpHrz1KT2lSQ7b8Fo70YRLnCfhadk+ACJ1mk8cyh8/7iQr1Az0Cjxd5/EYUyRY5m
         uoWQBpjUf4YyF1FIqpXGB4fcs66QXUIeKVMclZfOO0ZHnSlpcCdB5QaqsYCzIqWsU0ZA
         8MIbfOIBNTIsLE/hLod5AxEybjV9uD2EiDeSZT6oABfpFOC7XNx2nMOZ2/RetSHHRK8t
         U1w6smlEslNqvrd0HZ6n9EOAodJT5f1+IEGkUHVbYNB4R4OSwaI3qfjZRRwtmS/qOJ7T
         CFow==
X-Gm-Message-State: AC+VfDwxEAtViIwl+EpZ3puj94Y0yzMunoDlh3OqDuZ4BsllNNNXj01P
        8O1N0UeXtMT4xprwDO1Bjjbwvw==
X-Google-Smtp-Source: ACHHUZ5np/5g+AjvJUk/rzK1gJys/RTdgbLu8FCkGoLJWbSCHJ8ovlR92Aj/dzoTfL5zkPflb+jbwA==
X-Received: by 2002:a6b:5817:0:b0:76c:883c:60a2 with SMTP id m23-20020a6b5817000000b0076c883c60a2mr7078214iob.0.1684862034386;
        Tue, 23 May 2023 10:13:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02aa87000000b00411a1373aa5sm2524580jai.155.2023.05.23.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:13:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     regressions@leemhuis.info, chengming.zhou@linux.dev, hch@lst.de,
        yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230522121854.2928880-1-yukuai1@huaweicloud.com>
References: <20230522121854.2928880-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH RESEND] blk-wbt: fix that wbt can't be disabled by
 default
Message-Id: <168486203336.398377.14105222183209089058.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:13:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 22 May 2023 20:18:54 +0800, Yu Kuai wrote:
> commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
> wbt_enable_default()") removes the checking of CONFIG_BLK_WBT_MQ by
> mistake, which is used to control enable or disable wbt by default.
> 
> Fix the problem by adding back the checking. This patch also do a litter
> cleanup to make related code more readable.
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: fix that wbt can't be disabled by default
      (no commit info)

Best regards,
-- 
Jens Axboe



