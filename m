Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47FBC10F25
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E41E24655
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Gvw9IL2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgCIVmK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:42:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34369 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgCIVmK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 17:42:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id c21so13821476edt.1
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C7tJkrPIRP2kBi75CQswd6mCG7PHtCBT2yqw+82VJdA=;
        b=Gvw9IL2ft0npEHfiEgWyf42h7F74JvPSLr9sWzTwkol3GCjC0RRNN1J/0RfzPnfvL2
         M/jyYweks+CizmFqUcH3MSYwwc/qU5OiC0VqeGtbg6zgONMa6VtZF2OxUvEGp3gTIosi
         IAnTHaepqlkv0xwAx/rmu1SGfhCh4v4PKTjVwaW4b1+VoTGiIHRZzZuGnrRr72wJzQC+
         V85albTygsslTjUHvaNktTlcu8ppyzXWykgq4W+Mad1TFhBhHUd+q8Ev8amJRe8Dd1m8
         JgSaDRXDBoqtLMo5GESNfb0B04RJ+27huTKwWoLlPKt0EsJdbGqeNp5rPcLm9hJSElMY
         YhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C7tJkrPIRP2kBi75CQswd6mCG7PHtCBT2yqw+82VJdA=;
        b=pTyEzNAB1cm5vPlPKsnnUcbiyyAVJBGV70tdY83DytHXYtoT0Gdut2R4OudLtKO5HO
         1NZyjQWnGwDGSct0gkv2dMyg+kfGvMoCJaatf4zJqzdE6fm+DJmi+rpoeReEkXozjx2c
         Ha/fAJAEEkV78eJ0wbv8k/IcIDzaKgs0RtqajyECBRVn5slfFW7WeL7rHhxe3lwBGo+A
         NSSTHa2HV87HYJPOf51eQTotl8+Q0eeOod0Dhkn7ejr15jkPIhI+xHlIeHyp7HSquSrI
         9aVPt9JtcK4EXpwNv7E1NfBRCe7iK24/NMUhiR6Soq5pfA8u489SZvLqvkZ9xrflVxbG
         4EYA==
X-Gm-Message-State: ANhLgQ1Cx1caW7D+ySt0aj4Z9sfpmtMzZG0R0MyNa/at9tg2vtz1pVHO
        i8U9SiWEIeGRlDW+dQiRmrTSgA==
X-Google-Smtp-Source: ADFU+vvJVGUQBgN1swDYoR6MlIF3JcNFplMWHhODfBvtiixA2ZuGoTxNokJM0qS7LCyfVJ9HM4c88w==
X-Received: by 2002:a50:baef:: with SMTP id x102mr7381475ede.238.1583790129244;
        Mon, 09 Mar 2020 14:42:09 -0700 (PDT)
Received: from nb01257.fritz.box ([2001:16b8:4824:700:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id g6sm3828488edm.29.2020.03.09.14.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:42:08 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 0/6] Some cleanups for blk-core.c and blk-flush.c
Date:   Mon,  9 Mar 2020 22:41:32 +0100
Message-Id: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

V2:

* collected Reviewed-by tags for some patches.
* remove __blk_rq_prep_clone and move the impletation to the only caller.

V1:

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
  block: cleanup for _blk/blk_rq_prep_clone
  block: remove unneeded argument from blk_alloc_flush_queue
  block: cleanup comment for blk_flush_complete_seq

 block/blk-core.c  | 38 +++++++++++++-------------------------
 block/blk-flush.c |  7 ++-----
 block/blk-mq.c    |  3 +--
 block/blk.h       |  4 ++--
 4 files changed, 18 insertions(+), 34 deletions(-)

-- 
2.17.1

