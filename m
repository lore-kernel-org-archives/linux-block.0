Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185A1C3F2D2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BAE24699
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Kw9YdFGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgB1PF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:05:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46376 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgB1PF4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 10:05:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id o24so1838217pfp.13
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 07:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qhO8Ts0BnBvqvrjdLf/zb4adh1NKMOhk4Zw163CFWvM=;
        b=Kw9YdFGxWd+VWmc1ihYKbFk2oCoTkixkbjZBMByFQY1vFT1bhkPHXshW7nHTsZU3hu
         l6ff/zKUpe1/QyJb5Dzh0v5We9gTZ44dBGqzSISlmyvwpYqcYp1/VEQO1QJpgZJhuQ3s
         UP0qFjrV+Wi8y8FHkbI5uwem0QUUscE/OW2yvlKbUaTUbC4/73j/YvufYrJb7Cvk6yn/
         D2BDb2hw62V0dj/vEk2y5oj0cl0/m6Y9Y8NJ6et1J/KZ8sDi1y+LoRvD8S/hV9n8+eJE
         eItPKQ2ZuVAYHdD8eJ6wIgFYaaZinUE7SMBS7V18qac9ubylBKH6YZqyCHwBfJasbus8
         P9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qhO8Ts0BnBvqvrjdLf/zb4adh1NKMOhk4Zw163CFWvM=;
        b=BJCURrF7Czi4eUgbqicea6l5u6NUeikw5BGF7KpIUGauwPaGY75iGSOzm9vBy2bGmW
         FvDhT3DD2pKlXaZIqBSulWROAP12MJox/zrNc/A7lgNFHvHBr/aoMc2po/hqhjt0F/3G
         H1/6OMIgQrqzQjEWYgv+cSP+8bdo0y8WFWRvjT9GIn5ikcAwk5G+8cS776u9G+wm1ndj
         aaBfaqj1Nl20QLlMHB4eRIQx0KxflP6J+O6FDokJC7SP/ayrd6ZiEo1DRSWvWygyqjIk
         W7IT2dcMHoblngFfCiLZoNzukxhVJcMY7cIzlIuYm+YFqWm6cM4HmFWTk2Uvowo/IvoG
         qDkg==
X-Gm-Message-State: APjAAAX1bbTycAQZRFj+paN2z6rFvLKw+eVdVS+0lRNN66YAgz2aIImi
        IVknmTGrOOkAxH8o4LB00EHxew==
X-Google-Smtp-Source: APXvYqyQVwrTCvQ9wRpel6XfuHK6LsEfzMs7xjWwEka4U0IA772k7jXONHPNGRGP8/sFSW5traW7HQ==
X-Received: by 2002:aa7:864b:: with SMTP id a11mr4866938pfo.175.1582902353309;
        Fri, 28 Feb 2020 07:05:53 -0800 (PST)
Received: from nb01257.pb.local ([240e:82:3:5b12:940:b7e:a31d:58eb])
        by smtp.gmail.com with ESMTPSA id y1sm7621912pgs.74.2020.02.28.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:05:52 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/6] Some cleanups for blk-core.c and blk-flush.c
Date:   Fri, 28 Feb 2020 16:05:12 +0100
Message-Id: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patchset updates code and comment in blk-core.c and blk-flush.c.
The first patch had been sent before, now update it with the Reviewed-by
tag from Bart.

Thanks,
Guoqing

Guoqing Jiang (6):
  block: fix comment for blk_cloned_rq_check_limits
  block: use bio_{wouldblock,io}_error in direct_make_request
  block: remove redundant setting of QUEUE_FLAG_DYING
  block: remove obsolete comments for _blk/blk_rq_prep_clone
  block: remove unneeded argument from blk_alloc_flush_queue
  block: cleanup comment for blk_flush_complete_seq

 block/blk-core.c  | 11 +++--------
 block/blk-flush.c |  7 ++-----
 block/blk-mq.c    |  3 +--
 block/blk.h       |  4 ++--
 4 files changed, 8 insertions(+), 17 deletions(-)

-- 
2.17.1

