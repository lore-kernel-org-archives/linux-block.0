Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F9CC38A2A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF1A21974
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jqkuV8Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgEIDRB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 23:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgEIDRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 23:17:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511A7C061A0C
        for <linux-block@vger.kernel.org>; Fri,  8 May 2020 20:17:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d22so1807166pgk.3
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 20:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6mc+/P7uDuRdnWbGwn7fDTDVPcB/+OpNkx60HSzCKag=;
        b=jqkuV8Im5DOffQo03fBUChgmLfbCNtIji5qWJ3SWqgGq5gMdxA4CuIQz8pXYfM61hm
         z6wc9LOo7Fwdd4nbK81K10SyCwViWTyyHuVK71ihamKr76Yk+lB+YryBpz8nr5KpCkUc
         LzbPp9vXvAi/1XK1f4pFs5NLiut+gVSFqMthOdcY5/2Vh+mw3TGTsTBHH4uRqkKy6mU4
         et2t/Uqxm2Jv3CcL3cy0B5zwW9PApVjOCdIuBJtyCRh5//ld3ZhlwKNfMEvrCZh0l6Te
         QPI9vhBbDfIaMHCrfKgho6Weh+hi+4NreLE9gIF5/Mkp3cS3EgX05ZmCfa/YRyQX4nuY
         Fm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6mc+/P7uDuRdnWbGwn7fDTDVPcB/+OpNkx60HSzCKag=;
        b=FBLhCyOSvTD6HQ7HGQs402Dfyxa5CMjlNltYqFGoohsKGsSB1a4MIy/SlOzkaD8zq0
         MwWse/39azbKC52mSlE1AcavvpHuWNH0LzpDUiF5bFPzrVNz06tObi2WWkTo5yvBUGNg
         clIcuuHLmzhFHPDl1ekc4saWpfL4SCQNNod46MgEvGlIvwnim2V3lswsD2oiCMyvLBb3
         E+lJ0HtqNhdBHVm6pxS1IEf6ajVvkWAqOx/i7E44MShbJaQNr7L5u2tTtgeyK/197wZd
         CTKgZVoeTcLR+BcbrsxPCc19QjrMgLUgTFHboStgJH4GTJLgvEAE8vVQXZKDJZjgIxsZ
         3c6A==
X-Gm-Message-State: AGi0Pua1uSmCYWOD0xvhQw2pCxtsz/p/cMrmGYgsCBbm5WS1O8GboN99
        kOQtS+q+kGJHbo0pnxwBdvM47Dr3CQo=
X-Google-Smtp-Source: APiQypKeO1dY7BmFdWnq4h2XyiZ4EDrRGsxH0esPKGPQmwTaKZmHddzM6P20yLg2CrAP57fhk353YQ==
X-Received: by 2002:a63:5445:: with SMTP id e5mr4743077pgm.185.1588994220436;
        Fri, 08 May 2020 20:17:00 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q62sm3570295pjh.57.2020.05.08.20.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 20:16:59 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.7-rc5
Message-ID: <cc854168-7859-49f9-63f7-dbaaff8fbb3d@kernel.dk>
Date:   Fri, 8 May 2020 21:16:58 -0600
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

A few fixes that should go into this series:

- Small series fixing a use-after-free of bdi name (Christoph,Yufen)

- NVMe pull request, fixing a regression with the smaller CQ update and
  a hang at namespace scanning error recovery

- Fix race with blk-iocost iocg->abs_vdebt updates (Tejun)

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-08


----------------------------------------------------------------
Alexey Dobriyan (1):
      nvme-pci: fix "slimmer CQ head update"

Christoph Hellwig (3):
      vboxsf: don't use the source name in the bdi name
      bdi: move bdi_dev_name out of line
      bdi: add a ->dev_name field to struct backing_dev_info

Jens Axboe (1):
      Merge branch 'nvme-5.7' of git://git.infradead.org/nvme into block-5.7

Sagi Grimberg (1):
      nvme: fix possible hang when ns scanning fails during error recovery

Tejun Heo (1):
      iocost: protect iocg->abs_vdebt with iocg->waitq.lock

Yufen Yu (1):
      bdi: use bdi_dev_name() to get device name

 block/bfq-iosched.c              |   5 +-
 block/blk-cgroup.c               |   2 +-
 block/blk-iocost.c               | 117 ++++++++++++++++++++++++---------------
 drivers/nvme/host/core.c         |   2 +-
 drivers/nvme/host/pci.c          |   6 +-
 fs/ceph/debugfs.c                |   2 +-
 fs/vboxsf/super.c                |   2 +-
 include/linux/backing-dev-defs.h |   1 +
 include/linux/backing-dev.h      |   9 +--
 include/trace/events/wbt.h       |   8 +--
 mm/backing-dev.c                 |  13 ++++-
 tools/cgroup/iocost_monitor.py   |   7 ++-
 12 files changed, 106 insertions(+), 68 deletions(-)

-- 
Jens Axboe

