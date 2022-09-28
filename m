Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B249C32771
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 14:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiI1O47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiI1O45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 10:56:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB20B5D133
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 07:56:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id r8-20020a17090a560800b00205eaaba073so1929018pjf.1
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=Evbxzhf/pidjDLKsn2x4GwyfLG+kx9sCzYCgU3SIOzs=;
        b=BM1130YISbPJoEOXY/XCelyXBLiqKFFgWlZ1zO9bWO4yWVB1jy5NiSl6zC8Zw0ZnOq
         yMxwa7RbWXozsdZod//bJcczi+DGoI/EzIZR9FbULZO6zL7C58GSqcICXa3CPQR0vKPw
         4CHlme+4OT/d9WAfN5O62gcyqDnYhpMeZVhfwDF/HF+WFbVZ2dYsxQicpeu17iolJmEV
         670OH3TniBwAS+zuM27lg/z2oFkWxiQiQvSw+y+e5eZRmuvY53kiMxPbmAGlTMIjNMhJ
         1CZ1YZtp2DloLEmy133y1rEWxV7rdG0iVflGez8uxfBkiHfwhpj0mN3tQCTzsK77Q42b
         RnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Evbxzhf/pidjDLKsn2x4GwyfLG+kx9sCzYCgU3SIOzs=;
        b=UdxusNYBMbAOMvFqxGfP67yA0Pyc9hjk7kPkqNtwewDaBOhKfqUCxRw5dcCdqL5kS8
         XN9QhRBLjY4M4Ocq99t3f/jEG23xtWo5liKjENCcTxPW4FF7/BmNEprM2YiCA9drRm+G
         Z5vtEI83BiFg3p5/4Bvmo7N90z9vTEVQgWzAbF/IfqXctZ0ObdxrjV2PV9E8iTLZSFvY
         +4EsWeKYqgp7J/dhYbJYIvINSc/ObUIvYsyZJNHqJyrA8+VOE/lUpPU4gt0CgmjWTgv8
         Km70+Fe3qUUqFgO9IPwbaAeVh2aE1SWbLB913i2GNmCFwOArBAvevGhHk/LhaEPEBZdF
         Wc5w==
X-Gm-Message-State: ACrzQf1G2T+ZuQdGO8YC7bxRhSVmyj8y2VqWijQzQwgAhlxJROdHVR6y
        j7DJ/5+CK2zJHuoxlWsmfXETqA==
X-Google-Smtp-Source: AMsMyM6ocIj7PO1ySCSvMbUGBqoq5MSHPeCi/XmsKI1HBbCZRFlkoveHIhm/K4wkMWZA9bp4faDdcg==
X-Received: by 2002:a17:90b:4b88:b0:202:e381:e643 with SMTP id lr8-20020a17090b4b8800b00202e381e643mr10825059pjb.148.1664377014372;
        Wed, 28 Sep 2022 07:56:54 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001782751833bsm3863908plg.223.2022.09.28.07.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:56:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220928143945.1687114-1-sth@linux.ibm.com>
References: <20220928143945.1687114-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/1] s390/dasd: use blk_mq_alloc_disk
Message-Id: <166437701324.16288.5697183698335314295.b4-ty@kernel.dk>
Date:   Wed, 28 Sep 2022 08:56:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 28 Sep 2022 16:39:44 +0200, Stefan Haberland wrote:
> please apply the following patch that improves the queue allocation.
> Will you still take it for-next?
> 
> regards,
> Stefan
> 
> Christoph Hellwig (1):
>   s390/dasd: use blk_mq_alloc_disk
> 
> [...]

Applied, thanks!

[1/1] s390/dasd: use blk_mq_alloc_disk
      commit: c68f4f4e296b6011032b4f88d0ce72eb72a6bb07

Best regards,
-- 
Jens Axboe


