Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56868C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 14:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A65D217D9
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 14:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P+GTJCM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfI0OzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:55:11 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42945 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfI0OzL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 10:55:11 -0400
Received: by mail-wr1-f50.google.com with SMTP id n14so3197696wrw.9
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=INiwhswdfBwhnX3GfRB2/BJu62LAjQ6anoNbP7iNves=;
        b=P+GTJCM/nckt4Tp4po9jzQjVOcffrOMLwtRxQKxsGaDEz8KnlugPnd5kM8N6KyDW0k
         xVT9OegPIzCHoLsUlA75wTRHZs5Gp76PO00aKsKNi1EDvabX7FEbMmLBcJ5FxxtiMRph
         6nfBVjZHwhCqMAHuMJke8N50j2n6v1FiTn35EVwplQbmLVFrmwQgBdRkKH0puDcWOuMs
         FNCnAStBuEuNf032XqUc5FIGU76UJpqfdhyiXNweSWlAsceyj49PPyPVsLyTcD5tiDUa
         RbJgB8phMMXCFxJ/fPySvcjfASd8iSSP4XfhQK3iXVbLDIfNv3V8L5A/T+FlfR94RYIZ
         nvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=INiwhswdfBwhnX3GfRB2/BJu62LAjQ6anoNbP7iNves=;
        b=XmCm0Pg24rBj5a2/ZA8YtmKr+fLeUVKHJwive81LO2dMRnPh+3CXzsBoGndYAeaFJT
         J4PN5UHjvXlsDQKDw8t1riQpCJQQvyR4Ews0lUWvNfyLbsjiAYmnhVLnE0NZk21bkSsf
         DDNPfj4U1d4AZIhU43Y2SB7/I6J5QXirgfAeyUT2KNLeqq4J44dyP7832GwO4F9di/Af
         cbzLWOIZW9C5d+YQgDwsWk4lhpP36b6NFxKsdzO5TPkIgKLM5wYFZxuiVwqiOHL9SbVS
         HVwGFkcJrXx7Q1vIiCJ4UqZXdbKMSsLlIYQdnkND0l3fypX+O1OAxOlAJRF1VUTq2fwn
         S4Ow==
X-Gm-Message-State: APjAAAXS89GZKvMeFcfCL6IyW76Ip8elf0zWSOgFmBIdrR706ZukgqKS
        GD/KatqkfencAanNH5McUlDAohEdg7h1DJy9
X-Google-Smtp-Source: APXvYqwAiTQ/cf0f2kXfZXYoZ+6a/CViKXKsnEcSHHNwTXdMBS02cirv1irOYa3APRTxso+dp1rBDw==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr3519262wrw.314.1569596107697;
        Fri, 27 Sep 2019 07:55:07 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id q192sm10514844wme.23.2019.09.27.07.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 07:55:07 -0700 (PDT)
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Final block fixes for 5.4-rc1
Message-ID: <5a77cfd2-3e9b-3a28-1637-e33d3e4221fb@kernel.dk>
Date:   Fri, 27 Sep 2019 16:55:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes/changes to round off this merge window. This pull request
contains:

- Small series making some functional tweaks to blk-iocost (Tejun)

- Elevator switch locking fix (Ming)

- Kill redundant call in blk-wbt (Yufen)

- Fix flush timeout handling (Yufen)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-2019-09-27


----------------------------------------------------------------
Ming Lei (2):
      blk-mq: move lockdep_assert_held() into elevator_exit
      block: don't release queue's sysfs lock during switching elevator

Tejun Heo (3):
      iocost: better trace vrate changes
      iocost: improve nr_lagging handling
      iocost: bump up default latency targets for hard disks

Yufen Yu (2):
      rq-qos: get rid of redundant wbt_update_limits()
      block: fix null pointer dereference in blk_mq_rq_timed_out()

 block/blk-flush.c    | 10 ++++++++++
 block/blk-iocost.c   | 30 +++++++++++++++++++-----------
 block/blk-mq-sched.c |  2 --
 block/blk-mq.c       |  5 ++++-
 block/blk-sysfs.c    | 14 ++++----------
 block/blk.h          |  9 +++++++++
 block/elevator.c     | 31 +------------------------------
 7 files changed, 47 insertions(+), 54 deletions(-)

-- 
Jens Axboe

