Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799C7EE49B1
	for <linux-block@archiver.kernel.org>; Tue, 22 Aug 2023 23:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjHVX73 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Aug 2023 19:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjHVX73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 19:59:29 -0400
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45719E46
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 16:59:27 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id 006d021491bc7-570bc7d71fbso3225795eaf.3
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692748766; x=1693353566;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cGRueg2eqYbMCY2ShRbCc3/RucSV6L/B/eSOD25AmaY=;
        b=oE7rm9AjFtO/wJhPR4I/B3C9PzPl0U9GIJtJ8lqhBf1+Myf/+D2iSRfZgrmLr7mR/x
         nMayejh5oe5AWTapQPCLq5jq9CY0Pyc9ctwVerkEBlIECHUhVK4vkKvWYwR27pziznqm
         9W/6Luzdj+ygswvRfmFxADqiAuYOViFaMm49y1CXqPV3sBb/+KuycOsoULepp7onHymj
         YJMqT/JW19FcVl0zqu0VHtUAcLgBtMlKbMHcBgSSsL0o1dCaBKqqRdrNmCLdDIilXVF7
         j8JurhCuRPmIhc+12Fomrtw8IDBZ0+NlB1WaYQiZQ5AwOcourf0LmrvpQCxGkEeWzW/q
         LmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692748766; x=1693353566;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGRueg2eqYbMCY2ShRbCc3/RucSV6L/B/eSOD25AmaY=;
        b=VF+9ukHCf/RvTbg9bYd/u7l+fGdbUM4oiXSZH+htiLgs6I6dmt7Edl7ESnUofRRwNc
         MncpH0puDTAxI0aGwWssOnJCqVSE2fQ6c3HXafp+GZVN4EFUeUsK5X0lPvZbsPCTqJEU
         HXR9N+QaAtTGOFIbZwhLJtAPaSo2Mn8Po4iEQJjZrAA5JRj+5vW4v965nSpHr+0MbdkC
         7UIlRsBD7184woD9CmdyqXbWjqCXkiUpT9oxvsNUi4iQcKkpkOPZdLsNZRuznTOApE6L
         z2kM1I8FgtMCLnkXHMJWWBPwiIu5SiZYJ6rgVzPS20TsIQqUhKzwTMJm60HjuKc5WaKK
         b17Q==
X-Gm-Message-State: AOJu0YxH2fbSW0qQvNeAMtJybFJqr4z4WCMLQvmtVZaywCHdHqOhGs5v
        0hqvrIUpNZ6PRx9phgiPUNCr/I+YKzlnSsV4Jg==
X-Google-Smtp-Source: AGHT+IEg7NbVScd59jOYBOeVb3GuBkFoZlJ1jMAeIVZP8P7/g2W+bAHAovNBatxzdjVp9Qhlv5I+h6M7X52P9QgtDQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:c796:b0:1bb:91fa:7aab with
 SMTP id dy22-20020a056870c79600b001bb91fa7aabmr174453oab.1.1692748766615;
 Tue, 22 Aug 2023 16:59:26 -0700 (PDT)
Date:   Tue, 22 Aug 2023 23:59:26 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN1L5WQC/x2N0QrCMAxFf2Xk2UCtjIm/Ij60WabBrStJGcrYv
 xt8PHDPPTsYq7DBrdtBeROTtTicTx3QK5Uno4zOEEO8hGuMaE0L1S/meaU31qRNmjuGtIyzFN/ nBYepz0SpDwMn8KuqPMnnn7k/juMHT0R0HHYAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692748765; l=1601;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=DvMuu8/lxku646YrnJJTNn2dZrYri5zBU+GthJXHRdo=; b=y9qu1DfwgWfym6uoXSaFbpI+RHlMMNIUgnNRgLwXSTUj4rO+8MpulMdSPc9QurH/sB/n7zscE
 V8PMAm229yiAOd/7pdZGUlXbYKP5Dt7IqsFe36jFT6eAtvHiQDn1fkp
X-Mailer: b4 0.12.3
Message-ID: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com>
Subject: [PATCH] partitions/ibm: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 block/partitions/ibm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 403756dbd50d..e5893cf71b57 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -111,11 +111,11 @@ static int find_label(struct parsed_partitions *state,
 		    !strcmp(temp, "LNX1") ||
 		    !strcmp(temp, "CMS1")) {
 			if (!strcmp(temp, "VOL1")) {
-				strncpy(type, label->vol.vollbl, 4);
-				strncpy(name, label->vol.volid, 6);
+				strscpy(type, label->vol.vollbl, 4);
+				strscpy(name, label->vol.volid, 6);
 			} else {
-				strncpy(type, label->lnx.vollbl, 4);
-				strncpy(name, label->lnx.volid, 6);
+				strscpy(type, label->lnx.vollbl, 4);
+				strscpy(name, label->lnx.volid, 6);
 			}
 			EBCASC(type, 4);
 			EBCASC(name, 6);

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230822-strncpy-block-partitions-cmdline-ibm-7f5bcca507ea

Best regards,
--
Justin Stitt <justinstitt@google.com>

