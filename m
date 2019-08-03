Return-Path: <SRS0=u38M=V7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAEEC31E40
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 08:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF4A21783
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 08:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbfHCIqE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Aug 2019 04:46:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbfHCIqD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 3 Aug 2019 04:46:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B957130872C2;
        Sat,  3 Aug 2019 08:46:03 +0000 (UTC)
Received: from localhost (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 261035D9C6;
        Sat,  3 Aug 2019 08:46:00 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 3/4] spec: add URL tag
Date:   Sat,  3 Aug 2019 09:45:25 +0100
Message-Id: <20190803084526.3837-4-stefanha@redhat.com>
In-Reply-To: <20190803084526.3837-1-stefanha@redhat.com>
References: <20190803084526.3837-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 03 Aug 2019 08:46:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rpmlint complains that there is no URL tag pointing to the software's
website/documentation.  Since liburing does not have a landing page,
point to the cgit page where all information can be found.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 liburing.spec | 1 +
 1 file changed, 1 insertion(+)

diff --git a/liburing.spec b/liburing.spec
index 826f9cd..31dfde0 100644
--- a/liburing.spec
+++ b/liburing.spec
@@ -6,6 +6,7 @@ License: LGPLv2+
 Group:  System Environment/Libraries
 Source: %{name}-%{version}.tar.gz
 BuildRoot: %{_tmppath}/%{name}-root
+URL: http://git.kernel.dk/cgit/liburing/
 
 %description
 Provides native async IO for the Linux kernel, in a fast and efficient
-- 
2.21.0

