Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920CAC32792
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619E6224FE
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRFD0hyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfI3UkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:40:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37824 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbfI3UkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 16:40:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so12868348wro.4;
        Mon, 30 Sep 2019 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cTUeLlsHzyRIM7wRd7q8kxuNflnVRbJU9qjFEDYt/Zw=;
        b=GRFD0hybSsF2MXMngUmv7oG4bMRbcXLcxchTcq3vu/uz3+Q+vLwLOoC/Kh4FjRjfVf
         J8TOnNJnfHAR1mF/kAFTt/8UKVw8t1+pV0a2PAMEkrg/TaUDMitONp+5JjQAob5j7pp9
         S8yhhwvLUxHw3QTnLEzwcZ0ymhbVsnbr/noUgQex2Q/gyONfaf7sCyd4fBGgJIYlCGYT
         NJsIeUeqzjy8C7PxPwvFoRj8Rwn7/mmLdCrM/KIjlguErGXdDErzIu8eczTzE+y4vWq4
         /1yF7+EhgidtmMzncooapQEcPQ1jBtB8POooHEgIHQ6BiFVJ/RSeGUF76xA/ix3HlX6e
         czMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cTUeLlsHzyRIM7wRd7q8kxuNflnVRbJU9qjFEDYt/Zw=;
        b=iHSvBqgYsf+FptqzimjmqLmOkA/fh3VAMSRslcViMBXNiix3nloEGmk8gY/FeKharG
         G8yHUZnZS/8/Ssq+xwwL0+tOT7/Ub9CGXuaY5Oh7zs6wXfQoCD/f95hkVXzEjSbiHS5S
         azRoKxuscmbesHyA/td2GIVR0DXq1hkcTYneReVaHese6SIh51F/bKwX/aiMM0T0TEIt
         n+ylnXaeGQvU+tgB2AKbmwl1YZauSURM1Bpd7PT9A+hfdI/2P3AE/5TaNQGqkD3mc1l/
         v1DrEXwz+QeuCbQLemAFbqvLllZ2fb03Y6XBhktgPQWfs6E9yuBRP6qg2/R9okUFgG5k
         ybHw==
X-Gm-Message-State: APjAAAXmjcSTxFNJMZJ/KEdCuQSNb0wwdxoEkfvxujN0Tt0zTHitT+1w
        dQSKPwr+YvN/iRySZ0t0RZ1AfVdnGqU=
X-Google-Smtp-Source: APXvYqwo4i/14wHd+SgDLNsTMLtn559N+qxd0IF7c3AL1YkLmVAHdJW4OIJjdnzsCEnYSniL2je9cg==
X-Received: by 2002:adf:ea12:: with SMTP id q18mr15055256wrm.378.1569869740730;
        Mon, 30 Sep 2019 11:55:40 -0700 (PDT)
Received: from localhost.localdomain ([109.126.142.9])
        by smtp.gmail.com with ESMTPSA id u83sm1131184wme.0.2019.09.30.11.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 11:55:40 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 0/2] Simplify blk_mq_in_flight*
Date:   Mon, 30 Sep 2019 21:55:32 +0300
Message-Id: <cover.1569868094.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <11ebb046bf422facf6e438672799306b80038173.1569830385.git.asml.silence@gmail.com>
References: <11ebb046bf422facf6e438672799306b80038173.1569830385.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Clean up inflight counting code. Deduplicate it and fortify with types.

v2: splitting the patch in two by Christoph suggestion

Pavel Begunkov (2):
  blk-mq: Reuse callback in blk_mq_in_flight*()
  blk-mq: Embed counters into struct mq_inflight

 block/blk-mq.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

-- 
2.23.0

