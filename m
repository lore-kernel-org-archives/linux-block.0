Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF0FC04A94
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 11:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjG1LH1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 07:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjG1LH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 07:07:26 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF62723
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690542444; x=1722078444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5uoXmicthBfI1KVabTbY4/3y08MYGGWftLP6ljGdBh4=;
  b=RcxKaCeWcm5ZJwJHBSkNdOBz9CpXoRw2a7iW+vrEiwaMEsV4vywqu7EG
   nLs8ZFJclZEIMw5j3YEPEyqj07WL+45C8iwF1KDjh8s2tK0FQFAiw/hir
   WUq3RXPXkjY9RyoHY8RDIUeD8BXYPDvJzNRMMrPuB0KEq02DGPEGhmpyK
   yMc55FaxquxmQXdTnkXMrl2wijUyu27lBbuv/z/uZTctNNoJTTLbBuWwo
   WvGKXT1TzTulmlBhaULss36wjpjyMO9tINMlVF7kaZYSvHrwWnUKcUHlC
   ZmOht++9iBIfaOIYvKQxLf16f+KGczhvrJAm792pXs4J35naIvi7iCagV
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684771200"; 
   d="scan'208";a="244001784"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 19:07:23 +0800
IronPort-SDR: PPz1IPpO6ylleguuMeOurcY2GRaZwOxFzPuMDjI0kxg+bcaP9goi+KgJzxVI7QrJvefdNM5UTZ
 tHEoaYUCUZzs7Y7xkVzq+OoHY+qttIdYybIYTpdHkqFmDTXAc2V+abBKbP1qh7S5oU02Qg37/I
 wbglwhilQHNfBhBcEbtGqsYVmGbXXMzURrNjPhF/UIzJU4fn0EvF0IkahO2Qxlp9uQTuw0OQo0
 BtjzaB9TLhFUFX35X8kQJJhQWfv9eptlgHYFV00IHS9SP8R1D9hesTy4hrQyqgXssQ7Pj0LuHZ
 9Nw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2023 03:15:23 -0700
IronPort-SDR: 8rXByPWqjhDKaxoJV7Qj3uPXDYqbolEiqrqE1yZhHEeQ1q1UcPsMPX6e1g5JWVziLg5FGdEB/p
 AesSVTYwOK1fJEE6cVE/7gaCDEpcqv5H6KlSQ938AwmYqFirXj5VWr9PSylJTSEluWMh2kwCYV
 g5Wr9xSQFjk/x4BaRbFzwt7mXRO1fCWUq+i4gspzF8C+69QZ5h16KVHAn2xN6shSafpNIvINYj
 6ceTqknthhQJ54ILrRSCzJUomOqeYLy9vQaIdrrblOfEqIMJS+63YxcGVRWiUOLPjo/OAIYbEa
 kGk=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2023 04:07:23 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/4] README: describe what './new' script documents
Date:   Fri, 28 Jul 2023 20:07:18 +0900
Message-Id: <20230728110720.1280124-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
References: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The knowledge required to implement blktests test cases are documented
in './new' script which generates test case script template. This is
handy when we implement new test cases. However, it is difficult to
refer the documentation when we do not implement new test cases.

To help to refer the documentation, add a pointer to it and describe
what it documents.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 README.md | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 186fc3b..1324159 100644
--- a/README.md
+++ b/README.md
@@ -49,7 +49,10 @@ configuration and running tests.
 ## Adding Tests
 
 The `./new` script creates a new test from a template. The generated template
-contains more detailed documentation.
+contains more detailed documentation. [The ./new script itself](new) can be
+referred as a document. It describes variables and functions that test cases
+should implement, global variables that test cases can refer and coding
+guidelines.
 
 Pull requests on GitHub and patches to <linux-block@vger.kernel.org> are both
 accepted. See [here](CONTRIBUTING.md) for more information on contributing.
-- 
2.40.1

