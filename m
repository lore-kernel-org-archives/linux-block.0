Return-Path: <SRS0=HXqG=57=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BA7C2BA19
	for <linux-block@archiver.kernel.org>; Wed, 15 Apr 2020 09:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6E920771
	for <linux-block@archiver.kernel.org>; Wed, 15 Apr 2020 09:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="IhRTjTDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895388AbgDOJXh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895418AbgDOJXT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Apr 2020 05:23:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0DC03C1AE
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2020 02:23:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d27so9034406wra.1
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2020 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lzbi8aK38U3+DnvnY6rCKYXK2X3LSq1Bs0xPjQHnEY=;
        b=IhRTjTDz7EJWFq9QmsxzQIXFo/Rz3p94HTg5QUIce2pHs0vR3K/yQlWoDkJjT7He0Z
         xRnivZ/Znkw7AR7UZS6EvUSTJY9YeFboUWxVV1VjtXTiprve5IVpyGRptJE+8C3tBH0/
         tgkpnAjMv3N4JiZRQ5Mr+W+Fji7QVJn1rwXgHnJbYwWK6V/GoCpM/Ci6daZx62Moh+Lm
         IRLgxB7s3VdZUjGuqH70CDCrUcxhyqHZXGuASdLZca4OrXD017gWVnF+KU585tMXB+YE
         24sCXYIC4zPEfv/B6eH+75F7xLSJ/p6tY2Kod7H0tPDoR2GZNZ6yhp6Rh6eYbUAzQOhT
         OwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lzbi8aK38U3+DnvnY6rCKYXK2X3LSq1Bs0xPjQHnEY=;
        b=VMIvkZJDqYx9CblnLtKCZ1F2SvKVC2CxNO1Tk69M1cobZmVRKRrm95/NtnKOtCySTm
         bEeMDqGGfYvU/sopISUjlNc7Gcpe8Kg35djPehgeREfkCU+n1jvgJc9m31e1HaGBonJM
         YBnmzjrYRVLaAiHU7512+6kUK4+FPwfvCSTJIKHjvjpb8EdLfoKBwGYwPtaWKyq1FHmp
         cL2r/7084CQfsk+TnPBrnnqWvqj4N9P2bAfEEIpPg+pd53yCNspXKwMmX30G/SRiQlHq
         8CGMNZ+z6hkdjKm0DH6MJAQy4Jav+DeeVqBZYxrCLgLCOhHyBd8RAfifOrj6P0BMSALL
         gZkA==
X-Gm-Message-State: AGi0PuY2ZUDGAYuxytPlsuOYs8UgvwtgIOdyRKg6MTHOkm9vjjk7oxhh
        1D2rNzDF8IxlM2ejDzWqMgLEe+qHa2zWDzM=
X-Google-Smtp-Source: APiQypJ3GJM0/+2P/AexxwNZcsOmkayjLCRqYin26oqaGvC5I/yiPcNjbwDbLtPAlMe8SMno++ygnQ==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr9515274wrt.191.1586942597275;
        Wed, 15 Apr 2020 02:23:17 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:23:16 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Wed, 15 Apr 2020 11:20:45 +0200
Message-Id: <20200415092045.4729-26-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
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
index e64e5db31497..8031a923e5a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14448,6 +14448,13 @@ F:	arch/riscv/
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
@@ -14576,6 +14583,13 @@ S:	Maintained
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

