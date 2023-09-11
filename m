Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F8ECA0EC6
	for <linux-block@archiver.kernel.org>; Mon, 11 Sep 2023 23:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjIKXRG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Sep 2023 19:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352492AbjIKVpN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Sep 2023 17:45:13 -0400
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E255AE
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 14:36:34 -0700 (PDT)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d8109d3a3bbso215177276.2
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694468056; x=1695072856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QwxqNL1zXUB9OAJf/Ygs9mELpjYs6oPReuh29ZTVE2Q=;
        b=ZlTD71ls15A1aQf8jyPlL4l8U8QDzUZuUTzP9g4KZtj7YPVopxF3aAgP6HzIOZxCfz
         J41HcJq3xMvpBunJ1bojWHHWK2MIQ2+j1FbiMVu3c9T6x7WNs5WAdJ+QuT46Z0fz0LMw
         G3p49Vw1Mq3lqMR+r4p+9c0B/L3pIDCFz0z0jKKXaBpjlQAs+gXzvKN+JwvRxqn9AuO4
         5wHCxK0dTNBpjKEXNRyYN9MGh1CDHyfOnh6cK/i8rYLsIUMYhs86UkWY+2Hk/9f72Frc
         BgM29321dvsSBTJ0uMCSv3wnilxU+WAVOzZKHBZh9p8pGMx27v8WI9XSazA8q82gW/3S
         Rr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694468056; x=1695072856;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwxqNL1zXUB9OAJf/Ygs9mELpjYs6oPReuh29ZTVE2Q=;
        b=GBYtYlm6a/OvBla3pJqHGVfOGIfJ90kNUx8QOA9hGh3UBDT8c5M0CAUqquQIj/07aJ
         o/zpIV24NAfJ/7KHqUb0lCUmNlDhwtWByP8wBbO5tp2Znup8caAObqrgPr69D8owm+k8
         h43q8ZDEFc4XRxpyqL+t9g/H/+wPG6wlYrPGL6Y3fRlT3qYg3DByZp2Gdq7Dt09m9Szk
         7d8sa/G1Ozp1Ko0oedwoMcW0POr8WeUFgpkRiEAc9RBbG1YYpYtEvlQnvAfxFfq02rdu
         5uWD1FKC2rm1MOtq/jJ0/BZu4DXk/DjiSn7i9d4FBln0d1HkOb3j6dKLNMEShfViUy+P
         dKKg==
X-Gm-Message-State: AOJu0Yx1PEvAez5tTN6WGDbSN/8rtpn72y+6wZHJuZtqYk0BYDCf53PN
        CBtDp99Ablr24OkFPVFIg/PkC0rlYB/oc5qIqw==
X-Google-Smtp-Source: AGHT+IHcMR+ryqln3fSBxGzKEDejFhIMPnxZUI8UrQblXcfot9EpwsLm83Fof7MdvFLqO8WCd16dz/9x4QOU6vN4eA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b708:0:b0:581:3939:59a2 with SMTP
 id v8-20020a81b708000000b00581393959a2mr281042ywh.3.1694466550612; Mon, 11
 Sep 2023 14:09:10 -0700 (PDT)
Date:   Mon, 11 Sep 2023 21:09:07 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPOB/2QC/x2NzQrCMBAGX6Xs2YUk/oC+inhIk6+6KEnZLaVS+
 u7GHuYwl5mVDCowunUrKWYxqaWJP3SUXrE8wZKbU3Dh6K7es01a0vjlrDJDjftPTW+OFX8KJk7 swimjj/ni3ZlaaFQMsuyT+2Pbfr6XNDh0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694466549; l=1855;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=isAQzdD4TDo3zPe9CmPoe7IjN/uC1JjTZgMq1hRyNwE=; b=PhU1KfeKpdN/BDvmqV7i6qAIViRdCxXDRe+/LXWdXeF0pas87bxDJPMKvwHjUa7w8g1DIDeue
 gKAjrn2y7siAoBO+CzhL32W04xXDWNV/yjjqwSJhVE0GfveW0V6sWnm
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com>
Subject: [PATCH] aoe: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

`aoe_iflist` is expected to be NUL-terminated which is evident by its
use with string apis later on like `strspn`:
| 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);

It also seems `aoe_iflist` does not need to be NUL-padded which means
`strscpy` [2] is a suitable replacement due to the fact that it
guarantees NUL-termination on the destination buffer while not
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Xu Panda <xu.panda@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: This exact same patch exists [3] but seemed to die so I'm
resending. If it was actually picked-up somewhere then we can ignore
this patch.

[3]: https://lore.kernel.org/all/202212051930256039214@zte.com.cn/
---
 drivers/block/aoe/aoenet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581d..c51ea95bc2ce 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -39,8 +39,7 @@ static struct ktstate kts;
 #ifndef MODULE
 static int __init aoe_iflist_setup(char *str)
 {
-	strncpy(aoe_iflist, str, IFLISTSZ);
-	aoe_iflist[IFLISTSZ - 1] = '\0';
+	strscpy(aoe_iflist, str, IFLISTSZ);
 	return 1;
 }
 

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-drivers-block-aoe-aoenet-c-024debad6105

Best regards,
--
Justin Stitt <justinstitt@google.com>

