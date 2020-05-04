Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3A9C3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 14:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892F220757
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 14:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="hwteaOl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgEDOCx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgEDOCw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 10:02:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81488C061A41
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 07:02:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so10770334wrt.9
        for <linux-block@vger.kernel.org>; Mon, 04 May 2020 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14fvy45UZp2tI9GhPNFr+nZliyDaQIiueuUCC9wqpt0=;
        b=hwteaOl2p7NwwUke6H4o6ER5tr+7LIq0WNKip5EP7laMqhObQuRUlWbchU+/cyuIh2
         n05XrmiBueh614RCCyw9eRsueZSXgzdv3dO+opxV6lK2cZJKjwRTNHhmtbQwaZ/QFHRm
         cPLU/gHhYyNniCuBcYYQ2jbrNgtADkwC9YgdTqgX6l/aHEdnJ0IvyUPG2HOed5MYrk3F
         5d2rcu+AeQY1HwYEjdBMa98rPOTIfmZjIx6k8OCtCTudg8c44HazVhQUiVP5iyB6NsBQ
         ME5ZjbnfBHbsgTwI4SdQ1KlaJ/Fcri6wt44S0u9QLU/3Y5Q9W9hJJWtYo3hQhedN59qM
         bbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14fvy45UZp2tI9GhPNFr+nZliyDaQIiueuUCC9wqpt0=;
        b=TvEol6tj03a6fhyN+d3WZxv3rFgFhNVOVToIOOpcmR8O6xq2QuPUEiUE9eCJn3t/vQ
         HMp6SIOQp7U3oFoan/5PwSijRuu4S18wgIjUGPmd4y4Wp8vfSfgzJ2F+AFD6SSy+QXby
         uCImshXNXxWAPU1cm2u8b1f99TTHDDB4xFCfOXLHeT4rUR2cM2qBNWkWTFpENjYJP8ht
         RQKpv30x8pyHSUhHXNKX4y+FvbvahtnIxkyhg80CDm4RgAm3NBKWhgQ1706pxRgN/0fE
         ElCN3oiKNMu3MJ5YXkM/Aj2bHNQ+cCbIOKnEb11CpDPI2l9T/M4oZXjbxKpmmlCg5xjS
         lr2w==
X-Gm-Message-State: AGi0PuZ8qpMghGmKQJl+gSNRadk3xA2VYvi7NSeP24rpt6/3+nm8K5zb
        a3XwTTea3ITSW78KbeAS1L1DoO4TVAukZ4Q=
X-Google-Smtp-Source: APiQypJLM4xnROIFFjHUvYOaFL8pyBNRDos4dqGS9MG5LGVJdgbIbnBA4yVeH6MVKKkr7EhbMK9Krg==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr18946994wrv.3.1588600970959;
        Mon, 04 May 2020 07:02:50 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:50 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Mon,  4 May 2020 16:01:15 +0200
Message-Id: <20200504140115.15533-26-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Danil and I will maintain RNBD/RTRS modules.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2926327e4976..657093123663 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14459,6 +14459,13 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RNBD BLOCK DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/rnbd/
+
 ROCCAT DRIVERS
 M:	Stefan Achatz <erazor_de@users.sourceforge.net>
 S:	Maintained
@@ -14587,6 +14594,13 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-devel
 F:	drivers/net/wireless/realtek/rtl8xxxu/
 
+RTRS TRANSPORT DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+F:	drivers/infiniband/ulp/rtrs/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 L:	linux-afs@lists.infradead.org
-- 
2.20.1

