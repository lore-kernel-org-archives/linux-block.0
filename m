Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B93DC43334
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 08:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiGAIr7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 04:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiGAIr4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 04:47:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3604673900
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 01:47:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j198-20020a25d2cf000000b0066d2f5b87e7so1482106ybg.5
        for <linux-block@vger.kernel.org>; Fri, 01 Jul 2022 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ml8Z1qiNNiXT/1PzWyvvt8aN8dvJcZjDGqTV68m+tGo=;
        b=NAQpECpRDHIM/hlGNxwkg9Hv5tgmFumtJ6WiXYFdt9aQ4roUlytgKojb2oeQb8TjrB
         HtvQBKcDWTPW0CjksH/AhxabVHDzZRMvRckEaD1IChNoWcA+AfXWvMzo5dmBGoZ7rZ6N
         ISBu70K79ljdgzwwSF+syxkbcCxHMVeZ1DW4SyFLagkIxCY3sc/IbqWgF642UX89HEVY
         HCM2kY5y7QtM4/HpY7j5bkgVJKqqeel36d+kTOEv9wuWYxInCQtPmh0pNG58a4QwgHSS
         qD6mJgVR0l2XfXKAlRjasF9Q9XreGRXEuMYw9+sZwGQuRQ2K3W511ibsd9lsVTfQPphz
         1zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ml8Z1qiNNiXT/1PzWyvvt8aN8dvJcZjDGqTV68m+tGo=;
        b=h7kYdflGKhVAbq7iD2H5H0J5lQ3jZjJ+Iy4LuiRAjubttT8+SYJKmrmAoZKVUeDqZ4
         V5AVO5XJOLTarRi6cPo2ZMFWaxA6SW2xzKsqyAYoddz/8oTl56/VZppBIFwUdmtU8KQm
         y6Yj0FOYlCAy7L5EuquIeUj5XuXrQgNzUrol0iviN+Ck9vvVpWCQzaPPqtvKzULYzGkc
         xP66hsHbEeVNr+8hu/gbNluLc9HRfJ155+hUinQt0s1zxnD8tJtlXSGOFCghfRFwoWjm
         Q6zkbDxGIT4CBYDVqxbxS6eMiuk42SfR3at/qetZPEnzHzRqAviWT9IIgv48rs6pbUmR
         /6WA==
X-Gm-Message-State: AJIora/uYwKKmKCWDKj9NZqMHxqcxQZLhIiEo7izTtxrYwCg6eiyeSu0
        Y2ZE8Guh+5nKM4Gwc/gGLeCVQGLF7XDp4Q==
X-Google-Smtp-Source: AGRyM1v7ew3j0R7c9yqC49uzuTOOzGkqAmVFXXxCn9zfU56NTTgCwP9X9gSqBlJ1BgffmPx/w2LuWEXg7FpvCA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:2443:0:b0:2eb:4ffe:fab2 with SMTP id
 k64-20020a812443000000b002eb4ffefab2mr14909347ywk.330.1656665274440; Fri, 01
 Jul 2022 01:47:54 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:47:42 +0800
In-Reply-To: <20220701084744.3002019-1-davidgow@google.com>
Message-Id: <20220701084744.3002019-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220701084744.3002019-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 2/4] module: panic: Taint the kernel when selftest modules load
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Taint the kernel with TAINT_TEST whenever a test module loads, by adding
a new "TEST" module property, and setting it for all modules in the
tools/testing directory. This property can also be set manually, for
tests which live outside the tools/testing directory with:
MODULE_INFO(test, "Y");

Signed-off-by: David Gow <davidgow@google.com>
---

This patch is new in v4 of this series.

---
 kernel/module/main.c  | 8 ++++++++
 scripts/mod/modpost.c | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..f2ca0a3ee5e6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1988,6 +1988,14 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(info, "license"));
 
+	if (!get_modinfo(info, "test")) {
+		if (!test_taint(TAINT_TEST))
+			pr_warn("%s: loading test module taints kernel.\n",
+				mod->name);
+		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
+	}
+
+
 	return 0;
 }
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29d5a841e215..5937212b4433 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2191,6 +2191,9 @@ static void add_header(struct buffer *b, struct module *mod)
 
 	if (strstarts(mod->name, "drivers/staging"))
 		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
+
+	if (strstarts(mod->name, "tools/testing"))
+		buf_printf(b, "\nMODULE_INFO(test, \"Y\");\n");
 }
 
 static void add_exported_symbols(struct buffer *buf, struct module *mod)
-- 
2.37.0.rc0.161.g10f37bed90-goog

