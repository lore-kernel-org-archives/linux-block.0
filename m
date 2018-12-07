Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4330C64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 17:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A955B2082D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 17:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IJu623Js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A955B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLGRMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:12:18 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36775 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeLGRMR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 12:12:17 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so8142723itj.1
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vKa5PHov7BprbOpL1iXxycLACjcMMmy0V+ilOiYPFhY=;
        b=IJu623JsyPvXWlGzEc+AKyPcLIigCSvEUIohct4VgnyU/U75tLkfmuRPycqAwcpUEk
         HGagLwV4/YRrahi5pPZ1qL/BUzCEMMqCnYfEEjU4+Z081ZkAqLsQg5/+3A0rrf/sUCDk
         uDVFRHkwQEb8vAC1bzJuQldCb72RGyLPdUshEHIQO7lTHtEwcudklEje9H//hnExK9+a
         wpMv79DNOZp8JAhOQF9PuLLZa6RytgRWR0RkIV7KpfJ4LT1L0RZ1HUd4qfwRBrV1FmzU
         na6mvB+PtJ+7kxUjlryXeh8mOKN7kYsEPYXGVObzw62FVixIIcrOTE7bE+jtJvL8TOuZ
         Tv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vKa5PHov7BprbOpL1iXxycLACjcMMmy0V+ilOiYPFhY=;
        b=qGNnJL/aoIHAaZKTlD5m4FpiTIVONPwNYxuKSw5bLANml3t5T8YCxmEhqKVOwawwgZ
         1cxgjSSNHjFm5fuPaVk0XriK2uuX1YA8kXn/XHZUPWHs/wkunvjrrydheNMiLa6vT6qN
         uegprs4RM95evQlN8U+PGWnfZa9oSERPzhq6hT0D5YKj5e7FAgzxI3KQLDA+hHvY+H5d
         rVgWQJc9owF4CIn0XtTgWui2I15sBCy906V5zUGfv+PLzSiuXjjk1e6rWtkmNGF7xukM
         jKl1l4El8WAy1lX72axCu/UupTTJptNyMyw1ceW4GSHahdhjRIyY+EZu9DisfiF3zYzf
         +i8A==
X-Gm-Message-State: AA+aEWaVxTw4Y7Gu+eyRG9foQiJi06YpMFE80lKck/MSBtJNHUf1z+7m
        wLWdLfgS5qMoeP6cLzgj1ynz7se6dx0=
X-Google-Smtp-Source: AFSGD/W21eyJ+7F9o7brDffEsiFFkhChuzxMCfxolExXWK1ndWx/S3aAT7c/oZjfHpg9TV7wVeJPPQ==
X-Received: by 2002:a24:9fc1:: with SMTP id c184mr2707612ite.8.1544202735394;
        Fri, 07 Dec 2018 09:12:15 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t64sm4217458itb.5.2018.12.07.09.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 09:12:14 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.20-rc6
Message-ID: <8ebbe50a-9f33-21e2-0747-e461cecb40cd@kernel.dk>
Date:   Fri, 7 Dec 2018 10:12:12 -0700
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

Let's try this again... We're finally happy with the DM livelock issue,
and it's also passed overnight testing and the corruption regression
test. The end result is much nicer now too, which is great. Outside of
that fix, there's a pull request for NVMe with two small fixes, and a
regression fix for BFQ from this merge window. The BFQ fix looks bigger
than it is, it's 90% comment updates.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181207


----------------------------------------------------------------
Israel Rukshin (1):
      nvmet-rdma: fix response use after free

James Smart (1):
      nvme: validate controller state before rescheduling keep alive

Jens Axboe (2):
      blk-mq: punt failed direct issue to dispatch list
      Merge branch 'nvme-4.20' of git://git.infradead.org/nvme into for-linus

Paolo Valente (1):
      block, bfq: fix decrement of num_active_groups

 block/bfq-iosched.c        | 76 ++++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h        | 51 +++++++++++++++++++++++++++++--
 block/bfq-wf2q.c           |  5 ++-
 block/blk-mq.c             | 33 +++-----------------
 drivers/nvme/host/core.c   | 10 +++++-
 drivers/nvme/target/rdma.c |  3 +-
 6 files changed, 123 insertions(+), 55 deletions(-)

-- 
Jens Axboe

