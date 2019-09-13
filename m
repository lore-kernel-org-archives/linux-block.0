Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCC1C4CECA
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7902084F
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390464AbfIMWE2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:04:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60812 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403993AbfIMWE1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:04:27 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f4:5bfc:5711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9464F28EF7B;
        Fri, 13 Sep 2019 23:04:22 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, kernel@collabora.com,
        krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 4/4] coding-style: add explanation about pr_fmt macro
Date:   Fri, 13 Sep 2019 19:03:00 -0300
Message-Id: <20190913220300.422869-5-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913220300.422869-1-andrealmeid@collabora.com>
References: <20190913220300.422869-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pr_fmt macro is useful to format log messages printed by pr_XXXX()
functions. Add text to explain the purpose of it, how to use and an
example.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
Changes from v1:
- Add Jonathan as explict Cc
- Replace "include/printk.h" by "#include <linux/kernel.h>
- Add note about #undef
- Replace hardcore string by KBUILD_MODNAME at the example
---
 Documentation/process/coding-style.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index f4a2198187f9..1a33a933fbd3 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -819,7 +819,15 @@ which you should use to make sure messages are matched to the right device
 and driver, and are tagged with the right level:  dev_err(), dev_warn(),
 dev_info(), and so forth.  For messages that aren't associated with a
 particular device, <linux/printk.h> defines pr_notice(), pr_info(),
-pr_warn(), pr_err(), etc.
+pr_warn(), pr_err(), etc. It's possible to format pr_XXX() messages using the
+macro pr_fmt() to prevent rewriting the style of messages. It should be
+defined before ``#include <linux/kernel.h>``, to avoid compiler warning about
+redefinitions, or just use ``#undef pr_fmt``. This is particularly useful for
+adding the name of the module at the beginning of the message, for instance:
+
+.. code-block:: c
+
+        #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 Coming up with good debugging messages can be quite a challenge; and once
 you have them, they can be a huge help for remote troubleshooting.  However
-- 
2.23.0

