Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF2FC433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 17:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08FD206D5
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 17:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NUfqHVsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgEVRIj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 13:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgEVRIi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 13:08:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CC3C061A0E
        for <linux-block@vger.kernel.org>; Fri, 22 May 2020 10:08:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x11so3634611plv.9
        for <linux-block@vger.kernel.org>; Fri, 22 May 2020 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0gGbPjVIKb0ppLj5bKrwqYuuVIDYRhq+f0+5o5BY50g=;
        b=NUfqHVsFFC94VLFoj/kJI1r6yJRWEbPlAMqsjCNuKgz4se3GsIods9MzV/wNli43QR
         ak8U/q0Gqnx+7+NuRxIVdx76P9jKEtfXoc8neD9LQVNnxcPE1FhvyLFx1zae2qTkKzR4
         eU9Yk5CGgKOauUX7jLZd8kNKEF6mXUv6jdM2FlYRG7AgpKKlkdZW1RmqjnZndD40AAGS
         /plnD1F3DfaGvcoa5ruPv3S7eqXGG7FVtqaT1oXlELK6LvyNEROpiJk6T3V+4d3AWkzs
         lpAj7HyDaax9ySmQCsVEUbcrv+UwTNl0Bn6EfJJLLPftrEBZX674bmeyomWXUDZjPK8y
         juAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0gGbPjVIKb0ppLj5bKrwqYuuVIDYRhq+f0+5o5BY50g=;
        b=MrRW6WrT/vtlHegY312HvjxeJ4PC+ki70PoxqO0Lkgq3w0pIHBKxlfWCrsngzShcHI
         9Kpi0CNYnLFMDXlFeNSAWgJ/stJ6IDlQO2U8paTmzrLNQIchu1nuzq9mMq1aQbsc4WCM
         dNAtPbSl+B7Hz7qdOnSqrOIUAFHMHPSVSiWDEgck6eEexRZ7jNfoNaor2j6Ns5cd+x/2
         dUw2RIXdw8DAOEFuQ/a7ooSx73XoJG7rv2+apqaSB6ijo4gqHi8m1Je3A57lW9BCtYfb
         9EymjwTbuFnCtIUhzkaCxwD7W0QXU4o6ZplSY2/kXsvy67e2mauScgT/TDkufCEI8yPK
         v3mQ==
X-Gm-Message-State: AOAM530m5sQl6x//trIS4zRImuPfeHRB/dqtdR4x3ak9MLrFZXvfTBYf
        t7XqdSzpo7oeVwtw5tKeZ5nBA27q7NI=
X-Google-Smtp-Source: ABdhPJzBrlEMsjINYtfL8igkMwLqyoUN2oNb6SAIwAx597gqoEZgA7TbaDCwrkNgdTSN4m35EjTy8Q==
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr14436393pll.252.1590167317908;
        Fri, 22 May 2020 10:08:37 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:892a:d4e5:be12:19f? ([2605:e000:100e:8c61:892a:d4e5:be12:19f])
        by smtp.gmail.com with ESMTPSA id v9sm3104099pgj.54.2020.05.22.10.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 10:08:37 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.7-rc
Message-ID: <6efa4314-0dc4-8d77-0b28-bf53287cf6d0@kernel.dk>
Date:   Fri, 22 May 2020 11:08:36 -0600
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

Two fixes for null_blk, for zone mode.

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-22


----------------------------------------------------------------
Chaitanya Kulkarni (2):
      null_blk: return error for invalid zone size
      null_blk: don't allow discard for zoned mode

 drivers/block/null_blk_main.c  | 7 +++++++
 drivers/block/null_blk_zoned.c | 4 ++++
 2 files changed, 11 insertions(+)

-- 
Jens Axboe

