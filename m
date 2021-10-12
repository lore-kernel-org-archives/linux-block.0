Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB73C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 19:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D876101D
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 19:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhJLTtd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 15:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJLTtd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 15:49:33 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FCBC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 12:47:31 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y17so256051ilb.9
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 12:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VY6eTj0/BcK8R0rL+lb0iHOsJJ7H0M08DuYmBM/LlpU=;
        b=T9SKJjLz1syPL/HbF8hpUra3ZZEM0/V/vg+MPQoxZVFQCEd+svl7HHv8I4/uYvyJVw
         qbnBOJmOO8tam+p95XUL/oHOTgsYY8Jk9nDuWuU4u3e/UBtL1fOypvqcAUvYUXIHaWBC
         OF2XXNv92GQINWRekK2LYwV6VRCOa0aWoLk7h2kDveSlKnpvMPri9lNc59NHgYufGAoK
         Q1hNRlN/450KyIm6J1D8NbyO1G46jDbiJVrLigtCH1hlvOtAi9FNy1G8IX5BabS8sDB7
         rLcHxXv1ttdD7+VkARebQhe3MS0cMtdkCajNwRerdneYoZ8tkuuL688UUtLfI9vUSwUS
         DFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VY6eTj0/BcK8R0rL+lb0iHOsJJ7H0M08DuYmBM/LlpU=;
        b=EmxIcG2O7rf6uIw5zOBqoT9BwZLfkgANjrSnOVfXPWlutVZ5MLMu5pu6StDpq7jEqF
         2Ec/D/VPTBImSYgnVaj07HfzelnXpP6KH5fTf7qDMpgAWn8BLEDJNsGrBv93dNBSMk/1
         hpxipuhfFcD8eP0PW1cbWSY148gMgBkWfH0oFbJW7fDzjYr32DdX3gVrcHk3x5wuVWgb
         3c1oXm0bOUyum4E2ANDmvYtwRfl5WjnIMcAYblHS5gkqy8b3sPikyajzPtuT9ayiA+7A
         kZR0RKwU0/1SYjKGQYeXNEDarnngjHvOVsY6AXgU7o3luCafKW+6Z88U8IkuS9GWweRp
         5DwQ==
X-Gm-Message-State: AOAM530So/Y9B6OAHE+AmrWwrenccewV7EqM2mtcnhdH26/fbMY7PjqA
        vasEhN4tpMHGswdKmv9J+4gcyg==
X-Google-Smtp-Source: ABdhPJxkJohmmZcO3uO4v9MIijxH2Vi6Cda9iSGeTul2f/tr2MsK7ET9kvYprVW2UTxfV+Ccp/gRpQ==
X-Received: by 2002:a05:6e02:1a69:: with SMTP id w9mr5374047ilv.265.1634068050942;
        Tue, 12 Oct 2021 12:47:30 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l12sm4502978ilo.60.2021.10.12.12.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 12:47:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: decruft bio.h
Date:   Tue, 12 Oct 2021 13:47:24 -0600
Message-Id: <163406707391.697968.6250187966537137001.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012161804.991559-1-hch@lst.de>
References: <20211012161804.991559-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 12 Oct 2021 18:17:56 +0200, Christoph Hellwig wrote:
> this series moves various declarations that do not need to be
> global out of bio.h.
> 
> Diffstat:
>  block/bio.c            |  100 ++++++++++++++++++++++++++++---------------------
>  block/blk-merge.c      |   31 +++++++++++++++
>  block/blk-mq-sched.h   |    5 ++
>  include/linux/bio.h    |   78 --------------------------------------
>  include/linux/blk-mq.h |    6 ++
>  5 files changed, 99 insertions(+), 121 deletions(-)
> 
> [...]

Applied, thanks!

[1/8] block: remove BIO_BUG_ON
      commit: 50c1c0fdacf093dca591e36db62ffa5b68db2ba5
[2/8] block: don't include <linux/ioprio.h> in <linux/bio.h>
      commit: 572f1bca6dfd38d5bf27bb617cffbd4788adaa16
[3/8] block: move bio_mergeable out of bio.h
      commit: 272ff6fb565b310b436f3348c482f6feaeee4915
[4/8] block: fold bio_cur_bytes into blk_rq_cur_bytes
      commit: 5eb9cd2ccdf779f83870370c815630a32b7df77d
[5/8] block: move bio_full out of bio.h
      commit: 8dc8d6c0124882a931b7f00400c546de36ba888f
[6/8] block: mark __bio_try_merge_page static
      commit: 3184916715244d9382c18102e509b995d9ddd2a0
[7/8] block: move bio_get_{first,last}_bvec out of bio.h
      commit: ca52cd788dc82151876484255580bbf5e09781ed
[8/8] block: mark bio_truncate static
      commit: 55b8648b7650e7b1d2eae81521c642f80f3fd152

Best regards,
-- 
Jens Axboe


