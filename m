Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5581C7EE25
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 17:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjFIRgQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjFIRgM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 13:36:12 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2804035AA
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 10:36:06 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7747cc8bea0so18810739f.1
        for <linux-block@vger.kernel.org>; Fri, 09 Jun 2023 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686332165; x=1688924165;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elYWTHuitKVMi7wO2Aaxy/qmAgn7vpTmax6bBeAbe2o=;
        b=XWTLKjV5bT9tIWkvd6UdKXKDdcSNnBsTDWHev9b33oy4rRWOGlTHbtgyc5Jbduvpln
         Et2+k7hQfZPaP+NxfadmEibLHUqQvWLDvEaVX3ESMOfzarDg0zuN+1jEcmG6Dg/tVZp9
         g6urAs1kQh5zyqPeUwxZKk0LRd2j+NQQx7tthPq5MfJ14wEySahiAHj4BwUpVdbOJGAA
         BVywRs48rET3AUPB8/5N08cUyGaBdwasuKynASUXHLAKeOEDNZp7eHA25hqH6MLRwew1
         DTeUGR2K8C7P3Kpx3r1u0eEOhIsoOt+/JMZSVxCGPHXq8BTnuikWGbISPlarpD8X6W0L
         pE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332165; x=1688924165;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elYWTHuitKVMi7wO2Aaxy/qmAgn7vpTmax6bBeAbe2o=;
        b=cFAteDyc41SiUIVEwqWuOPZ8+nJzFDZbjXc7z6JolsxMq3cvi1HeslpqOmT1vAtN7E
         nmKTuZsJyWPXt7/kQUjMt+E+YzmZf0wM0baj61yZI/ANp9m2DVHUPdPAT4Lt3xQ7aiH4
         c2g4duWjxZHDH/j/frcO4n3MK/q6ol4UKQh0nqkt/+7PeioAv1tJ73m8zTzPdJcM82vQ
         5igHHKOz5HXm4BFtTfLuVdH//9prpgmS7BPs77P0OMEN/nb3hWdH4RbiXxPA5y/0Gq6U
         6xM3nEYsSdbFtq0JiJOTfjUCro2kS/y2sACq0DbuCZmO5hsNpZtmaJ78eloVy7xaH5l7
         pLzw==
X-Gm-Message-State: AC+VfDxXcyGMM2L+xXe5c3RcViMNLCMfdBPWzAkzEIZ1IUH5KHazfiER
        EbgxWbKUYitZSGWwPhFiBBGUgXsrgCwpzpH4tiQ=
X-Google-Smtp-Source: ACHHUZ6TcSVRL7JtrdHOsrKxJOzAySE2XN5tlCVlKsqRqPOwCwtSv7xEojKQHLIeDwp3lPQcQ2r69w==
X-Received: by 2002:a05:6e02:188a:b0:33b:583d:1273 with SMTP id o10-20020a056e02188a00b0033b583d1273mr1878335ilu.1.1686332165029;
        Fri, 09 Jun 2023 10:36:05 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e13-20020a02a50d000000b0040fad7eb910sm1063429jam.176.2023.06.09.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:36:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230609153750.1258763-1-sth@linux.ibm.com>
References: <20230609153750.1258763-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/1] s390/dasd: fix locking error
Message-Id: <168633216394.624591.12554905661891516522.b4-ty@kernel.dk>
Date:   Fri, 09 Jun 2023 11:36:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 09 Jun 2023 17:37:49 +0200, Stefan Haberland wrote:
> please apply the following patch that fixes a locking error in the DASD
> driver. Thanks.
> 
> Jan Höppner (1):
>   s390/dasd: Use correct lock while counting channel queue length
> 
> drivers/s390/block/dasd_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Applied, thanks!

[1/1] s390/dasd: Use correct lock while counting channel queue length
      commit: ccc45cb4e7271c74dbb27776ae8f73d84557f5c6

Best regards,
-- 
Jens Axboe



