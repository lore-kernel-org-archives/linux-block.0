Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC94C2D0EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B469207FC
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ES9Lu4Uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgDQPNb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728272AbgDQPNb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 11:13:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3DAC061A0C
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2020 08:13:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z6so1055979plk.10
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2020 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6s7m6yy7KjcUmIxpbNdN6eXJgcvGy3Jp+HG3m19foJk=;
        b=ES9Lu4UjjGf0UwEHN6TsyypRSmDaH6YerW+Fp3HZXQNVwoo665L7IwlOtEIfP3m0kO
         omkcTM+v7GN4aW1mtf7g5Xtyu2WenHDK1KYSZkoEnusZ2Vw37OLoL4xYyIGkbY16WsL8
         3unT7T8jnlvz/AdihZ6+jueSE10+SYGrwvEMz5zN/1Z0jlhGPXRIJb0sg2gtv4XedOvp
         gwMNqf8WB1qbUX6ayPk/NZx9znoPgAtPtHzUiosBW9zKJIOuKYW4WPTjgLsre0xgrqg0
         +QZyOkc4bsm/VfSRqcIQwfjCtpR0ROEc5WVXq+7iwTbK3a2YxSDClUk3Ay7BlGgt/6u+
         jDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6s7m6yy7KjcUmIxpbNdN6eXJgcvGy3Jp+HG3m19foJk=;
        b=tQy/ghz7aZ/YBKH2Vt3W7C+pXRfUDP601OBc89eURu1sQarUObm42USuH6ZT8k7mU/
         TnGcnS6kQ/I+N5pzRfD6jYsaz0TDUzgP9hkJ0au4Cn/5qU3VowltfZ4W6Uk9gKM7RMGU
         eRoq9TrvYgOuZKa+uEeC7jkzRmHWuqwUyVDbqIXZ2nTji46on4aGRVRM/i07D+3l53d8
         kD4Ch28f02/PQ/V8SZssWc1J/1XBxK1wB8wGywfAiq/2DIKc/g3z7uKh/piqIuZvNFkr
         sFNd8H2afo8pz1LUp4gROlXvlgUOjb6TNu+uyHegQqILNw1oXU8Z9L3aOObr+viQ16uP
         MW7w==
X-Gm-Message-State: AGi0PubbhwniIog5MzSuG5cTzo+FISkpbWsFPL9j8b+DHsVlMUczkztK
        5AUMTWrbNIOs2a7aNAFq3eANPeHuwtyHOw==
X-Google-Smtp-Source: APiQypJ8YcWKa//8MQhs/fHNtmSS4vRSxqFryBb0bzB/vCLN0k2kNLZLB3zj5jEBttjlhusNtY+wtQ==
X-Received: by 2002:a17:90b:3115:: with SMTP id gc21mr4666576pjb.183.1587136410509;
        Fri, 17 Apr 2020 08:13:30 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id j4sm15752057pfa.214.2020.04.17.08.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 08:13:29 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.7-rc
Message-ID: <26613a68-19f0-e588-d9d8-da8f5a1f95f9@kernel.dk>
Date:   Fri, 17 Apr 2020 09:13:28 -0600
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

- Fix for a driver tag leak in error handling (John)

- Remove now defunct Kconfig selection from dasd (Stefan)

- blk-wbt trace fiexs (Tommi)


  git://git.kernel.dk/linux-block.git tags/block-5.7-2020-04-17


----------------------------------------------------------------
John Garry (1):
      blk-mq: Put driver tag in blk_mq_dispatch_rq_list() when no budget

Stefan Haberland (1):
      s390/dasd: remove IOSCHED_DEADLINE from DASD Kconfig

Tommi Rantala (2):
      blk-wbt: Use tracepoint_string() for wbt_step tracepoint string literals
      blk-wbt: Drop needless newlines from tracepoint format strings

 block/blk-mq.c             | 4 +++-
 block/blk-wbt.c            | 4 ++--
 drivers/s390/block/Kconfig | 1 -
 include/trace/events/wbt.h | 8 ++++----
 4 files changed, 9 insertions(+), 8 deletions(-)

-- 
Jens Axboe

