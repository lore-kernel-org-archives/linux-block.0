Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0259FC76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 03:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE4C2080C
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 03:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltVI7vA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfGXDth (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 23:49:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38962 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfGXDtg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 23:49:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so20462993pgi.6;
        Tue, 23 Jul 2019 20:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=opj8lnCtN7uVcvkOiHNBMfsILzIZd7HuE+IB/qnbPFs=;
        b=ltVI7vA+iq01wgiVxnieomCY9v/Tub804FD/gn9yiUjeQMRw2XKJofb5kolEda7nrV
         v3aQUuQuzvKVF3jveZuBXMoNL+KrzVgCeDLCc8nV9CpqFCUMe6jmzNjNLGf0Khh2pywL
         sUBhtVnBipvGnWDKC5Yj0crLE61C0zJiSYLjdQ0NaUHBjpCZjuhqnxFDAtLHM91JULXM
         wQpQxztA9L2D5PGuXsf18W+CJ1pmRMx7lFizLIgDBdmO1w0lUJww65iQgnxFp0cgoJOk
         K9/XZXQLUrUg/4/AEXqlc24YDF/UFQoFD7z6oxdRGgSqnLksMjaeBMoS6Qzvb3Fr0yiW
         n/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=opj8lnCtN7uVcvkOiHNBMfsILzIZd7HuE+IB/qnbPFs=;
        b=LgedTwpbgCJMGnuJAT/6zYcOQzy7dPGTn9zyYxYIQ8pdGqVZRdOEoAB4OPU7MvKkYb
         +obUgCQu7fIysX6YqX0gGA24XleiD/AkgtNJDSDDkKBRZ8FilRVx5S/iRbkRr59so+y9
         HvTrd9J+WoEmVzgeSMDL/Tk5esjMzt4+IPo9r9yaPBGJl5HBYy6AfwVI3fIBI4fUm5go
         5/JAGcXfovSRxFEuRFXRHxqhGrYGcQzHizZl2qT23PQLGmL9M9SqJmOaq5M6qFBGmJAw
         Q0rteVTpoXvk7XcmYmkyRnpLSSR4qieEvRui2yqv5JmTOm3wgTsEBNraUoOJqTk2HhpZ
         8xAg==
X-Gm-Message-State: APjAAAUDPTYmZ/qcecfCRn5OBiqzkD1tC6P499Fv2JqX23LsZM14xiWN
        wwlm5u5DG5iWTiDdCGfJWFg=
X-Google-Smtp-Source: APXvYqyBkgnGLXPPn3Fmhpw5XGZNyK+qjPNJG9xfJlZpUy87glmS6K/MaU7Z+LJJOmGczl64Wayewg==
X-Received: by 2002:a62:cdc8:: with SMTP id o191mr9130518pfg.74.1563940176347;
        Tue, 23 Jul 2019 20:49:36 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id t11sm51359610pgb.33.2019.07.23.20.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 20:49:35 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] block: drbd: Fix a possible null-pointer dereference in is_valid_state()
Date:   Wed, 24 Jul 2019 11:49:26 +0800
Message-Id: <20190724034926.28755-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In is_valid_state(), there is an if statement on line 839 to check
whether nc is NULL:
    if (nc)

When nc is NULL, it is used on line 880:
    (nc->verify_alg[0] == 0)

Thus, a possible null-pointer dereference may occur.

To fix this bug, nc is also checked on line 880.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index eeaa3b49b264..3cf477e9cf6a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -877,7 +877,7 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
 		rv = SS_CONNECTED_OUTDATES;
 
 	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
-		 (nc->verify_alg[0] == 0))
+		 (nc && nc->verify_alg[0] == 0))
 		rv = SS_NO_VERIFY_ALG;
 
 	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
-- 
2.17.0

