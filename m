Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE809C47253
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EDE20836
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 16:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JvOMNCes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgEAQaB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgEAQaA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 May 2020 12:30:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEACC061A0C
        for <linux-block@vger.kernel.org>; Fri,  1 May 2020 09:30:00 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e9so5362870iok.9
        for <linux-block@vger.kernel.org>; Fri, 01 May 2020 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=s1v9Ef1qWFCi7GOWjJijBq4T23vYKALWnvpLA6B870g=;
        b=JvOMNCesmmbETA5rXPcMJw3qIx6DTTBwpFr5eu28pD9PwBendlXlobRB+6DPqcPrJa
         UY25pG06H5QvtCjud9zmet4m3GG9fyZb7zqorVhSDtU94vb5XOYn9KhpH1mi4Gp0to0/
         MwnB2PWHdt+G7mp+rKjJwY8c5b+D9qQl3eaWEeO3pFXcHQA6TQdxb1uzLanuNVPcVFqG
         qkOAn4fkWcu7tfms2CeI8lCU6Uo1mguMXexscelO/bSEfuE/NfdiZqLGachAZZHn18QS
         6G5F0G1uklc3xwi8QHPtBziSjBZzayalxw4w+Cui+Nyqol2YQ2a3f0Wn40OZnCR5Bu0l
         wiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=s1v9Ef1qWFCi7GOWjJijBq4T23vYKALWnvpLA6B870g=;
        b=ZNzY6fU6j22SgwVdNJoosdBO086383vUf/L9NsjaNjLoFkfL6R6sOdCfHM53Tw5rar
         1QaajhZutlcY7yzignIuNGVuN0eq8ol7fGRRgCjHpRwnS9LNhOMDhCvh8Voq3Egydwez
         R6HfE1LD4rHHIMFfz6rkqKemsZDy9+JbWWf0zmSmqIf/DStY7TCKULHXc2vjQ+Jv9+WL
         hdYvuNOE7vkBM2l2WhL3jd50a2nQmRJG0shkDIi3bRlytW00LGwIgKRNCBDUeapbuZta
         JLZpA6FF+3dVHe4Apb05h2pIY8AgLzeCMIseZQZkI+auZB0KuyF0q2g3afbzJihIHa3v
         MAAA==
X-Gm-Message-State: AGi0PuZge2CpbPANNtYqjL4xkzPY5VZvSR4Nq6HjdQ9CoeJsd5y4ggz+
        bkWFagZv/n2sDguSdhuIsErN+7QMI+HOvA==
X-Google-Smtp-Source: APiQypKNGmdPMDMoTS6Ht/zxRGJR1RLU1hJugGzRse2xLLkOz5V7LqSzFE0j6O30MEZ/d3ZuMifM+g==
X-Received: by 2002:a02:5bc9:: with SMTP id g192mr4026196jab.136.1588350599576;
        Fri, 01 May 2020 09:29:59 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z21sm1092822iog.31.2020.05.01.09.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 09:29:58 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.7-rc4
Message-ID: <dfe53ba2-7b06-bf9f-842e-36c06ba03f32@kernel.dk>
Date:   Fri, 1 May 2020 10:29:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes for this release:

- NVMe pull request from Christoph, with a single fix for a double free
  in the namespace error handling.

- Kill the bd_openers check in blk_drop_partitions(), fixing a
  regression in this merge window (Christoph)

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-01


----------------------------------------------------------------
Christoph Hellwig (1):
      block: remove the bd_openers checks in blk_drop_partitions

Jens Axboe (1):
      Merge branch 'nvme-5.7' of git://git.infradead.org/nvme into block-5.7

Niklas Cassel (1):
      nvme: prevent double free in nvme_alloc_ns() error handling

 block/partitions/core.c  | 2 +-
 drivers/nvme/host/core.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
Jens Axboe

