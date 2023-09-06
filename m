Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3797EB8FD4
	for <linux-block@archiver.kernel.org>; Wed,  6 Sep 2023 13:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbjIFNdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Sep 2023 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjIFNdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2023 09:33:24 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D534910D3
        for <linux-block@vger.kernel.org>; Wed,  6 Sep 2023 06:33:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a4dab8172so733470b3a.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2023 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694007199; x=1694611999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d1AVNOFHn3CVQlqf+iRc3+VoRUq4zvMLJvgQBKxvDg=;
        b=Jt7mcQ7IhF/DJgXtjWDb+uyNBOWMANCt47hePVfclaKDOu/Oi+1uxlYifbjY5D/96B
         VDNghZ+i/sRiHDBMDFaWHceHRmrbBEnYyQ8xJkrcSH8ed7fDVsl4y/+QIrbCbZciNAWh
         EdZiEMPWqo8Y+iTAd6BV13C86yybTv7LQFc2qVnJdi5qyq2/TJibUoyHTsUEnsayECTr
         IGG1Val3hypMCGEHW3ouKqfe15sN9WCsAASE0Ac5EeDXW1FUx3W6lvsV5mn3hZ3jFTry
         h0il9AcnELKa26e55cvxogAdQs8OTrrXBZavx3lGuubEV7bkxbtwCEy/NswJqftIrayA
         QiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007199; x=1694611999;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+d1AVNOFHn3CVQlqf+iRc3+VoRUq4zvMLJvgQBKxvDg=;
        b=VoChtIbBwCN12cOVbWGO1MJ+PHnBKziLUg6qpxwqCF1Iiq09KECxgP3nPI2VCEIbxp
         gSUsKGXDKc2mfFLQJ2CeYLv40awbdCcW6MZMHCA3B4lUwli7/W2PkwHHSViTN1I1byCp
         ZOhJcdUV6BuKJDQ5u3GP3ZaJ05EZwd/W1Les0dhm3YPCz5O7C2kEZEMldpMBfRq27IVT
         guW1UMN0qGyN3a6o/adr8YzKyvgvQeD6wBRH6s5CAOPnloRyDLLZxIaIEan5n7C3mq3d
         r7UkXrEgG9rKNRtzE7wlu9WGNGi9NIJRG6gXUuCff1Dr5JaIKNBlRqwI1gHmOUbkM+r2
         LByg==
X-Gm-Message-State: AOJu0YwchUY9r8+LIeokn6pESFk8Qmz1hpn2bFG2UkYDS66JiNOPJjS7
        A/MPYDoB32YVjtn3z8/xJ//PKg==
X-Google-Smtp-Source: AGHT+IGi5OBROtUZu1lj7ctF+BKO/WjvIApR6wS2hhjSxwyTHuQMfAXh945M7deKizfytAdi93Ewcw==
X-Received: by 2002:a05:6a20:8f15:b0:13d:7aa3:aa6c with SMTP id b21-20020a056a208f1500b0013d7aa3aa6cmr21240577pzk.0.1694007199312;
        Wed, 06 Sep 2023 06:33:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b22-20020aa78116000000b0068c10187dc3sm10726107pfi.168.2023.09.06.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:33:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Linux regression tracking <regressions@leemhuis.info>,
        Serguei Ivantsov <manowar@gsc-game.com>,
        David Howells <dhowells@redhat.com>, stable@vger.kernel.org
In-Reply-To: <20230906133034.948817-1-christoph.boehmwalder@linbit.com>
References: <20230906133034.948817-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: swap bvec_set_page len and offset
Message-Id: <169400719806.700937.1715411703006180940.b4-ty@kernel.dk>
Date:   Wed, 06 Sep 2023 07:33:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 06 Sep 2023 15:30:34 +0200, Christoph Böhmwalder wrote:
> bvec_set_page has the following signature:
> 
> static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
> 		unsigned int len, unsigned int offset)
> 
> However, the usage in DRBD swaps the len and offset parameters. This
> leads to a bvec with length=0 instead of the intended length=4096, which
> causes sock_sendmsg to return -EIO.
> 
> [...]

Applied, thanks!

[1/1] drbd: swap bvec_set_page len and offset
      commit: 4b9c2edaf7282d60e069551b4b28abc2932cd3e3

Best regards,
-- 
Jens Axboe



