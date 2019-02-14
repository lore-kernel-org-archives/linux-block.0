Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63DDC10F00
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC3F21920
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="0TlO4WI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404674AbfBNAQv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:16:51 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47288 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404671AbfBNAQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:16:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 54F21AA288;
        Thu, 14 Feb 2019 01:16:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103409; i=@fjfi.cvut.cz;
        bh=K/khPWUzrOCStJ0JQ5+KjgdA/LjpugJdhhEMHZhWsuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=0TlO4WI/T7sky4O5xar2U8YQz2n0oY3ey41FUsECa5NifoCmMnKZ7QZz7Lqu0aUBV
         waVZ6Mo7T6Rw5PXWMf4l+zw4KiZEV1gPBQ5ocEl22oJRfyodxp/ROnW/rdPD2/RyO+
         0oeMZ8GfjQcmEPb0LsSRBC4lEZ3uXrVC47EMd5YU=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id WdnP775j0wLR; Thu, 14 Feb 2019 01:16:45 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 37F88AA274;
        Thu, 14 Feb 2019 01:16:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 37F88AA274
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 110E76004E; Thu, 14 Feb 2019 01:16:45 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 03/16] block: sed-opal: use correct macro for method length
Date:   Thu, 14 Feb 2019 01:15:55 +0100
Message-Id: <1550103368-4605-4-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Also the values of OPAL_UID_LENGTH and OPAL_METHOD_LENGTH are the same,
it is weird to use OPAL_UID_LENGTH for the definition of the methods.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index d12a910e06cb..e59ae364f1ef 100644
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

