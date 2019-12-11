Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6F2C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7515C22B48
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="trIiLL+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbfLKPax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:30:53 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:10288 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387680AbfLKPaw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 10:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576078251; x=1607614251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SKfQoX2A8rZ0EnP2XkyIWyJjMF/So/eVFwUYzJEpgTw=;
  b=trIiLL+jeKQk4aIryp5tyAmL9BBvgLbLwpkQEUcbXbYVIX8jXMhRc7WU
   /kPttwswhWMzcjH70fTRxWCqqY7AaO1iMlLRMzR6KliXstR+se+VlQJ8Q
   c/qDWjbxAQDutpUJss0YkxROM6pc3ZSuiIjIlMWs6FzNghY/BNpKJELqP
   k=;
IronPort-SDR: ynn3GjgWJ7AJmj+IiCD63/an9xfGjEvulKIW2ESukaoYU3xV38CEmegp9TBobp4VnugtQwnRoH
 dToGlfSk+tuQ==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="14303724"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 Dec 2019 15:30:40 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 0FDA8A2146;
        Wed, 11 Dec 2019 15:30:39 +0000 (UTC)
Received: from EX13D32EUB004.ant.amazon.com (10.43.166.212) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 15:30:10 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D32EUB004.ant.amazon.com (10.43.166.212) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 15:30:10 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 15:30:07 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH v3 3/4] xen/interface: re-define FRONT/BACK_RING_ATTACH()
Date:   Wed, 11 Dec 2019 15:29:55 +0000
Message-ID: <20191211152956.5168-4-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152956.5168-1-pdurrant@amazon.com>
References: <20191211152956.5168-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently these macros are defined to re-initialize a front/back ring
(respectively) to values read from the shared ring in such a way that any
requests/responses that are added to the shared ring whilst the front/back
is detached will be skipped over. This, in general, is not a desirable
semantic since most frontend implementations will eventually block waiting
for a response which would either never appear or never be processed.

Since the macros are currently unused, take this opportunity to re-define
them to re-initialize a front/back ring using specified values. This also
allows FRONT/BACK_RING_INIT() to be re-defined in terms of
FRONT/BACK_RING_ATTACH() using a specified value of 0.

NOTE: BACK_RING_ATTACH() will be used directly in a subsequent patch.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

A patch to add the FRONT/BACK_RING_ATTACH() macros to the canonical
ring.h in xen.git will be sent once the definitions have been agreed.

v2:
 - change definitions to take explicit initial index values
---
 include/xen/interface/io/ring.h | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
index 3f40501fc60b..2af7a1cd6658 100644
--- a/include/xen/interface/io/ring.h
+++ b/include/xen/interface/io/ring.h
@@ -125,35 +125,24 @@ struct __name##_back_ring {						\
     memset((_s)->pad, 0, sizeof((_s)->pad));				\
 } while(0)
 
-#define FRONT_RING_INIT(_r, _s, __size) do {				\
-    (_r)->req_prod_pvt = 0;						\
-    (_r)->rsp_cons = 0;							\
+#define FRONT_RING_ATTACH(_r, _s, _i, __size) do {			\
+    (_r)->req_prod_pvt = (_i);						\
+    (_r)->rsp_cons = (_i);						\
     (_r)->nr_ents = __RING_SIZE(_s, __size);				\
     (_r)->sring = (_s);							\
 } while (0)
 
-#define BACK_RING_INIT(_r, _s, __size) do {				\
-    (_r)->rsp_prod_pvt = 0;						\
-    (_r)->req_cons = 0;							\
-    (_r)->nr_ents = __RING_SIZE(_s, __size);				\
-    (_r)->sring = (_s);							\
-} while (0)
+#define FRONT_RING_INIT(_r, _s, __size) FRONT_RING_ATTACH(_r, _s, 0, __size)
 
-/* Initialize to existing shared indexes -- for recovery */
-#define FRONT_RING_ATTACH(_r, _s, __size) do {				\
-    (_r)->sring = (_s);							\
-    (_r)->req_prod_pvt = (_s)->req_prod;				\
-    (_r)->rsp_cons = (_s)->rsp_prod;					\
+#define BACK_RING_ATTACH(_r, _s, _i, __size) do {			\
+    (_r)->rsp_prod_pvt = (_i);						\
+    (_r)->req_cons = (_i);						\
     (_r)->nr_ents = __RING_SIZE(_s, __size);				\
-} while (0)
-
-#define BACK_RING_ATTACH(_r, _s, __size) do {				\
     (_r)->sring = (_s);							\
-    (_r)->rsp_prod_pvt = (_s)->rsp_prod;				\
-    (_r)->req_cons = (_s)->req_prod;					\
-    (_r)->nr_ents = __RING_SIZE(_s, __size);				\
 } while (0)
 
+#define BACK_RING_INIT(_r, _s, __size) BACK_RING_ATTACH(_r, _s, 0, __size)
+
 /* How big is this ring? */
 #define RING_SIZE(_r)							\
     ((_r)->nr_ents)
-- 
2.20.1

