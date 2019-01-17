Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF208C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F8920855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="Eh9sRi7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfAQVdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:33:24 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:35402 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfAQVdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 16:33:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 320ABA3995;
        Thu, 17 Jan 2019 22:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547760801; i=@fjfi.cvut.cz;
        bh=Rpv8CdhAgujZiIel2W0MiyIQRHrS+t8AMEDdgRjAO1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Eh9sRi7WL1wU46sqQjE/5bzSmwVfnJY3Y5WWoZVI8TAwrDr1MfrOf9qp5U6GgEuZ8
         gF7mLEkhOlv1rPdw4I7G00fhGCMxay6xy9CJDSdEJ2q6IuYen2Pc7S++LcaKuKSIBk
         gq3TzVsTpPX2cl1mGTI8wSs/E7vvvVDFSejsGIGk=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id 1Ez_u19hb_Rm; Thu, 17 Jan 2019 22:33:13 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id C9482A3946;
        Thu, 17 Jan 2019 22:33:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz C9482A3946
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id AE6336004E; Thu, 17 Jan 2019 22:33:09 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH v2 08/16] block: sed-opal: print failed function address
Date:   Thu, 17 Jan 2019 22:31:48 +0100
Message-Id: <1547760716-7304-9-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Add function address (and if available its symbol) to the message if a
step function fails.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 1332547e5a99..4225f23b2165 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -394,8 +394,8 @@ static int next(struct opal_dev *dev)
 
 		error = step->fn(dev, step->data);
 		if (error) {
-			pr_debug("Error on step function: %d with error %d: %s\n",
-				 state, error,
+			pr_debug("Step %d (%pS) failed wit error %d: %s\n",
+				 state, step->fn, error,
 				 opal_error_to_human(error));
 
 			/* For each OPAL command we do a discovery0 then we
-- 
2.20.1

