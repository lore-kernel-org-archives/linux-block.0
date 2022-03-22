Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E8DC43219
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 14:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiCVO14 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbiCVOZc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 10:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A5D89336
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 07:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 526D161677
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 14:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C77DC340EC;
        Tue, 22 Mar 2022 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958871;
        bh=txgtubzGy2YJGb38zTZrSN3pOik458Vk300gTIDwqnk=;
        h=From:To:Cc:Subject:Date:From;
        b=AzTIk4BYTOdbBYGkIo9rtjdijcBFHK6onxL4MqDTufqE59tEjk+XXna5yYbfIQsz4
         LAAxy4DxTlcbGFJo+fn96+9vTJpS2Z9ij/IL9seeR9zJjTzptNE8sYH1xYu3Ng1hAr
         FVpMsLbY6aJdnCQf6HNnvbO63XDrJLNdQ65uwDWZO2DFagtKVYsZxUrNcnx43hymIV
         b1q5l/U0RFJjVj6OvVMoR0pTBArUgbBi2ipTO2eN+TU0W4yfveBy9x0cMjQb1x42pF
         ASeWCaaQtQBUwF++IW/TsPW2FYpbf9uJM2bCJ87R0eNQgnJ8c1T+SdL6tBG0tW+oU4
         zlyl5UX7GenzQ==
From:   kbusch@kernel.org
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] crytpo: fix crc64 testmgr digest byte order
Date:   Tue, 22 Mar 2022 08:21:07 -0600
Message-Id: <20220322142107.4581-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The result is set in little endian, so the expected digest needs to
be consistent for big endian machines.

Fixes: commit f3813f4b287e4 ("crypto: add rocksoft 64b crc guard tag framework")
Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 crypto/testmgr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index f1a22794c404..59919a636508 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -3686,11 +3686,11 @@ static const struct hash_testvec crc64_rocksoft_tv_template[] = {
 	{
 		.plaintext	= zeroes,
 		.psize		= 4096,
-		.digest		= (u8 *)(u64[]){ 0x6482d367eb22b64eull },
+		.digest         = "\x4e\xb6\x22\xeb\x67\xd3\x82\x64",
 	}, {
 		.plaintext	= ones,
 		.psize		= 4096,
-		.digest		= (u8 *)(u64[]){ 0xc0ddba7302eca3acull },
+		.digest         = "\xac\xa3\xec\x02\x73\xba\xdd\xc0",
 	}
 };
 
-- 
2.17.2

