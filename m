Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38681C63777
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 18:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D504A2245F
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 18:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="siGSdOXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgKTSpj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbgKTSpj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 13:45:39 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A4CC0613CF
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2020 10:45:37 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id t8so10933323iov.8
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2020 10:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=136mdYMpPIs9zIDUCGF0U771JRyKUiinv1/jgCZE/VI=;
        b=siGSdOXFEVQztjhnVNLt+r7noYr+22MQnpUUOVa6OmFbVPmEb5W+1ZqhZ/4eloQsDU
         xe9dxwKm5CC2SLrNmbIx2CxvhDpiysfIZfPzxmjPmBsVa+aioSnbW37BZP6uvAF2M/5d
         jIRqDeCV6JVa6p0drSCtitvjyhivaPTFj2G6nveWpHWq2e/X6lhjuRRSRIgrmYzcYf9q
         q84T3bpUvsVH2nK3B7KW11o5Ibu08mqakAzKEBf3Wo89JFQcWCE8sZMjvUly/vF1keFI
         Nr7zQjwNuWkv8w/HEksrlYbW9d9OCZVZ5R3Ckq7oui8sSqifbgmj04SRko5NRX17dUC6
         7PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=136mdYMpPIs9zIDUCGF0U771JRyKUiinv1/jgCZE/VI=;
        b=A62zQLtqymrXdxbZD6J6rWHrsH7BsFtvN9iwcn+aysABkQjRHzLq3+dKJru5wF0B6Z
         LPBIfNdq9TalPqFifokM4vRZOxuFEXei7TjGrWAA9ckp+qD4U41rfY94i1wxbHEPQuH8
         Ct1MArlPk58Fegj8RF1YlLIt45Y5rvo++p0hijvvEH9opsK3y/bU7+ErvFO4rUGlETlu
         fuI0MLjU85yTnuRW35EDJspGpaEcphZNRLdGO22LAtTqdARcsdHD0SwUxTk5+f/CWVn+
         TT51/S1tAIG8JrMQrcfc4rgj0ZIyZ0YsuKPiWAZkAncJq4hu146K2ldv4jy79FN5q/Fi
         dNyw==
X-Gm-Message-State: AOAM530M9VkA/u2dSbXvhKV+L/4puyi77Q/pU0J4vAs3V01tIlsegAMt
        z8/og8qh/9AainzaTaomw2xgES/2dN/M+A==
X-Google-Smtp-Source: ABdhPJwqCITI0x1DaolZCaYYIcTetB1se/0OrI2b0dQ+uPdFDUe5oc5rLPr18Fc9MFfTPIj9yDkhIg==
X-Received: by 2002:a6b:f719:: with SMTP id k25mr25452609iog.116.1605897936768;
        Fri, 20 Nov 2020 10:45:36 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d5sm1918768ios.25.2020.11.20.10.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:45:36 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.10-rc
Message-ID: <5e56dcf2-0320-c637-e6ee-143de81f2c41@kernel.dk>
Date:   Fri, 20 Nov 2020 11:45:35 -0700
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

Block fixes that should go into 5.10-rc5:

- NVMe pull request from Christoph:
	- Doorbell Buffer freeing fix (Minwoo Im)
	- CSE log leak fix (Keith Busch)

- blk-cgroup hd_struct leak fix (Christoph)

- Flush request state fix (Ming)

- dasd NULL deref fix (Stefan)

Please pull!


The following changes since commit c01a21b77722db0474bbcc4eafc8c4e0d8fed6d8:

  loop: Fix occasional uevent drop (2020-11-12 13:59:04 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-20

for you to fetch changes up to 45f703a0d4b87f940ea150367dc4f4a9c06fa868:

  Merge tag 'nvme-5.10-2020-11-19' of git://git.infradead.org/nvme into block-5.10 (2020-11-19 09:23:27 -0700)

----------------------------------------------------------------
block-5.10-2020-11-20

----------------------------------------------------------------
Christoph Hellwig (1):
      blk-cgroup: fix a hd_struct leak in blkcg_fill_root_iostats

Jens Axboe (1):
      Merge tag 'nvme-5.10-2020-11-19' of git://git.infradead.org/nvme into block-5.10

Keith Busch (2):
      nvme: directly cache command effects log
      nvme: fix memory leak freeing command effects

Ming Lei (1):
      block: mark flush request as IDLE when it is really finished

Minwoo Im (1):
      nvme: free sq/cq dbbuf pointers when dbbuf set fails

Stefan Haberland (1):
      s390/dasd: fix null pointer dereference for ERP requests

 block/blk-cgroup.c        |  1 +
 block/blk-flush.c         |  7 ++++++-
 drivers/nvme/host/core.c  | 25 ++++++++++++++++++-------
 drivers/nvme/host/nvme.h  |  6 ------
 drivers/nvme/host/pci.c   | 15 +++++++++++++++
 drivers/s390/block/dasd.c |  6 ++++++
 6 files changed, 46 insertions(+), 14 deletions(-)

-- 
Jens Axboe

