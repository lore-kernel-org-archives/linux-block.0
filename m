Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC47C3F6B0
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 17:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350685AbiHSRu5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352096AbiHSRuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 13:50:24 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC2AB8A4D
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 10:22:54 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id x64so3801215iof.1
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 10:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=q8sJR8gXavOrGZsDrjKFF5EsRyTFqne1wiWYwC1pfYA=;
        b=4FpngKmeV7hc5uqB8vGhjXzxxQdg/jugb3T4dEOjXjvNt7BpnGRY8/Z66X+24FB684
         wOL5YIsYUdM/zE2qUVaU6v/Q+8olwqbqZQfZsfrb3L6S9HiUz2azVbQvRe5rXdBXF1lI
         jGPG2EJsuHwyMMpSgy5OCvUi3tORTwr3Pv3KPAHI5ACulhufVDFLoB+hxUobYg+qulC4
         ABplNoX8Tx536NxtF88n71QMvO8zZqGNHvWRk1k599g6wymegilVyJt7f/ttiT15XEOg
         OOvNtIwru1dypbDqRUsgMUJw1lce9X6ItTDt1AsFTPUbB0qlc35iF79S7k0sxgfKHfBb
         ZI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=q8sJR8gXavOrGZsDrjKFF5EsRyTFqne1wiWYwC1pfYA=;
        b=m61RMGYzyOZNP4A2aNf04ZjHvwAB/rI60+uRoJGwQZyLccs0/NMsObJPoZ3Pal6VvV
         XC649KObgE/Y2PFKhmThTirMbw7IDvqtanBMNe1+sQmopE8aR0kprzlWgI7PIPbxDBTG
         zQAm+uy7jVgVkynQHwUsVX++9bX4KeLiHv6svtrbWUMklM34Xih9WZe9HWrUW2AiXeIZ
         5pCAuLs+FlumFBYqtPXGsGpoenQFouLNHIrOL7IqSrbA1aIFjN1cLSulGY8cZMT6ytLS
         gWANgbIY0xrOarN+SbYIbWKc5ezUlxH6OsRvdHZJrMyQ+hAczAZSIpGqmw7XyJBo4upp
         w3eg==
X-Gm-Message-State: ACgBeo0wwADNcZ+GToDV77gSxxZ2u5lQrmPTUz1GVFv69hEdFJiF/jzc
        YGtKgVhhAp+50uvJhmw0cCIJbOSoD7gWAA==
X-Google-Smtp-Source: AA6agR7XKM7NT6lcHK8O05tRu1a4JVT9FtSQZ5+X2gydqLiRw0q821h4T4T4QB5BEQ7cSGiR20prWw==
X-Received: by 2002:a02:a706:0:b0:343:4ae1:a290 with SMTP id k6-20020a02a706000000b003434ae1a290mr4049732jam.81.1660929773638;
        Fri, 19 Aug 2022 10:22:53 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s16-20020a92d910000000b002e949936411sm591139iln.26.2022.08.19.10.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 10:22:53 -0700 (PDT)
Message-ID: <5934f325-077a-8786-2873-4cea178641ab@kernel.dk>
Date:   Fri, 19 Aug 2022 11:22:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.0-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes that should go into this release:

- Small series of patches for ublk (ZiyangZhang)

- Remove dead function (Yu)

- Fix for running a block queue in case of resource starvation (Yufen)

Please pull!


The following changes since commit aa0c680c3aa96a5f9f160d90dd95402ad578e2b0:

  block: Do not call blk_put_queue() if gendisk allocation fails (2022-08-12 06:42:06 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-6.0-2022-08-19

for you to fetch changes up to d3b38596875dbc709b4e721a5873f4663d8a9ea2:

  blk-mq: run queue no matter whether the request is the last request (2022-08-18 07:39:01 -0600)

----------------------------------------------------------------
block-6.0-2022-08-19

----------------------------------------------------------------
Yu Kuai (1):
      blk-mq: remove unused function blk_mq_queue_stopped()

Yufen Yu (1):
      blk-mq: run queue no matter whether the request is the last request

ZiyangZhang (4):
      ublk_drv: update iod->addr for UBLK_IO_NEED_GET_DATA
      ublk_drv: check ubq_daemon_is_dying() in __ublk_rq_task_work()
      ublk_drv: update comment for __ublk_fail_req()
      ublk_drv: do not add a re-issued request aborted previously to ioucmd's task_work

 block/blk-mq.c           | 22 +---------------------
 drivers/block/ublk_drv.c | 33 +++++++++++++++++++++++++++------
 include/linux/blk-mq.h   |  1 -
 3 files changed, 28 insertions(+), 28 deletions(-)
-- 
Jens Axboe
