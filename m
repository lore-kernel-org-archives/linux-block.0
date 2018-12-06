Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2452BC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CC020989
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L05+vlXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CC020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFSSd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:18:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35740 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFSSc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 13:18:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so2060840wmh.0
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 10:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x43sXtJKZfNFoIjdrUgoUaVnk5ggsAeA66Y8BOJoHGs=;
        b=L05+vlXczJ/Fn+1uVTe360qP/sxvCJn17zo6TmqqYeH1VpEdeYM0vihF8pxC1T9TLz
         YEhfIXkHvoK4SdBBL30hiTxA1pTTG7isKBu64WV+w9bRAhnMNhvzovjcf780CPnEJH7e
         wnAFXCRsfCX9w/wwzv+oGqDfnFs3Pe5+cLz+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x43sXtJKZfNFoIjdrUgoUaVnk5ggsAeA66Y8BOJoHGs=;
        b=aTGorSdJBmbris0GKrZqFxSoPxMsA7s89z61nsnJU6rEcmXJ/GDyhJ8jl6DQRiNQsS
         XLRHH33/z11/aCumPNVqlxo9EkO8PfQo69CVj4J9k2vxMbHwxJPNlVU6HpPWpMkSs2So
         izovhl0425IBguKZU8w9D649mJes0PxOmg34QAtoWTYYK56BQwg5K5fPzKyVhwGlXnxK
         ayjwBNGePjM5Io8QLCb3G3RxOVzjpwS4ijx6Bg95QzwV+I3g9pcjauryjgK+HF8VI9px
         zcjz2aVQDO4es0GzuT2iAXxlvlroxh5+g3D714v6QLyFfexSr5QH9D0xk35DYtCxqkFc
         IAUQ==
X-Gm-Message-State: AA+aEWZK88eJB2ZaGuljqiY8wTyHvhMjvfGwSBoJhp/M2wyerR5X57Fm
        POmuZxMgLRXKMEThOKvzd1k1sA==
X-Google-Smtp-Source: AFSGD/WCif5TaD8RKNkznpmLlzDPi+AXGqmz6CoiMyVGWdbAYWJKGANRR8xj5agFllsam95mxsIqtg==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr19919765wmj.145.1544120311088;
        Thu, 06 Dec 2018 10:18:31 -0800 (PST)
Received: from localhost.localdomain (146-241-0-214.dyn.eolo.it. [146.241.0.214])
        by smtp.gmail.com with ESMTPSA id w18sm727733wru.54.2018.12.06.10.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:18:30 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, federico@willer.it,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/2] bfq: fix unbalanced decrements causing loss of throughput
Date:   Thu,  6 Dec 2018 19:18:17 +0100
Message-Id: <20181206181819.11148-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
the first patch in this series fixes an error in the decrementing of
the counter of the number of groups with pending I/O. This wrong
decrement caused loss of throughput or, less likely, of control on
I/O. The second patch is a fix of some wrong comments, which somehow
contributed to making the above bug more difficult to find.

Thanks,
Paolo

Paolo Valente (2):
  block, bfq: fix decrement of num_active_groups
  block, bfq: fix comments on __bfq_deactivate_entity

 block/bfq-iosched.c | 76 +++++++++++++++++++++++++++++++++++++----------------
 block/bfq-iosched.h | 51 +++++++++++++++++++++++++++++++++--
 block/bfq-wf2q.c    | 16 ++++++-----
 3 files changed, 112 insertions(+), 31 deletions(-)

--
2.16.1
