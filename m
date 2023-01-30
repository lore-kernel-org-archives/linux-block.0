Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66433C636CC
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 03:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjA3DEV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Jan 2023 22:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjA3DEV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Jan 2023 22:04:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962131E9CD
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 19:04:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e6so1985926plg.12
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 19:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKSk1kxX8w8OryNBbFAkE6XXIisn2OpGob9bqGZ1kIw=;
        b=KVWZ7VPW0Fk4DVi6LJe8UhymhFaSRg92W22V+se1HU4rDgby78TssGwuS3i5QWwiKb
         2gz6y5Ry1Pn+GLP9JmF1YPZyybGBBqqz4+1xdUQnN2Y0RBLb5N22evtXGC+W6821eMke
         ynk8OE6qZN2fxkgEIaRx6AFtIyI3KsZzTSYjHqbHlrQRn9FuJnf5hTIe5jiPdrp/ZjW6
         zF7+INmrKPioQIHQDcMIXQcxFQecIdF+T0RKWOO2P2Y213WFgVdna3z0HNang6RcG80K
         HtDAtKZoazYB6ynb1jx/DZ/4FrFX3flMgfSDYs4fKEyXoUH4xCRNaiiXgMfWmjcem2NF
         pSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKSk1kxX8w8OryNBbFAkE6XXIisn2OpGob9bqGZ1kIw=;
        b=cJ3B92z2BX9/+mhTVU5l9UgIZTicQbvTHa5qK7BScgbZ1sLQIUCIQTBOhgp/T/LKUI
         WuYHhru6CkQu5a5/0HwySlVD85F5U3f8JqpMJ98smDSn/RSsmwgpKf26lq5qw578Ls3F
         eITh0oNOVqpkTdXt2J/pmX3WmthxJ2utFjFJtU2BneFjOFH9TBH2t6+j4rXOqZQI1LBV
         ePrNw7j436YT/k5CBkFX85zMkyUt9dFQFTh6+3prMGWH1sOdTzlJZzd5O/vwi0p7R7EH
         z/biiZ8PS+/neUtVSRp/egAch40ryHfpXL0N4Zf80VjTxMTPjfqZLsV2dTZ31uJh9Aye
         eIGQ==
X-Gm-Message-State: AO0yUKVl6xin8KJ9AGDd5sXtsQ4pqyBw47C+W0XPIeCmV9uhjP3rgT3W
        hbLWU1Pid34xLldoienjH/J7Xi9XyPwtMFeU
X-Google-Smtp-Source: AK7set/VxTA1LambeEPhoLIFKUTPAENjkRuHt60pLVrAPDxbLjlTog9zzw0x2wAPg2X2Cq5z229rUg==
X-Received: by 2002:a05:6a20:c1a7:b0:bc:6c4f:308a with SMTP id bg39-20020a056a20c1a700b000bc6c4f308amr2774109pzb.0.1675047859655;
        Sun, 29 Jan 2023 19:04:19 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n29-20020a638f1d000000b004d3f518eea7sm5667103pgd.94.2023.01.29.19.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 19:04:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.com, damien.lemoal@opensource.wdc.com,
        paolo.valente@linaro.org, Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230116095153.3810101-1-shikemeng@huaweicloud.com>
References: <20230116095153.3810101-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH v4 0/8] A few bugfix and cleancode patch for bfq
Message-Id: <167504785862.199828.2932581437720147230.b4-ty@kernel.dk>
Date:   Sun, 29 Jan 2023 20:04:18 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 16 Jan 2023 17:51:45 +0800, Kemeng Shi wrote:
> mechanism and some random cleancode patches.
> Thanks!
> 

Applied, thanks!

[1/8] block, bfq: correctly raise inject limit in bfq_choose_bfqq_for_injection
      commit: 0c3e09e8854bcd3f7c45de85007ed283342b3464
[2/8] block, bfq: remove unsed parameter reason in bfq_bfqq_is_slow
      commit: bebeb9e582e8040944b12942ccc56f4ebacaa9f8
[3/8] block, bfq: initialize bfqq->decrease_time_jif correctly
      commit: 1c970450a7fd8be0298758c4e2c631e4a739292d
[4/8] block, bfq: use helper macro RQ_BFQQ to get bfqq of request
      commit: 8ac2e43c3559f29513377df8aff7a22a8277fcf8
[5/8] block, bfq: remove unnecessary dereference to get async_bfqq
      commit: 86f8382e6d3a74f783c23a3d773285e2637b8bc2
[6/8] block, bfq: remove redundant check in bfq_put_cooperator
      commit: 433d4b03e722bdfb1b6a75563cb45e8dca6784e7
[7/8] block, bfq: remove unnecessary goto tag in bfq_dispatch_rq_from_bfqq
      commit: 87c971de8157b90494490d7c869a21b7f2123305
[8/8] block, bfq: remove unused bfq_wr_max_time in struct bfq_data
      commit: 323745a3aa9ba172582d4549689146298fb68405

Best regards,
-- 
Jens Axboe



