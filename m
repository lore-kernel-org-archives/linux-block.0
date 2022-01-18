Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB7C433EF
	for <linux-block@archiver.kernel.org>; Tue, 18 Jan 2022 13:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242607AbiARNeX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jan 2022 08:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242872AbiARNeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 08:34:18 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E98C06173E
        for <linux-block@vger.kernel.org>; Tue, 18 Jan 2022 05:34:17 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e8so17517502ilm.13
        for <linux-block@vger.kernel.org>; Tue, 18 Jan 2022 05:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=VJ0Go1iexNePR+XLN+Sy+sq0m+3ItOh9+zlr4BQ8Lws=;
        b=UsR/i7J7BaZX5LJDrgKD7c6zf1TiFV3VpSCl58D7RP1fn+RqCVm/OrxWsT7TFtOZxX
         /NppTeYizfwPz6CpxsTPy2098yT04kAmN45IuOinrKwDyhVFIbHNjuWpxdItliD2a8wg
         vBWI0JaXZVGjX/RCLFaXIR5C6xfeJs6EgbrP3tM6GlYpiytU7rls4siDlbvARhqIhXfa
         fpNonbwGoDt/1lR3LoT40wGsQW9sfwx/cDyuFzTHCY172vaxlkGm1nWqD9ps1CV4Mg9M
         wINfiriUTHVixRyGU6YD6fbBhLuXdB6EWFob2kJGr/Dwj/cH6iwE7Qtk6iRdhyWGmfpY
         vp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=VJ0Go1iexNePR+XLN+Sy+sq0m+3ItOh9+zlr4BQ8Lws=;
        b=r7B65YMDRYaxIfx6+Mlca226VHyv/onqsm8IOWtFLe0LaErBtF2sufXFkfEO2o6+T6
         K926ZZkbj0NHBcNhVwNx/os6hiyMcxnA151bhx1cWTo728B9GYE2PNE2y6tjNMx/aWXb
         AsDSnlkLJT6fwUopzNQfAtdfFwyjNfPLA9bpSh8665pY01yTGiJ4AEgRrBbiCinmbHa/
         ZveLRl41A6ocmMLSZAmte/qK1A9YM4oS3qqMK4qRDpI/vOsgN+J/aJ0n3SCMS9zsamPr
         kpkEqxzOtcJXcYuZaffzICLKnnXBiepRR9YsHrKxQjKcq3CM/HmX2JWlXXcsR1QRlWbv
         R9QQ==
X-Gm-Message-State: AOAM531wiI3/2Up1zTOU2NgTlo81Y5soHbghrVFARxvFXxNjmDFS1HFs
        TJ4rzc5Lufe3O694wdIDSQEuBg==
X-Google-Smtp-Source: ABdhPJymb5wi3Q+xSrBvaiy7jITtrQ6swp90zYj7ZkKzJFntjsuFXkeuGj96uvVA3PHbZce40t++jw==
X-Received: by 2002:a92:2805:: with SMTP id l5mr10852693ilf.18.1642512856966;
        Tue, 18 Jan 2022 05:34:16 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t9sm5956540ilu.50.2022.01.18.05.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 05:34:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20220118070444.1241739-1-hch@lst.de>
References: <20220118070444.1241739-1-hch@lst.de>
Subject: Re: [PATCH] block: assign bi_bdev for cloned bios in blk_rq_prep_clone
Message-Id: <164251285630.363604.2974408716787328487.b4-ty@kernel.dk>
Date:   Tue, 18 Jan 2022 06:34:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 18 Jan 2022 08:04:44 +0100, Christoph Hellwig wrote:
> bio_clone_fast() sets the cloned bio to have the same ->bi_bdev as the
> source bio. This means that when request-based dm called setup_clone(),
> the cloned bio had its ->bi_bdev pointing to the dm device. After Commit
> 0b6e522cdc4a ("blk-mq: use ->bi_bdev for I/O accounting")
> __blk_account_io_start() started using the request's ->bio->bi_bdev for
> I/O accounting, if it was set. This caused IO going to the underlying
> devices to use the dm device for their I/O accounting.
> 
> [...]

Applied, thanks!

[1/1] block: assign bi_bdev for cloned bios in blk_rq_prep_clone
      commit: fd9f4e62a39f09a7c014d7415c2b9d1390aa0504

Best regards,
-- 
Jens Axboe


