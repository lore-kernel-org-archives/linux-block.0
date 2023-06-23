Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DE5EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 23 Jun 2023 18:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjFWSwI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jun 2023 14:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjFWSwI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2023 14:52:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8B8199D
        for <linux-block@vger.kernel.org>; Fri, 23 Jun 2023 11:52:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b50a419ab6so1379425ad.1
        for <linux-block@vger.kernel.org>; Fri, 23 Jun 2023 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687546326; x=1690138326;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SNxTz1oFauVPvNiVWRIfhE/XRZR9Aw9V331nHi9QOE=;
        b=XpdGxOmCOvgG7AuF6vqzEceoN6pjR04hvi9mTO3ehwjcTSHi2tLTzKsq61A7MizZdj
         Y5hDAJnnBhnhkjdShReWFJCX5FwPwQC8AIoG/e9N4slP05Y1qFFocrBs4OEwem5WgrWB
         vL9GSDx4H8vc8+eNhuRJCRoaCppspAHIECH0ubAiBSgXrhgdxR33RvS2DN6y3vcQpC+l
         YVj2BBQytadz2EgCUJ1nGCp+1+ZEPnvUR/nPaUZ8w12ckCs/oXLPJc9gxBT9i6qNF6Kg
         D5/iXTNlZhfiZTh4DbZIhal+k6v2quGCrV6136y06cHps47ZFZLkMnEsn/o6gc6i29+0
         Opng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687546326; x=1690138326;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0SNxTz1oFauVPvNiVWRIfhE/XRZR9Aw9V331nHi9QOE=;
        b=jkUnBFHqkhzB16TpW3MQz7g7WdfIYY/HLVtobcWLCQYBOts5Lc4T+rgtYHOs1uRa1N
         XLphHJ9l+0nOgh82peV/g2i1JJps81kpNPHxlMpP5XtbHfdCzhl16B6mD/Albl7dE+Ve
         DEWEY3WVStY2VMOcmbVty7/x2VVpfgIKnfcJV2/kvdMaTBv90pjquxxDf0IJ2tPm4Ua8
         H59s/KaOprzt4NPLt0vhdqhjLXUc87b6MRwFoPMDlfhqLk9FJJH6EKNpJKQwhy67ix/3
         iqhD/sbuyX7eGpE+IW7Q0T50ULZN712AYfEmwuVmGu+NNWOBjcp1ubYftV6kkaDCYZLG
         /Tpw==
X-Gm-Message-State: AC+VfDz6pvMUUH7uOaN49SFiDRbjiB/lwCOUeqDdNKNoTWreajKgwhLE
        QEm2aptKgI4PRRqs+sY6SBRBITT6k0KcZChfFE8=
X-Google-Smtp-Source: ACHHUZ5ihnKSReJdhqlKPI9Y7ppOsd5asxe2Jdq2c+n+PTVN/T7AmQGqvj81rVvJMzt9pfbG4lYKBg==
X-Received: by 2002:a17:903:1105:b0:1b3:ebda:654e with SMTP id n5-20020a170903110500b001b3ebda654emr25711774plh.5.1687546326393;
        Fri, 23 Jun 2023 11:52:06 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090311c800b001ac94b33ab1sm7508385plh.304.2023.06.23.11.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 11:52:05 -0700 (PDT)
Message-ID: <19981b0a-f3e2-ec8a-f413-5a9697472750@kernel.dk>
Date:   Fri, 23 Jun 2023 12:52:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.4-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

It's apparently the week of "fixup something from last week", because
the same is true for this block pull request.

Fix up a lock grab that needs to be IRQ saving, rather than just IRQ
disabling, in the block cgroup code.

Please pull!


The following changes since commit 20cb1c2fb7568a6054c55defe044311397e01ddb:

  blk-cgroup: Flush stats before releasing blkcg_gq (2023-06-11 19:49:29 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.4-2023-06-23

for you to fetch changes up to 9c39b7a905d84b7da5f59d80f2e455853fea7217:

  block: make sure local irq is disabled when calling __blkcg_rstat_flush (2023-06-22 07:44:00 -0600)

----------------------------------------------------------------
block-6.4-2023-06-23

----------------------------------------------------------------
Ming Lei (1):
      block: make sure local irq is disabled when calling __blkcg_rstat_flush

 block/blk-cgroup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
Jens Axboe

