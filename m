Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCACCA9EAE
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 20:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167B02083E
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 20:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfJ2ULi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:11:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJ2ULi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 16:11:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id ECC4028FB7E
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@fb.com, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH blktests 2/3] Documentation: Add information about `--config` argument
Date:   Tue, 29 Oct 2019 17:09:41 -0300
Message-Id: <20191029200942.83044-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029200942.83044-1-andrealmeid@collabora.com>
References: <20191029200942.83044-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add information about how to use the argument `--config`.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 Documentation/running-tests.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 675dac7..d5921be 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -21,7 +21,8 @@ will run all tests in the `loop` group and the `block/002` test.
 
 Test configuration goes in the `config` file at the top-level directory of the
 blktests repository. Test configuration options can also be set as environment
-variables instead of in the `config` file.
+variables instead of in the `config` file. It is also possible to use a
+different file for configuration, using `--config=<file_name>`.
 
 ### Test Devices
 
-- 
2.23.0

