Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6A8C43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 02:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6A02084C
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 02:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdnqo8p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfAKCiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:38:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32985 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfAKCiE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 21:38:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so11951460eds.0;
        Thu, 10 Jan 2019 18:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pkXudDMLmm0DDrq6dajtJl2w4n3936JklLX1gfVPrPo=;
        b=hdnqo8p8vKizLuX1mV8MOAFo5HfDpJREpOqGHnN2vHuXCgN0S8qhUdAwN5DBn8rspl
         SuBOsm6r1VIZplQMULiQI+NKcNFH2zB56zXaWiM7cypNQy+IORadPIesm5q6TwW1wKTN
         sc4SrEdS4EnnU4Kb0Dg1C/rhxDERxwpzx98zp2seUHradgPwM/BVCG6wTxfbPz3kAT/P
         iUfEs4Y/jXDhe8sDmmAt9SxmVJGyatIe93Cfehm3nJ58Tqwir2M7+N9aTX3FXaVL56t2
         g8R5WM/h/OevasgNhwmc8+hzFNDy+v8IFZdim7BdjIwtP/S1yA3u1vsDPk9IT/G6KPwx
         MYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pkXudDMLmm0DDrq6dajtJl2w4n3936JklLX1gfVPrPo=;
        b=SI7ldnP4rNgd2wW+84l+ljStfYlR6Ya3rTk7VFZ8/YNvqeRd5AsXwymunQkROpqTuk
         8uvaUjLhj4qChjZ+kykcxUIx0cOpa44/lWbdzPqYJ7O3+li0W/eFgVKejZFFMZ88R/1C
         1YWiCWvTaRoIn2PfTcPkKVK4NUgUmf+6rE0EBxVYCSzPdmhNwJjtJQDrpfwub/leuovs
         mFJVrGl8ED1RfBy4xmkognz5jb0xiF6Ps2GieLr8WKkm08xL+kozb6mSbCMmwnux6NDj
         Ihrj6+CVq17VpYGlaEO3suQwqD63xtA4ziZgFqPkI+vunncc5uj7eSPlYlB9FrSY2RQQ
         fy5A==
X-Gm-Message-State: AJcUukcmuWjm73HikBMXwNV5S9q3FCfvh+OV2aHE+FWcdjDSLb13pcWP
        UOkY5KpYPYg2lHoOxMCsbepD9AlPXgI=
X-Google-Smtp-Source: ALg8bN51+0Y2ycKwu26wwcBlzfM++iq0fHnESBYuRlIvRoNI1jDbC+HOeZ/8k5eS+F4FNBZmQSnnvg==
X-Received: by 2002:a17:906:bb02:: with SMTP id jz2-v6mr10616229ejb.59.1547174281112;
        Thu, 10 Jan 2019 18:38:01 -0800 (PST)
Received: from bebop.suse.de (189.114.217.220.dynamic.adsl.gvt.net.br. [189.114.217.220])
        by smtp.gmail.com with ESMTPSA id q13-v6sm1290665eja.8.2019.01.10.18.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 18:38:00 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH] block/blk-core.c: Remove doc about request_count argument
Date:   Fri, 11 Jan 2019 00:38:34 -0200
Message-Id: <20190111023834.1252784-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument was removed in 5f0ed774ed29.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 block/blk-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c78042975737..eba494f528cb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -661,7 +661,6 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
  * blk_attempt_plug_merge - try to merge with %current's plugged list
  * @q: request_queue new bio is being queued at
  * @bio: new bio being queued
- * @request_count: out parameter for number of traversed plugged requests
  * @same_queue_rq: pointer to &struct request that gets filled in when
  * another request associated with @q is found on the plug list
  * (optional, may be %NULL)
-- 
2.16.4

