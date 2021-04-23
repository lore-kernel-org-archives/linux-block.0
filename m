Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92BCC433ED
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 01:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE5F61459
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 01:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbhDWBzH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 21:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbhDWBzG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 21:55:06 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43773C061574;
        Thu, 22 Apr 2021 18:54:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id m16so34779024qtx.9;
        Thu, 22 Apr 2021 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Zvtva10K0azodtfb3NSuxukBRc0DAWRA0RAa1Q2DQ+w=;
        b=dGuJJPVu1SRi7IvIhKVuVbubGX8hCE33W6FyudA8bBFegdYatPgRFU4tMrs6bs/wem
         +R4A0gJi7Vfo+/vHkF9AQ1N5glLYz0iT0UpDTUHCWf+t15EznDd+RWF/W21dPgzD05cm
         8qxiSXe4yLYNVjKR5BeqgkbjQm5+qpOi+/srL1JVWQWFRY7Aixqhg33ZzmXJKpJ1Uyja
         Drz/zxu0c7zbAx24ptJoN+VmE5+TpkGVqweSiHkzF7QJjBOgnThIisPFzgqyujxOfsHK
         0WU/fzZtDJed8orcDukbI9aYt20yYV0xBlq6CfjbdqqZTQ7nv4uVbT9M3JCCD1eNK3mb
         21kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Zvtva10K0azodtfb3NSuxukBRc0DAWRA0RAa1Q2DQ+w=;
        b=XDlXjQuTXO6fzQaoK1GruFvoGd9pQeIHZgrdxnvVJkeW57Dm91KDhkk2Hs6CVk8cQp
         qgL+dYm997lyJNGJMwiACGOX75SbWT98U/mZ/suCA48kl5DH/wZ1cZOqaeLXT9jA8lRy
         /0+o3Sa/QZSfJnOZTYMDX5jJQcrt7Ss8aUu4aUCvSStvdVvQRRL2txTuuOKAMYIezz+A
         pfTw6eXVNMnZx3l47UNFMzN0u3ipFyi9haM9amQ/Z5iV7Y0MgOAmtOjrPnq4OrCthe7l
         d59lUG3R+D7PDTDkml9BFjHEvzw96vm4Iai4bZoZuTbdoDMd6RiscE5ObsSI6ablix3f
         f0Ww==
X-Gm-Message-State: AOAM530drmwQVV1itVe8/TPJmepUJd/xCqpkojzjdeQoPmUsbqpnzRPk
        9U+v93R7iv5HmnYPCy6qCrH/EdMntLYsiw==
X-Google-Smtp-Source: ABdhPJzEh7ryG/ABW5BJDzYBBhrLJxPw5onVuNzsF0CQflok36s5Sx00Aq+feiltCU88DcJtMe7Hrw==
X-Received: by 2002:ac8:4d5e:: with SMTP id x30mr1457278qtv.51.1619142870251;
        Thu, 22 Apr 2021 18:54:30 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id w5sm3527477qkc.85.2021.04.22.18.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:54:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 22 Apr 2021 21:54:28 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com, dskarlat@fb.com,
        dschatzberg@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH for-5.13/block] blk-iocost: don't ignore vrate_min on QD
 contention
Message-ID: <YIIo1HuyNmhDeiNx@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ioc_adjust_base_vrate() ignored vrate_min when rq_wait_pct indicates that
there is QD contention. The reasoning was that QD depletion always reliably
indicates device saturation and thus it's safe to override user specified
vrate_min. However, this sometimes leads to unnecessary throttling,
especially on really fast devices, because vrate adjustments have delays and
inertia. It also confuses users because the behavior violates the explicitly
specified configuration.

This patch drops the special case handling so that vrate_min is always
applied.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 98d656bdb42b7..e0c4baa018578 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -987,10 +987,6 @@ static void ioc_adjust_base_vrate(struct ioc *ioc, u32 rq_wait_pct,
 		return;
 	}
 
-	/* rq_wait signal is always reliable, ignore user vrate_min */
-	if (rq_wait_pct > RQ_WAIT_BUSY_PCT)
-		vrate_min = VRATE_MIN;
-
 	/*
 	 * If vrate is out of bounds, apply clamp gradually as the
 	 * bounds can change abruptly.  Otherwise, apply busy_level
-- 
2.31.1

