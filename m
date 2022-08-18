Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1FDC00140
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 10:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbiHRKz4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243613AbiHRKzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 06:55:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018058C474
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 03:55:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so1301059wrh.3
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ksVlvId0YTvF7f5xsAy5+jgvuwgxLHE1yytq8bAKYaA=;
        b=JwGn1tlEiTvx4lWffF6NUw9+0IoCuAHQvv07kkWztCYcwH3SvtmFoIANZXhiEeK7tZ
         WCHajadjNtgmLV6V4feu3x+R9SMg15BN+mibUgzlvih7G4dIGSLrKO84+T2p9aFZyUk4
         DyIeMHSC50D7qgvDMbpruTTJm9gEd282VhEy6e3BU7Siq0UDMajReZWMFZTp2h/hNust
         qfcvlPaaDiAX6tioS8EY/c+uyTzIfVz5D09F8yOrB5e8Y+XGb6MTnkZCl59y5a3+5Sun
         JERH0Y4jNxRPLfqjXzQyXJJ87kSjdVh2HDjWzUE9oGFoNcAe3PJOgFCD1Mv9yj+lz53o
         94RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ksVlvId0YTvF7f5xsAy5+jgvuwgxLHE1yytq8bAKYaA=;
        b=d5u1vj9ethcp7akNMHzdJPKXQCgJzyZbWjaK72qge4gTzItaINn2WdmT6AUE2XtQ0v
         jABWuwXMWLRFC8wMKxNkK643YPuHsOfilgr2M72fBf9vOw6YZki1RxQ1/dVb++7JAjga
         ju89PYJ1L9vLrr1hgxbP/m3sPaDJGtQsOytVaDxanBZZ0qpZBVmo0d+ruaIpv16/EfIg
         IeD2cGJpAXA/5+efgvDFtmg/s/q6M0zpX4paAtI30o9O91nucEIjJSsTYW/lvZxFQ7jr
         jDVd0IaEtfXjvbfRWrETyXTnLc8DS38T1lrppfUl43Tn3mWt3SAouBJNKZYQtReGtA5R
         LCSQ==
X-Gm-Message-State: ACgBeo28FWUWhDq8AFQP9djTQDFZin4NwzUlG2oL9T+aaTQvkAtmDjfh
        s7VP+hE7pd6dA0So0rYnQPves5O4I8ZP/g==
X-Google-Smtp-Source: AA6agR5jj8xkU6PWcW4g61f0NhkvUFUpVAkk8YdECQc4LeQ4zip2SWFIBCDlF7nLabOylu3eRH00zA==
X-Received: by 2002:a5d:434a:0:b0:21d:aa7e:b1bb with SMTP id u10-20020a5d434a000000b0021daa7eb1bbmr1378880wrr.619.1660820153498;
        Thu, 18 Aug 2022 03:55:53 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003a5ce167a68sm5114085wms.7.2022.08.18.03.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 03:55:53 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 0/1] Add trace event support to RNBD
Date:   Thu, 18 Aug 2022 12:55:50 +0200
Message-Id: <20220818105551.110490-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please consider to include following change to the next merge window.

It adds trace event to rnbd-srv

Santosh Pradhan (1):
  block/rnbd-srv: Add event tracing support

 drivers/block/rnbd/Makefile         |   5 +-
 drivers/block/rnbd/rnbd-srv-trace.c |  17 +++
 drivers/block/rnbd/rnbd-srv-trace.h | 207 ++++++++++++++++++++++++++++
 drivers/block/rnbd/rnbd-srv.c       |  19 ++-
 4 files changed, 241 insertions(+), 7 deletions(-)
 create mode 100644 drivers/block/rnbd/rnbd-srv-trace.c
 create mode 100644 drivers/block/rnbd/rnbd-srv-trace.h

-- 
2.25.1

