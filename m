Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32AC001DE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 11:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjG1LH2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 07:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjG1LH1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 07:07:27 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61FB2701
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 04:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690542446; x=1722078446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L7PLwRmCaJnOV181uckfuqpFHDHieZL5cZFhziRG4eA=;
  b=i5YKFZ/IH6F6rgZZZpdtjcWBmaE4gA4iZKr8AcvOKTLiRdu0EIhf5myl
   H1DjluP+flc9DGFG/A8nIsxFPUrXJQ8ivIcsppgSECKtzQjZT8vTUW3mq
   2GrV0e7SZ7YdsdYOb/BA2FmI3OxcU2oEndAPL+0DYFsXE9LP5EzZA6CEw
   2m86pjGJKNUpUmvTdW2i3f4w0SCFz4qEL2hHio5B4BLQTZVsLX92deGSc
   Vxb7ZLoeGUOacg16guL52xhd0v0ZYo/1+Ssl4sOY2N1uXnVGBNJT1vrgO
   dtS6UffxHEZoSHx0xAirHYWVYlN0JZRrkjX9vA+TA0a/ytsMz2jswj4l5
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684771200"; 
   d="scan'208";a="237709696"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 19:07:26 +0800
IronPort-SDR: 6/jF3LgXCjfaCemAsf2kJcHSWAT4KKcky+S7+1+AZ8rb0UgRnJ+XYpwV36TWtBOwN9f/qADThr
 xvG2BtYcokphT9XtSEPi9f13Sh9pGTWhoIVYQXsv5PYo1Mc92zY7ffKlVBkq0ZQJbP3cNeRdkI
 pjWo8K9/zGxSOE5quDiAnpRurJNy4MpibxdOigREcI+qVCRwH4GIeR4xLnhbwghBErarf5FHBI
 jgfWpzcCkYMrqa76WjXWlE1D4UpvsUTwtgWryDnE3mTVjoVdMlfZbgOhcvusxqxq4e+b93fA6I
 Yvo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2023 03:21:07 -0700
IronPort-SDR: lzbhMetSeLK7o9ClzZ3251QBdLziS1aHDBMjQ04aBZN24jO6ndVsqp8G4Xa63QPNp0+Au6Mt5g
 d0zE0EL7iQajrG214p21jvaB0bTX7P0OkWNKK9DZ8BbuU6LdCxdsAxkffjSUGzyHM8cc5pEdOE
 Cdtc1wdhjnoYkajXcGYCNNEdgfH25O4k2wneLQqYvVML9gl8YdaMylplDzAp4+Nrau/E2WzqDE
 TjJbaE+7qcaUb9G8km8NrwC/GWw6SsiDh2e8WoBSVgtteSnIAOHPIi5vNbiIPLnH8VIqRZa7r+
 hI8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2023 04:07:26 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/4] README: clarify motivations to add new test cases
Date:   Fri, 28 Jul 2023 20:07:20 +0900
Message-Id: <20230728110720.1280124-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
References: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is often questioned when new test cases should be added to blktests.
Clarify it in "Adding Tests" section.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 README.md | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/README.md b/README.md
index 201d11c..6610078 100644
--- a/README.md
+++ b/README.md
@@ -48,6 +48,14 @@ configuration and running tests.
 
 ## Adding Tests
 
+New test cases are welcomed when,
+
+- a bug in block layer or storage stack is found and the new test case confirms
+  fix of the bug,
+- a new feature is introduced in block layer or storage stack, and the new test
+  cases confirm that the feature is working well, or,
+- the new test cases extend coverage of block layer and storage stack code.
+
 The `./new` script creates a new test from a template. The generated template
 contains more detailed documentation. [The ./new script itself](new) can be
 referred as a document. It describes variables and functions that test cases
-- 
2.40.1

