Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC87C4321E
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 01:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiCIBON (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiCIBMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 20:12:51 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2466BBC27
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:55:25 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q13so582265plk.12
        for <linux-block@vger.kernel.org>; Tue, 08 Mar 2022 16:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=TSJygurfY607jvzpaSXbGkChO2r02RRc4zcT8idFGSc=;
        b=cQj5MIXnnya8S4VuATtZHow3Gb7EiUuI/OjHbe4Bsz6nWy6G0t+5bypUdRMHtyDyqv
         0+m047whb+wGAaimM0vhqdm7fHE2tK7e8v4MVMOHyevRhE0Ekma2X7+vVuYJzUQzBxpg
         igFv6lDEkbUr5HIsAwfE81MjZaPPKYxQhxuHQAntNEYj9UfnCRS5/JFQ/UUwM0e4XYOi
         1Y55fztpUG/ZzqjfLMbFkiRI5c6QHvPbIRyAFN9d2XCdb6R/Ud/CQK5iMUGGgkB7eOlR
         7f1UTVAhJCnEsUjpykO6HRnSTzwIP7w6kTV4dHA9oAHljTpNn/dqezd7EXa8/J+2teX2
         lZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=TSJygurfY607jvzpaSXbGkChO2r02RRc4zcT8idFGSc=;
        b=iAttUJxSlYaOC4PdJJVte8HJy1ukGx1o2lXSXRidwJsePTJC0fvzEdW8/X6irEixXh
         sYtI2qlkxKllMAeMk/kCU4X8NGS0WBqhXKAraGp94GiipgeabtJLCCtlaIj+yp4b1uRi
         Yl/Htyn7Tlz9b4yI/zjMrgIw12ZMDX/79ktS+sRHYR8Ii8Zmg0LKeS8rg7AZEEBKfD0C
         qw2u5tZdJ0Em/Z6yuFoVxBCKjGRKdvq3xv5/WKKcxHxCDnb1YelFM5b41ejW8pOAs5n0
         PbTvqiEqe+uz+iye1dlp0JWDIL3PyxV5AsJTPzbwSQ99L8ONxRmSaeebgW1UgKuptI42
         Pudg==
X-Gm-Message-State: AOAM533w2PBbo/u7lKWjK4jGvEdv8SoDpNP1o48SfbmcdFu7zLQkMxfR
        FjNn+ZY/7COSHNUMbzCeyRk8JzW5Iznr3GqL
X-Google-Smtp-Source: ABdhPJzfqta+y5PFpcb2NM6oBxTMwg6z2yK87C1eg5Zj+O7aeUBAto+BmzlkGOcXJ73dc5f0rNRmPw==
X-Received: by 2002:a17:90a:4682:b0:1bc:236:7e46 with SMTP id z2-20020a17090a468200b001bc02367e46mr7473627pjf.212.1646787324421;
        Tue, 08 Mar 2022 16:55:24 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm299756pfu.82.2022.03.08.16.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 16:55:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20220308060529.736277-2-hch@lst.de>
References: <20220308060529.736277-1-hch@lst.de> <20220308060529.736277-2-hch@lst.de>
Subject: Re: [PATCH 1/2] fs: remove kiocb.ki_hint
Message-Id: <164678732353.405180.15951772868993926898.b4-ty@kernel.dk>
Date:   Tue, 08 Mar 2022 17:55:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 8 Mar 2022 07:05:28 +0100, Christoph Hellwig wrote:
> This field is entirely unused now except for a tracepoint in f2fs, so
> remove it.
> 
> 

Applied, thanks!

[1/2] fs: remove kiocb.ki_hint
      commit: 41d36a9f3e5336f5b48c3adba0777b8e217020d7
[2/2] fs: remove fs.f_write_hint
      commit: 7b12e49669c99f63bc12351c57e581f1f14d4adf

Best regards,
-- 
Jens Axboe


