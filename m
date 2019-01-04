Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886CDC43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 21:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E07321872
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 21:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JXmZYj7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfADVa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:30:29 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:38694 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfADVa3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 16:30:29 -0500
Received: by mail-io1-f50.google.com with SMTP id l14so30585989ioj.5
        for <linux-block@vger.kernel.org>; Fri, 04 Jan 2019 13:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LdXRPU2TcB1MD0N/ZfF7MHUrayCZOC4dBbnIW01pmLI=;
        b=JXmZYj7cyiYyaajLIh5Tr1m14jcryOeZQoT4I0U8OnuIKDrsemd25yiMdmhHp9Cf6N
         qaEzedXc9xrjmliiqdvwtGiZa2jaeswgVjFi51Cld8yEIUOp9NyrcrRuZjpLYjo9JBOQ
         qxk2aBhaIQNQptL374Xin4fs+ZB1haPRo+XhsKCS2pDtqogNYbQZfdt1TnqvHeBwRebs
         LqYPC3x2UfDYETgVDgZk5WVbPNJNYoEsuog5Br3vL2ICdWp5e1Ls08NQIUBBJ+oTKuMi
         NIWTwGgrv+dVJ4s66Lmz4Epj1CpsfOXogqSYfTR+6/5WB4/W7gBSu39HzUzDigc0L1ol
         3JzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LdXRPU2TcB1MD0N/ZfF7MHUrayCZOC4dBbnIW01pmLI=;
        b=lblzTIcoH7hq8PPgnMAF8IlhgCaOO4EmQnF1m8sYvuWAKPuEKZYga8v92LzxKqXvHJ
         SWl5jRMS1grP2Hg2UzdSuAFaoRXmK4ovNMs/Ccpa11vCmODnd6qUm77f2N/MjZ3eFW3g
         3Ss6dxturYUrktLt4hbCJcM4hkpbrBaXZQTCBszNOpktXM74zsduFi0o3aSZlDlkb/fy
         9reXDhBa2E9AEfdWgO2TFn49V1a+EsepJ37qHi27AtPQZwIwJE8X4L7hiboOoytUMBis
         D6gwkXK00+rwMgepb/qOOVLAuB9imWCgv4mCVq9iyT9yZbgW6ZapEFGa4V5RIfKDamlC
         3QHQ==
X-Gm-Message-State: AJcUuke3LPZDoCCvuFi4TlnuBWbEfvzXR4KdeuC9PT58EIUKGaXwIOvC
        gsk1N0XTdj60c6znKqmFm2HO9q0+p3nICg==
X-Google-Smtp-Source: ALg8bN5DKGYp59ns6XsuQcnEivAbGA2friiMua7jpGATOEs3dEGRCh4RLi4cJfTStjYi+HUC8mXdjA==
X-Received: by 2002:a6b:cb08:: with SMTP id b8mr34928516iog.200.1546637427574;
        Fri, 04 Jan 2019 13:30:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e68sm1001813ite.7.2019.01.04.13.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 13:30:26 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes
Message-ID: <03b6bedf-e57b-0449-1e27-1585720f0432@kernel.dk>
Date:   Fri, 4 Jan 2019 14:30:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Final merge window pull request. This pull request contains:

- Pulled in MD changes that Shaohua had queued up for 4.21.
  Unfortunately we lost Shaohua late 2018, I'm sending these in on his
  behalf.

- In conjunction with the above, I added a CREDITS entry for Shaoua.

- sunvdc queue restart fix (Ming)


Please pull.


  git://git.kernel.dk/linux-block.git tags/for-linus-20190104


----------------------------------------------------------------
Chengguang Xu (1):
      md: remvoe redundant condition check

Daniel Verkamp (5):
      lib/raid6: add missing include for raid6test
      lib/raid6: avoid __attribute_const__ redefinition
      lib/raid6: check for assembler SSSE3 support
      lib/raid6: sort algos in rough performance order
      lib/raid6: add option to skip algo benchmarking

Guoqing Jiang (2):
      raid10: refactor common wait code from regular read/write request
      md: fix raid10 hang issue caused by barrier

Jens Axboe (2):
      Merge branch 'for-next' of git://git.kernel.org/.../shli/md into for-linus
      Add CREDITS entry for Shaohua Li

Ming Lei (1):
      block: sunvdc: don't run hw queue synchronously from irq context

Yue Haibing (1):
      md: remove set but not used variable 'bi_rdev'

 CREDITS                 |  6 ++++
 drivers/block/sunvdc.c  |  2 +-
 drivers/md/md.c         | 14 +++------
 drivers/md/raid10.c     | 76 ++++++++++++++++++----------------------------
 include/linux/raid/pq.h |  8 ++++-
 lib/Kconfig             |  8 +++++
 lib/raid6/algos.c       | 81 ++++++++++++++++++++++++++-----------------------
 lib/raid6/test/Makefile |  3 ++
 8 files changed, 101 insertions(+), 97 deletions(-)

-- 
Jens Axboe

