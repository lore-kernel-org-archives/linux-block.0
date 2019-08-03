Return-Path: <SRS0=u38M=V7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED6C31E40
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 08:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B7D217D6
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 08:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbfHCIqA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Aug 2019 04:46:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbfHCIqA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 3 Aug 2019 04:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE4E5309DEEA;
        Sat,  3 Aug 2019 08:45:59 +0000 (UTC)
Received: from localhost (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83A9460A9F;
        Sat,  3 Aug 2019 08:45:59 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 2/4] spec: use Fedora "LGPLv2+" license identifier
Date:   Sat,  3 Aug 2019 09:45:24 +0100
Message-Id: <20190803084526.3837-3-stefanha@redhat.com>
In-Reply-To: <20190803084526.3837-1-stefanha@redhat.com>
References: <20190803084526.3837-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sat, 03 Aug 2019 08:46:00 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rpmlint complains that "LGPL" is not a valid License tag.  The License
tag for "GNU Lesser General Public License v2 (or 2.1) or later" is
"LGPLv2+" according to:
https://fedoraproject.org/wiki/Licensing:Main

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 liburing.spec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liburing.spec b/liburing.spec
index e577a8f..826f9cd 100644
--- a/liburing.spec
+++ b/liburing.spec
@@ -2,7 +2,7 @@ Name: liburing
 Version: 0.1
 Release: 1
 Summary: Linux-native io_uring I/O access library
-License: LGPL
+License: LGPLv2+
 Group:  System Environment/Libraries
 Source: %{name}-%{version}.tar.gz
 BuildRoot: %{_tmppath}/%{name}-root
-- 
2.21.0

