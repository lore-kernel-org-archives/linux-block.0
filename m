Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7197EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514AD610EA
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhJMPzd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJMPzd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:55:33 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F244EC061746
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:53:29 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id m20so229202iol.4
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRJYysWcjfnhv+GGO7EufUUE7nH4i6VwgRDsf0WXS/U=;
        b=TjGSQml7qFm6Y4IuqWI6mSd/8Oo/OKtaBfu6edw7RdaxWuCGM9dwhP3mphBy0xMvyZ
         cx1ORJ2cKLo+CyeqC8hyUHzVgKejilvpUvf7tzFgqgIsB1YXAbgOeFmo5CSF5r3sdPCh
         8VUlX0911vaun3co/17ISn72BmMO11STpUAoei0Vnkvkgk+DwakrAn59UkMEoSZL9jUy
         JK9liHqsFeVAbmt19jm7hSORei+Tlzgkl+nswVUI00iFkP5z79/zteUaHZovoBUqpf4m
         7cfDgHIBWyPVyz30593ERjoRsdUn/hdsUoPG171gEwy0LYAeM5RrqFb1SvK7DwYamzqs
         mugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRJYysWcjfnhv+GGO7EufUUE7nH4i6VwgRDsf0WXS/U=;
        b=YNOImY4eRKxw+SuKLkMvBaeCJQr2oxCOeDpwTq7s0R7nmiATrMGC4+phFYRpOfdNoS
         d9bSrnkp1Mao/Fjpktx1p1iUFbTum/i9akPu21+CC8Mk8TeMluGB7tOU3z24rVfIOLc6
         3jxBbILqReUfU/j3ZmFE3Mc+nSrTYMV10kVuIFIPFaXL9Xsy6db85V5oJdXH8AET5r7n
         Vcq8yeyVH7nktu5vxoW4A/v8I6EzvQd+eTrWVKe4a0bhlllmOWowTbNbluK5nClospuj
         XZ2UGCmRu3YlbxjjKmDRo1iIOEFtmFj0HwUsyVsFew1yildteIBm2gp5Kw8lz8K7+xEC
         NWAg==
X-Gm-Message-State: AOAM533txGrYfrjuHL7fX4UtXQD7rq1xl8SqAW6tbhhKA8iyLsSGETnv
        KX4dbJRtXiUaxYLojmkbt2HdLj3cPG9qVA==
X-Google-Smtp-Source: ABdhPJzOqkx0x0ea5U6PunzaCKZrhYE9jjoNZ+ajFlz4tqMgw5oKTgpVmXVX88Rkys/tkarSK6Q7Ow==
X-Received: by 2002:a05:6602:1504:: with SMTP id g4mr10396iow.133.1634140409335;
        Wed, 13 Oct 2021 08:53:29 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m1sm7003330ilc.75.2021.10.13.08.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 08:53:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: Re: (subset) [PATCH v2 0/3] on top of for-5.16/block
Date:   Wed, 13 Oct 2021 09:53:21 -0600
Message-Id: <163414039197.962778.8154450791755434803.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1634115360.git.asml.silence@gmail.com>
References: <cover.1634115360.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Oct 2021 09:57:10 +0100, Pavel Begunkov wrote:
> ./io_uring -d32 -s32 -c32 -b512 -p1 /dev/nullb0
> ~3.3 MIOPS vs 3.5 MIOPS, so gives around extra ~4-5%.
> 
> The main part is caching struct block_device + some inlining.
> 
> v2: without applied patches, merge previous 6/6 into the second patch
>     get rid of helpers (Jens, Christoph)
>     kill bdev_inode and move inode into bdev (Christoph)
> 
> [...]

Applied, thanks!

[1/3] block: cache bdev in struct file for raw bdev IO
      commit: 82f652990a4ade2df9d6475ad82f4dd22a3265f6
[3/3] blk-mq: optimise *end_request non-stat path
      commit: e945e2edb67048c42527089cd9938454ae4f9c04

Best regards,
-- 
Jens Axboe


