Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C74C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 06:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1554218A5
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 06:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="l3fPATFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfCOGbr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:31:47 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49656 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfCOGbq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 02:31:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 64FF4A7E
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 06:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hm6QxFPS8Aso for <linux-block@vger.kernel.org>;
        Fri, 15 Mar 2019 01:31:45 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 2E778A90
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 01:31:45 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id w19so6210733ioa.15
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 23:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RScIh5HilcI0s6YdRvi01yt2VTjLLnx7lLlGiP4k7Uk=;
        b=l3fPATFAaPxQTxi8y7dBUtMT5IgF4dSZ1HhaH6DbrCbcsZcOWhxAjauFci8BRZfPy8
         tW7A5nqREeqp2Bkez8sG4zBXG2LtbWwAh5lqLvtp91uQRRAreiNMUpyJlaAHu3sXrSdJ
         OQZE4whciBByNO792wHceoLitp5nS1pPPBjVqWwGqIKgRAkvcMlhUQRb9tfT3fPsQu85
         DATdWzSEdjKfxNtUtFjfoASvAZll0uBdNqaapi/lL7FCZaTHP0rWr5u7A0mFa1IXpZej
         odC3+1bGbUCd/P06XsvAnKCdiN9JFI3e6gVcu8yI1l1d2WCpBMnot21Hdr270CH3o9bg
         vi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RScIh5HilcI0s6YdRvi01yt2VTjLLnx7lLlGiP4k7Uk=;
        b=m54ZtRMP37ewI+f6tuaNjUXvSPFyyMSGyQSH0GdYgU6tPqkCaFeju8e55JvzIqEnjT
         wZH/7fDSY3vjT9zzJTAs0ZT8S1o9hHM6Pk/JbwO6cZCs/QU5VzhyDtV2Lg44+x3anpb3
         yBQl6TrXINmDPOsGvITBxBBAhwAC7Gd98fQ4IAG/BSVMjdwLZ25wpdnpJw+nChM1j6lj
         XSGXdaD9NzcyWeobgyqsG3hytEvYR/qx+Je5rIcJFY9RIkwwYmuLzTvcvZ78VE2F/moK
         jCeJkPvZSp+zAGeTSfOUD0iQDSz8zx/7Y9yb384JvmmkJzOxBOPDAjwsg0jLc7OMX/pk
         CFVg==
X-Gm-Message-State: APjAAAWMovccigoEcGPAnZ49h/J2/0KdWlcQWPSNPDz2C/3+a/B9gqTJ
        aQn7JhopiAclVJPbFf2vb4d3S6/Yr/I767kgvskQ6TOsNUGWtZmGCsN58qBKJ93YcEbOOK3H3EK
        Eh6pmNb8CPu3Msgm1GuFVZx9RQsA=
X-Received: by 2002:a24:f709:: with SMTP id x9mr950054ith.149.1552631504800;
        Thu, 14 Mar 2019 23:31:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYbfLq/bkTe0v1XFFFT7Rowt+De+mVH+2YC8KzN3mrFj0W/vVX3RUhGEOSjm/mhccB6ImHIA==
X-Received: by 2002:a24:f709:: with SMTP id x9mr950041ith.149.1552631504558;
        Thu, 14 Mar 2019 23:31:44 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 197sm661341itz.24.2019.03.14.23.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 23:31:43 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: nbd: fix a missing check for nla_nest_start
Date:   Fri, 15 Mar 2019 01:31:38 -0500
Message-Id: <20190315063138.17666-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nla_nest_start may fail and thus deserves a check.

The fix inserts such a check and exits gracefully in case it
fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/block/nbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7c9a949e876b..810c8c20b142 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2099,6 +2099,10 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		nlmsg_free(reply);
+		goto out;
+	}
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.17.1

