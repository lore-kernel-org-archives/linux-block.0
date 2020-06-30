Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6537C433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 18:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949E720775
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 18:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgF3SfL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbgF3SfK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 14:35:10 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C82C061755
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 11:35:10 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B3039BC11E;
        Tue, 30 Jun 2020 18:35:04 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     paolo.valente@linaro.org, axboe@kernel.dk, corbet@lwn.net,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: BFQ I/O scheduler
Date:   Tue, 30 Jun 2020 20:34:53 +0200
Message-Id: <20200630183453.9452-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 Documentation/block/bfq-iosched.rst | 4 ++--
 block/bfq-iosched.c                 | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/block/bfq-iosched.rst b/Documentation/block/bfq-iosched.rst
index 0d237d402860..eb025b942f8d 100644
--- a/Documentation/block/bfq-iosched.rst
+++ b/Documentation/block/bfq-iosched.rst
@@ -581,7 +581,7 @@ applications. Unset this tunable if you need/want to control weights.
     Scheduler", Proceedings of the First Workshop on Mobile System
     Technologies (MST-2015), May 2015.
 
-    http://algogroup.unimore.it/people/paolo/disk_sched/mst-2015.pdf
+    https://algogroup.unimore.it/people/paolo/disk_sched/mst-2015.pdf
 
 [2]
     P. Valente and M. Andreolini, "Improving Application
@@ -591,7 +591,7 @@ applications. Unset this tunable if you need/want to control weights.
 
     Slightly extended version:
 
-    http://algogroup.unimore.it/people/paolo/disk_sched/bfq-v1-suite-results.pdf
+    https://algogroup.unimore.it/people/paolo/disk_sched/bfq-v1-suite-results.pdf
 
 [3]
    https://github.com/Algodev-github/S
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 50c8f034c01c..409865aaed68 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -99,19 +99,19 @@
  * [1] P. Valente, A. Avanzini, "Evolution of the BFQ Storage I/O
  *     Scheduler", Proceedings of the First Workshop on Mobile System
  *     Technologies (MST-2015), May 2015.
- *     http://algogroup.unimore.it/people/paolo/disk_sched/mst-2015.pdf
+ *     https://algogroup.unimore.it/people/paolo/disk_sched/mst-2015.pdf
  *
  * [2] Jon C.R. Bennett and H. Zhang, "Hierarchical Packet Fair Queueing
  *     Algorithms", IEEE/ACM Transactions on Networking, 5(5):675-689,
  *     Oct 1997.
  *
- * http://www.cs.cmu.edu/~hzhang/papers/TON-97-Oct.ps.gz
+ * https://www.cs.cmu.edu/~hzhang/papers/TON-97-Oct.ps.gz
  *
  * [3] I. Stoica and H. Abdel-Wahab, "Earliest Eligible Virtual Deadline
  *     First: A Flexible and Accurate Mechanism for Proportional Share
  *     Resource Allocation", technical report.
  *
- * http://www.cs.berkeley.edu/~istoica/papers/eevdf-tr-95.pdf
+ * https://www.cs.berkeley.edu/~istoica/papers/eevdf-tr-95.pdf
  */
 #include <linux/module.h>
 #include <linux/slab.h>
-- 
2.27.0

