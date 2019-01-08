Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1A8C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 21:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6512420883
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 21:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfAHV4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:56:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfAHV4W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 16:56:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9937F33BE4;
        Tue,  8 Jan 2019 21:56:22 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-14.rdu2.redhat.com [10.10.120.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3AB15C5FC;
        Tue,  8 Jan 2019 21:56:21 +0000 (UTC)
From:   John Pittman <jpittman@redhat.com>
To:     paolo.valente@linaro.org
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, John Pittman <jpittman@redhat.com>
Subject: [PATCH] block: doc: add slice_idle_us to bfq documentation
Date:   Tue,  8 Jan 2019 16:56:13 -0500
Message-Id: <20190108215613.15277-1-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 08 Jan 2019 21:56:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Of the tunables available for the bfq I/O scheduler,
the only one missing from the documentation in
'Documentation/block/bfq-iosched.txt' is slice_idle_us.
Add this tunable to the documentation and a short
explanation of its purpose.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 Documentation/block/bfq-iosched.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index 8d8d8f06cab2..98a8dd5ee385 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -357,6 +357,13 @@ video playing/streaming, a very low drop rate may be more important
 than maximum throughput. In these cases, consider setting the
 strict_guarantees parameter.
 
+slice_idle_us
+-------------
+
+Controls the same tuning parameter as slice_idle, but in microseconds.
+Either tunable can be used to set idling behavior.  Afterwards, the
+other tunable will reflect the newly set value in sysfs.
+
 strict_guarantees
 -----------------
 
-- 
2.17.2

