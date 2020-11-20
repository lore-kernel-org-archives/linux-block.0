Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68781C64E8A
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 18:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316E02415B
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 18:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpRxsJrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgKTS2d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbgKTS2c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 13:28:32 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C24F2224C;
        Fri, 20 Nov 2020 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896912;
        bh=ssvHPrhtc5RCPny0nBzYLJShq5+Wt0kEALg8BV3eIWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpRxsJrOqAWba4bZv/4F8tw0/m486AgJhgDKTUjEnEensBBs9izLoqTeMQ7B9KHZW
         qTkprQFGHn3/dIUe9cXajWqF22ZUM5Xf/R8LffZvXqveQWZbG3wVUtSF3OwKra59xp
         Sz1y9i3YtrRB2S3urnGjEoJVg/p+eFVjcKfW+OI8=
Date:   Fri, 20 Nov 2020 12:28:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 032/141] floppy: Fix fall-through warnings for Clang
Message-ID: <ede7ffddba64f621150f8f5c5f2b8f080b560903.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a fallthrough pseudo-keyword in places where the
code is intended to fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/block/floppy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 7df79ae6b0a1..21a2a7becba0 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2124,6 +2124,7 @@ static void format_interrupt(void)
 	switch (interpret_errors()) {
 	case 1:
 		cont->error();
+		fallthrough;
 	case 2:
 		break;
 	case 0:
-- 
2.27.0

