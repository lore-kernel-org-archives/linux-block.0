Return-Path: <SRS0=vA4A=OD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51013C43441
	for <linux-block@archiver.kernel.org>; Sat, 24 Nov 2018 16:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0795720874
	for <linux-block@archiver.kernel.org>; Sat, 24 Nov 2018 16:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=inango-systems.com header.i=@inango-systems.com header.b="IekxqYG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0795720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=inango-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbeKYDTJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 22:19:09 -0500
Received: from mail.inango-systems.com ([213.136.71.184]:51990 "EHLO
        mail.inango-sw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYDTJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 22:19:09 -0500
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Nov 2018 22:19:07 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id 34B577A24A7;
        Sat, 24 Nov 2018 18:21:29 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nnfdl-_ejBLE; Sat, 24 Nov 2018 18:21:27 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id EE8ED7A24A5;
        Sat, 24 Nov 2018 18:21:26 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com EE8ED7A24A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
        s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1543076487;
        bh=4yLHC0a37elTXzfbrjGdwZ41TXsia2MH0pMK8GMeZfY=;
        h=From:To:Date:Message-Id;
        b=IekxqYG0XLzmTNOrhfn9r29XU+ZdKcfR8jtBRz65Fr9YRIBvfbakCMO39174xPepD
         YZKDURhToT3wtiLCEi3V4LAbdYmRaDMRUaOWirRHwnRwBocth10oA9hJcgfQ5mdG6E
         1JOJFVyCSxR9SjGbxED2sc0ufok7MyzGhjfO4mk6RWmU+cpHtLVLXM+WtgtCIokfrc
         BTElWs3kRe4NOO2gMUuQzCRK2pd0kHC/OcForfsmi8Sg42ctgBxOsXXXcGT0Ozg2s8
         d8KHuzFDPL/UOtuvuTlIKbvV9HxZ+nO0BnW6c/mPdPhmQy3JZyZr9mMhAZM7beokcd
         XVHH+36YFcYqQ==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IkxIpi0nwRfy; Sat, 24 Nov 2018 18:21:26 +0200 (IST)
Received: from nmerinov.inango-sw (unknown [194.60.247.123])
        by mail.inango-sw.com (Postfix) with ESMTPSA id 00C317A24A4;
        Sat, 24 Nov 2018 18:21:25 +0200 (IST)
From:   Nikolai Merinov <n.merinov@inango-systems.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikolai Merinov <n.merinov@inango-systems.com>
Subject: [PATCH] partitions/efi: Fix partition name parsing in GUID partition entry
Date:   Sat, 24 Nov 2018 21:21:23 +0500
Message-Id: <20181124162123.21300-1-n.merinov@inango-systems.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

GUID partition entry defined to have a partition name as 36 UTF-16LE
code units. This means that on big-endian platforms ASCII symbols
would be read with 0xXX00 efi_char16_t character code. In order to
correctly extract ASCII characters from a partition name field we
should be converted from 16LE to CPU architecture.

The problem exists on all big endian platforms.

Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
---
 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 39f70d968754..ea50ee1505ed 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -729,7 +729,7 @@ int efi_partition(struct parsed_partitions *state)
 				ARRAY_SIZE(ptes[i].partition_name));
 		info->volname[label_max] = 0;
 		while (label_count < label_max) {
-			u8 c = ptes[i].partition_name[label_count] & 0xff;
+			u8 c = le16_to_cpu(ptes[i].partition_name[label_count]) & 0xff;
 			if (c && !isprint(c))
 				c = '!';
 			info->volname[label_count] = c;
-- 
2.14.1

