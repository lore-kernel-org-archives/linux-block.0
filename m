Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FB7C282DA
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 20:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E12A218F0
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 20:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="GWo6E8z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfBAUvT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:51:19 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:33466 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfBAUvS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 15:51:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id AA49EAD107;
        Fri,  1 Feb 2019 21:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549054275; i=@fjfi.cvut.cz;
        bh=zNPyfGgQPdLBYRUvVPzSWci25wr1yNzvsEceLvBntxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GWo6E8z+rCPy+yzG4PVIH/eJJAIx4JLAVnftCGTZKo6MCTgh23KD861f08qra2xmQ
         zPRPgVuHvkT9iIpg8wb5iJRSHAgZAKLbqH9UbZJyUwumnfu0THEQVV6dD8sLnebfzS
         m+v+x3HJHAUDesVuLCO4TvB4Tne4AnzE6ZvShRuk=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id QYA9xyZeI2Z3; Fri,  1 Feb 2019 21:51:10 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id DD1DEAD108;
        Fri,  1 Feb 2019 21:50:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz DD1DEAD108
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id BF0F46004E; Fri,  1 Feb 2019 21:50:47 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH v4 02/16] block: sed-opal: use correct macro for method length
Date:   Fri,  1 Feb 2019 21:50:09 +0100
Message-Id: <1549054223-12220-3-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Also the values of OPAL_UID_LENGTH and OPAL_METHOD_LENGTH are the same,
it is weird to use OPAL_UID_LENGTH for the definition of the methods.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
---
 block/sed-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index c882a193e162..5c123a5b4ab1 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -181,7 +181,7 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
  * Derived from: TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
  * Section: 6.3 Assigned UIDs
  */
-static const u8 opalmethod[][OPAL_UID_LENGTH] = {
+static const u8 opalmethod[][OPAL_METHOD_LENGTH] = {
 	[OPAL_PROPERTIES] =
 		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x01 },
 	[OPAL_STARTSESSION] =
-- 
2.20.1

