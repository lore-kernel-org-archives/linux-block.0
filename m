Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082E4C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 21:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43A72064A
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 21:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfCMVYo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:24:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfCMVYo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 17:24:44 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1McYP5-1gTl3Z2Q4z-00cynt; Wed, 13 Mar 2019 22:14:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jiri Kosina <jikos@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] floppy: fix harmless clang build warning
Date:   Wed, 13 Mar 2019 22:11:02 +0100
Message-Id: <20190313211433.4178148-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gg1ro3XTPV2CCnela4QdedSa5uOGKvbolUTUSWpPuuuqS8tnu4F
 dXo0/b52lEpwhb2oj3fT2xacyiDcmUA5SVQbNCqwM/2Zb16vxs7/aWT6Vi6sr+m8PTfdMxx
 JxqFkDx6Zj+PxczCPZLx1yg7kINf9QBuvmFQ/rTup+LrnPJ4gsRhkP0Ef6elj0UFEkXnzoL
 N5PkT9TbA2TftsSx8lIYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sFFuG74Vyyk=:7d62AIaI7pn379Sxg50mjW
 hVuM47pfFc4VyK5QvJHxlVN+wqIyDT4I/L6KZLDqEWWQ2LyHkzN7LWy+EI45S1PtWIYy9aec0
 nkSsELWZjdzlFIX0rI/eH0Gh4qshel149Zw9QhLxB0En7tQQOJ+b32WJko6wTPUGLb+cXIKXf
 Fwkb0s7SvvdRlk116e8s8Oij1Hv5fYRdUSatgJ5xNa++GuWjRIZUB3fYkyfVThgSY6yNWj3Cw
 5sm0MnqX+aZw5xZaDD+pRbqNpWA5pundvikFui4ZXfZ9VgZiw5ypf0TRKFBeO48mXU5aJmzOU
 rhNMVS0GZY9VqOVSrY4K5/nbXHDSz/PbeUrt8jNUMHNdP7YBMguT9oGhub+6XLdy19MPa5mvj
 rqqTt1A89SAbbahVaeXZNQrly5Spk2uKc9EP60dpEUkY7nV6HbbA/rARF7ZtiEzDn7gAg9hkl
 43dgwL1qO+R0kcWprtzZkJhqiFwp38ibRIiCLnZOHfztrHxBCeM8BHExLhwH4qnPeNJDkZ+iQ
 LRnuTWkUDBjP8BdX88aWbOJNhoz+Jvzl8ErHLhfQlz6LN/PkFTe3vFVXxOne97dpWK42ibb11
 osL7m7xrqcXA0zju4UFRcBldHzYvm5W73UGGV5xr7mlUJFlK4vlkKvifVhJwNyqHTIbjlJpAS
 CPQ4aYEdWPz3ab46wSsLeTekBKwyiaTqDFjkZgowO5hIWfR+xs4iOQ5MPbOOUpLY/4KKVIKj8
 JDPT4/v8a54Nv57eUGAmHXdH4hyPx3FYakr5cw==
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 95f608d1a098..56815446ed85 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3899,7 +3899,7 @@ static void __init config_types(void)
 	if (!UDP->cmos)
 		UDP->cmos = FLOPPY0_TYPE;
 	drive = 1;
-	if (!UDP->cmos && FLOPPY1_TYPE)
+	if (!UDP->cmos)
 		UDP->cmos = FLOPPY1_TYPE;
 
 	/* FIXME: additional physical CMOS drive detection should go here */
-- 
2.20.0

