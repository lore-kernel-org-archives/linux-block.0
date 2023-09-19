Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623C5CD3437
	for <linux-block@archiver.kernel.org>; Tue, 19 Sep 2023 05:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjISF17 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Sep 2023 01:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjISF15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2023 01:27:57 -0400
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A210F
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 22:27:52 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1d6bee775efso4004243fac.3
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 22:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695101271; x=1695706071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLBIayzA2t/uL9eztp+Xlm1iGqaTM0uD/xEsY5Jfenk=;
        b=Jf5i8a8Dx0Tli6Gwz+CG1YZxBeckVR0mOyf5pzrHj8j/8+WXVuBiIfNRdr36Wvhlkm
         N3q0BiEKUmQLMa2JJxCqHMhytzWLgtlWSO42dppOO1+4dpnMTrYCtVBIofSeTaj0VYIM
         w/OIE8Jygl6IWAJPjY23FcJSWV/U9r4qieP8Fh2+QAG3bYTTkH9G5YAYc+Atcd56Jxlq
         JBjl1WP6mwp7DoaKir8OiliSGgRx+mMRvGbfvpgDqU8P+1vH8r+x2DPBBbb/MoBu6rPA
         Diu2F5zNlSDVWdHYXTIVjdjA1vRPycewP0e4Nm7+UTW5TPqlnv2w1+glf1H8bJCQPy6s
         t/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695101271; x=1695706071;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLBIayzA2t/uL9eztp+Xlm1iGqaTM0uD/xEsY5Jfenk=;
        b=wYmoLOciWnsDVAEhBtzExXMpwk0FbE+45nWzVEkKo5X1brFVidb5laa/tUUbRYTB5u
         noKUtZznCee5MVCEh7eMapLZlfKKA1FhAeVuR4AJ038kAuhkQe4oWy9/wytD52ZVBRMI
         PqWmPluFy6a5d8i8kNfe4Y0oXYaUVjZSvuiIgend7zSb6zNoVex0yB8zsgO9jgIafKKM
         EGChZo6JUz0/OPCWz84vMxBl4CvpSu91dgMJPrIdaq77NWEGmUDzfUv7sewEoM/uFfD3
         bASfzuN7eh25PgQXUHXTKlrzoaFmDk/6960Ak/mJIb7/ZaJQiieprNs1/EJPrC2Jbmyl
         UUSg==
X-Gm-Message-State: AOJu0YxIS6LLehf7jmj3S2rRGruihOVfz8euP697PgMEfD53NS8t5itA
        IqUr7ArIvzTi7flIe3pu/FCYuLgqsRwa0kp9QA==
X-Google-Smtp-Source: AGHT+IH6FpsfoY3LuGAbwkojpyhbI3p0GHH+ej7UU/GDy6SV4M5mdYIoFu6DkhWFv8/jaKo1TCVzKirWO0cB9kmxqQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:9575:b0:1d1:3ff8:9f80 with
 SMTP id v53-20020a056870957500b001d13ff89f80mr4312600oal.8.1695101271550;
 Mon, 18 Sep 2023 22:27:51 -0700 (PDT)
Date:   Tue, 19 Sep 2023 05:27:45 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFAxCWUC/5WNQQ6CMBBFr0K6dkxbEIMr72FYQDvARGzJtGkkh
 LtbuIGLv3h/8d4mAjJhEI9iE4yJAnmXQV8KYabOjQhkMwstdSkbpSBEdmZZwTIl5AD97M0bOo/
 HHEYwIHVlse9sreRNZNHCOND3jLzazBOF6Hk9m0kd71/6pEBBU1dlDpT3YWieo/fjjFfjP6Ld9 /0HIat21tUAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695101270; l=1984;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ZndI1+kSvT/7BAM/nwag5C32Mjt5X/Kd4DJZMaoDm0g=; b=dM86F3nCqYDe2T1msZGhGTmrC9w3vUBE6ZHr8wc0bQG7jDB3HysLi73A5xGbYEIqQopS13Kzo
 uot33iH+WZsBGL/ZHL7MXAOYhi7cq689F5nLZ3HtUR0dJROXMV+mlET
X-Mailer: b4 0.12.3
Message-ID: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
Subject: [PATCH v2] aoe: replace strncpy with strscpy
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
Changes in v2:
- reword subject line (thanks Jens)
- rebase onto 3669558bdf35
- Link to v1: https://lore.kernel.org/r/20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com
---
Note: This exact same patch exists [3] but seemed to die so I'm
resending.

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
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230911-strncpy-drivers-block-aoe-aoenet-c-024debad6105

Best regards,
--
Justin Stitt <justinstitt@google.com>

