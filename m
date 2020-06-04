Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C160C433DF
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F123206DC
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QlK0IIGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgFDHNq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:13:46 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51836 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDHNq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 03:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591254835; x=1622790835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yGTkDOsobK6c9nniHjJXfJgRC3LDKuH21ZPcER8aEU=;
  b=QlK0IIGkxRkKM/BmfoS0MKLxy4od5pAqleYSe4ZBU6S3mpv97IS5snql
   fkanDG2qeB34v6eJDU/bvT8TU62vpjwdn9yNOm/J3Pf+00Ktd7gz7dMTR
   UW4hOPViftE7dh71ea2CrmnMy8VuvUpvK6Q6bEUMhMs1sHzXzwp1asg4X
   JNlcvGjq6lgpYqpxDI3fnE3CcbkTzcMVrWc9c+cMozraDGDRz2mVFIp4t
   SY/nD1TdIiww/VxujXoekv9Bb5yoOgp6zbIC/3vdWWifsvmjfA8Nwzse/
   mNbhQKHdYnuNQvkMMSVXBciI5dD1OEdubynl8kWY4cpol0u57LAmkdCqD
   A==;
IronPort-SDR: i/h6ByXSE62C8KQviRjrPabTi+0pV4EJFHBjb89TqjXLXnTB3/6co+fyHBmAtPDZob30kyjfzs
 OvzrTSJflytL2QP/3zWh0Jl9frPnu6TJ1YcvpsOGEta1Lblpdv8W98UbuuFqx5r3xiQK6Pi+TM
 e5AEzpXYHV2Ka+xnU0/hdfXUsZxnnOJ+YtHvX4VQsde74dAawD9ByZdYWw04MIAnnPksS7iWhj
 O9e3+O3XdkIzZnYVtXbWgby0mCv9GuXZ/xTZRwHZk2N4hqCjYMlnt+ODqLptPQk0gAwQ6NgPtB
 u0Q=
X-IronPort-AV: E=Sophos;i="5.73,471,1583164800"; 
   d="scan'208";a="242049190"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 15:13:54 +0800
IronPort-SDR: E3oElmDQXXDchJ11beI2qL0I2RE6HeT98TH9836+HbIJmQlWQQ+ZSPtsDUIlqcLRP6OuWtQgsD
 a7yek2p50bw2eisn/bt3a6tmGkyYGxK48=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 00:03:22 -0700
IronPort-SDR: GoYKl+G0KdJ+wGEsrYbGabOoMtSM32DF0XQKG4n1MMy/TrRD/xzI/ZTOgSCJ6452Ipnfr/j+S2
 1pUHrtsJabzA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 00:13:45 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/3] blktrace: fix endianness in get_pdu_int()
Date:   Thu,  4 Jun 2020 00:13:29 -0700
Message-Id: <20200604071330.5086-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200604071330.5086-1-chaitanya.kulkarni@wdc.com>
References: <20200604071330.5086-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In function get_pdu_len() replace variable type from __u64 to
__be64. This fixes sparse warning.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f6f4fe6ea5d8..70aebd95f9bf 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1256,7 +1256,7 @@ static inline __u16 t_error(const struct trace_entry *ent)
 
 static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 {
-	const __u64 *val = pdu_start(ent, has_cg);
+	const __be64 *val = pdu_start(ent, has_cg);
 	return be64_to_cpu(*val);
 }
 
-- 
2.22.1

