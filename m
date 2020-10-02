Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E27C4363C
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 17:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5C6206DD
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 17:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pxT99LNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbgJBRrr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBRrr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Oct 2020 13:47:47 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FEDC0613D0
        for <linux-block@vger.kernel.org>; Fri,  2 Oct 2020 10:47:45 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v8so2426940iom.6
        for <linux-block@vger.kernel.org>; Fri, 02 Oct 2020 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rv5qVj3+rF5ltroQE/F5cU/WaAvUhON77A31FZqvAZk=;
        b=pxT99LNCA1I66d/VaiCp9y9oQDM6llWuipEoaBm9aGmWHNQekHPU1RrHbgrBzW57cR
         Qi9r6wLBuiFHxs/jQp35XI6lmj7RCKl8n/lHlHOBy06RbMjlXNouLbjqqdORGgZYAVOZ
         ODcAqKrC+aq8CqxIR3NImJtimeCmzutG8vBXPDHKSr2FGREYquY2wTdFnkZKb3wm6D08
         7kOwVGJ+VwKtpaNjMef9CnGX8RJrf1YILQqFHmr/AQUnl44QDWvw4W1k+MkN7ZqFuHk2
         t5Dw+4GMkCNSWPbwgYufKBaAveunXtWiamBzHy7PIJ5kBzKmnR2HLUXCGTgjq5HN4GgB
         pg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rv5qVj3+rF5ltroQE/F5cU/WaAvUhON77A31FZqvAZk=;
        b=jxxx+81i/YsV5XRJ4NbwRCZudkyA317SVhcHdbHTA2eQFoJh0JaQCvzvbhL08tOs/I
         dY4c0xM8EPy7w/fTmcS3szRGLOFcm76BUAqvhONuWBGBSmBs0kU39ewZY/R3+Df0luUy
         O7Q8vi5RLsSIIBf8op4PsIBPSzBHy+IcEY5INR4blv1H2kaDmtQ6LD8lmPnnoD1hq+tw
         ooE+pUX4453/ItmBIv0PwwM0gG2f0YKpN61QcK1jFNLufMjJYicSv1Io0VtbDBGNvmrk
         1yN/EuJ7Q7akttZ7yceocEhku0GSFrQG774Wog+gMrA+dxOX8LnFkrwCF0nLUfnMCs0n
         EaFg==
X-Gm-Message-State: AOAM530RD7fRnVy2yVtCa6ChPPJEBFcYKSxh1Mq5MwWHQRy3QMPONCLm
        qtdc61gNplgunq8/wcr+l9UYA720YHydaQ==
X-Google-Smtp-Source: ABdhPJw3Cv6JvIcN7c4cZ3ixQLbFNVEK0OapWBoywHQQ/W/IonuOwRNyQb5IXL4C86V4zdxS1AwYpQ==
X-Received: by 2002:a5d:8b46:: with SMTP id c6mr2812606iot.69.1601660864935;
        Fri, 02 Oct 2020 10:47:44 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v78sm1052336ilk.20.2020.10.02.10.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 10:47:44 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.9-rc
Message-ID: <5d07d1d6-174d-f131-71e7-712c207ebcf2@kernel.dk>
Date:   Fri, 2 Oct 2020 11:47:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Single fix for a ->commit_rqs failure case.

Please pull!


The following changes since commit 3aab91774bbd8e571cfaddaf839aafd07718333c:

  block: remove unused BLK_QC_T_EAGAIN flag (2020-09-25 07:54:50 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.9-2020-10-02

for you to fetch changes up to 632bfb6323799c087fcb4108dfe59518609667a7:

  blk-mq: call commit_rqs while list empty but error happen (2020-09-29 08:10:17 -0600)

----------------------------------------------------------------
block-5.9-2020-10-02

----------------------------------------------------------------
yangerkun (1):
      blk-mq: call commit_rqs while list empty but error happen

 block/blk-mq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
Jens Axboe

