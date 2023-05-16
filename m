Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29228C7EE2C
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 15:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjEPPF0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjEPPFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 11:05:25 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA545B80
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 08:05:24 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-76c63acb667so34168739f.0
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 08:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684249523; x=1686841523;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EphCi21jn2aDXvfJbO6qrmW15qoNJsLoh6JuSR7o6W8=;
        b=Z2Bimm+BRXobn2JlbDof2EaD1LgBdbuC07iSsxWro32COoyjBgoFqag9ydoMpQP0Xy
         yHbDlYzyEixG1jyVCSU9c9YVeLpJNGGeGoWegjPjNsXLbQ3aKCJPff0mjB7Twk/5mAgr
         bC8fnYefxTFFF9umi9R6nazonq9KLE7gbs/kKS/W/obqrjQrQ6CfEI11rTSXB42nzukE
         z6OOVlVvvmRoYgGwjrgL4vMPNNwX9JZ81XEDeaZ/HkUBcsybtmXce3c1NgKuIVTE7SJe
         CpmPUVw1fjoorSuwdI4sW3625ZjYqGM7hxvYgCjj4WjzwHUIZ8tzDfcSWyGaiK8a9akO
         I9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684249523; x=1686841523;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EphCi21jn2aDXvfJbO6qrmW15qoNJsLoh6JuSR7o6W8=;
        b=A+RXc+MbyrVMdeh5Csr2p10O85DQZp2Lwyfq59Rmfc1OFaRFyS4P1Xzj/aAzRMR8J9
         V8DIhgQgbX5soF29syRdKUxSA8E3X00hpRi70Kl4i5DMtcPhFpajz4ecPpA2FjqkX26x
         Ngm/EUIX7f3iEmKj5El/V5VLvkn2xK7otDkxP5Bc6wihgnE3xjCt0hetk76hunnNfQVx
         3qcI1JcAyFwboM+jKB85hXXl9qLFAS9/ygyk0UiSC0SMyJxP9YkKbl6ePvJp9uHqeSNA
         mdT/DpG45OSFioLZb11gVPsEil/WPAI0erQSWJBLayKAKH8XLQOoFtUU3n+iZ+OzlYcf
         KXcQ==
X-Gm-Message-State: AC+VfDym4air4W5C6VhfR5JvhCeKtQ5ESDcmk34aODJdF4cCErvNNK/N
        OcXYojBpIR8dELPMGtQbL8J10A==
X-Google-Smtp-Source: ACHHUZ5cDHVmYhErun+AI9wJ5MatHtlF7oLQoDJqvO1OTRg8l0TgTCNRb48Eqch7GxvXQ5Wzu+hT7w==
X-Received: by 2002:a92:c569:0:b0:334:f9f4:903 with SMTP id b9-20020a92c569000000b00334f9f40903mr22896ilj.0.1684249523551;
        Tue, 16 May 2023 08:05:23 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p39-20020a056638192700b0040fc56ad9fasm7622470jal.9.2023.05.16.08.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 08:05:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     gost.dev@samsung.com, linux-block@vger.kernel.org, hch@lst.de,
        willy@infradead.org
In-Reply-To: <20230511121544.111648-1-p.raghav@samsung.com>
References: <CGME20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1@eucas1p1.samsung.com>
 <20230511121544.111648-1-p.raghav@samsung.com>
Subject: Re: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
Message-Id: <168424952263.1748830.1319947207415920184.b4-ty@kernel.dk>
Date:   Tue, 16 May 2023 09:05:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 11 May 2023 14:15:44 +0200, Pankaj Raghav wrote:
> XArray was introduced to hold large array of pointers with a simple API.
> XArray API also provides array semantics which simplifies the way we store
> and access the backing pages, and the code becomes significantly easier
> to understand.
> 
> No performance difference was noticed between the two implementation
> using fio with direct=1 [1].
> 
> [...]

Applied, thanks!

[1/1] brd: use XArray instead of radix-tree to index backing pages
      commit: 786bb02458819df7a833361c6c7448a4925a89ce

Best regards,
-- 
Jens Axboe



