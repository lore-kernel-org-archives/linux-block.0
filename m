Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B5C31E49
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5672166E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 13:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfFSNUY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:20:24 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFSNUX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 09:20:23 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mj7yt-1iIg1X2nOH-00fBKk; Wed, 19 Jun 2019 15:20:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jiri Kosina <jikos@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Robert Elliott <elliott@hpe.com>,
        Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Omar Sandoval <osandov@fb.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] floppy: fix harmless clang build warning
Date:   Wed, 19 Jun 2019 15:19:44 +0200
Message-Id: <20190619131959.2055400-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9sLIhj4RYRE24WCHm3szMo8GZJ4FomoOvzRvWEJj02wygrg65IH
 3/dU9k856rxtHNK3t4/hslHZyQJzy2g2X2ZTJf3XPB8w6RP7FX5Rw5hg2/9g1Z+0020tmKu
 15F86/OrwblahiJQngqOmErumRAcMWRWPua/ZruSOPNeT9OVZBl5p5qTJ2O6ELfIGrGsezq
 1OG08rxDPlmc7iqo7gt8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ytyqrxA5jJA=:AgNeAiNF5GoxUuYp/hzPZs
 CO+U7Y8oJyRl5CTNKZ/25bkcDyvJzmUTmOQTKWWg7iWCdpnkC9UOHH1q4DR+bsH6gLeL2vmOn
 sY4dHITnPoHaKPjmB7bXx0HdKV8KbMagCOsIX9/pbPMfBPGDkmYmLafqbrkqU1Qi65zUdoI+k
 UThpwAElzGMSdcaLyrOxldYJXLi9w34VasizMbNgGzIoQ3e9rqBzdIU76WfQ9RfmyuvREmcvC
 wJSj3B6jLXRMcm+94AQqlEcxBMQTNF4FieTXgKwOy0tQPgfBQMIgIdgVgy5iLXqTf/EjLR2GW
 9dkA284SkCt7r/U5WmTDX9PXVWW55fFFMgKUQM1LQklBwiWvWF4mg7LsSaRwV0f3iWAX+JM4y
 v2LvjAyIWPZBYlAl7FXzmHQfCpwBCgXeJwKwESMOoPck0M+JBtuSRMHdaEoMbLeXcvdDQmx/q
 +kYfKW0kg0ELVIyaLBSJlkPx4ilBTWMDEy/ueJ4k/jcjkG52ncuVtXAFzRoBHApnNCsXqz8Vv
 PdUt+leRK92fTojDjxVLn2wtYxEqt1tNPGt9GiIlG1/NhRNhHXe7G/MwtbgN2CWFa6Is986/z
 NGOVbSJyDXFnuJGQh/DH3yQ+hfwppVPSjtVEbNHNB5zdpItXJ698crNVzr0RGi96XSuOz7wDM
 YGavkGSNfvpeYZ6Kbm0RXwUpV2bW7BLizKBn8wMXzCE1qG1Vc0Q0vVS+cOchrFOzFaUsFTPjo
 jqL7c+P3BwdBOv8NU1a9jSBjOd6UAXbBc25APQ==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

clang warns about unusual code in floppy.c that looks like it
was intended to be a bit mask operation, checking for a specific
bit in the UDP->cmos variable (FLOPPY1_TYPE expands to '4' on
ARM):

drivers/block/floppy.c:3902:17: error: use of logical '&&' with constant operand [-Werror,-Wconstant-logical-operand]
        if (!UDP->cmos && FLOPPY1_TYPE)
                       ^  ~~~~~~~~~~~~
drivers/block/floppy.c:3902:17: note: use '&' for a bitwise operation
        if (!UDP->cmos && FLOPPY1_TYPE)

The check here is redundant anyway, if FLOPPY1_TYPE is zero, then
assigning it to a zero UDP->cmos field does not change anything,
so removing the extra check here has no effect other than shutting
up the warning.

On x86, this will no longer read a hardware register, as the
FLOPPY1_TYPE macro is not expanded if UDP->cmos is already
zero, but the result is the same.

Cc: Robert Elliott <elliott@hpe.com>
Cc: Keith Busch <kbusch@kernel.org>
Link: https://patchwork.kernel.org/patch/10851841/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The original patch did not get merged since there was some
discussion (see link), but as far as I can tell, the outcome
was that it's harmless so I just summarized the findings
above. The patch is unchanged from March.
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 9fb9b312ab6b..b933a7eea52b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3900,7 +3900,7 @@ static void __init config_types(void)
 	if (!UDP->cmos)
 		UDP->cmos = FLOPPY0_TYPE;
 	drive = 1;
-	if (!UDP->cmos && FLOPPY1_TYPE)
+	if (!UDP->cmos)
 		UDP->cmos = FLOPPY1_TYPE;
 
 	/* FIXME: additional physical CMOS drive detection should go here */
-- 
2.20.0

