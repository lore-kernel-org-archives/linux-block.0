Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E447CCA47B
	for <linux-block@archiver.kernel.org>; Sat,  2 Jul 2022 04:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiGBEKt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Jul 2022 00:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiGBEKj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Jul 2022 00:10:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C922FE7C
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 21:10:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c339f73c3so32305127b3.8
        for <linux-block@vger.kernel.org>; Fri, 01 Jul 2022 21:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HBYnSHzQWg2Lp2cioqz+iG/q+4XSrXc7FbjoZdcHpbA=;
        b=lxI8R+2BiFyIZIQT3Z8E6VUUX7SJWJwlS4m8uYrDpLk9tJq1hJfYZ/wKsRPQ7un8xP
         BGC68H6zMkzJxgQEO3lAogc4mt1HjWX0CL0tpdOx+ihRO8huvjSujzsHIJDwr0qFUA+R
         HH0TCAR3RB5ZVNcDHtskNIwPUBSOmp/viRstPTFEgyxsS+clwidWKThmtmPKLi0+3lzh
         tcVE0aSlTOG60UOz8sUQtA5g3WgC/7svYkE/JA9yy5UrVvgWWwcwGc80vG+3PfHt9O+O
         L+PopdPOgg43U82wOfInv41nEGulTRdZOcZGJmmvghaGL9GT1q912vvmXvPuq5FlMN7v
         jsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HBYnSHzQWg2Lp2cioqz+iG/q+4XSrXc7FbjoZdcHpbA=;
        b=dsCZNXXUMc81oT3ifKJ2d6eTYo8DpXJ6j+FPy/4cixpwlOyFkEgXrSogM1C5w++c3c
         E7dByDTmjfRgBYFUXYlxSG6EQTo3pO1KGl1wxBSSPEhMT70RsRhEbziiwmd077FYl/P9
         TSopcFN8+RH6GwbChj55qQaDBbLmPDjWQ6ZwbhIDVkE61lazU7Z5Kta3a9aP7PAU2NZO
         5vfpU8rlVhF261kqK2QdlqA0xcLdH6fKLaM8pPIwb6pm+VdP4Yl77kUdCN6ZJ42cTFVv
         /9LDoC77u9/PJuhjw29qCAyUROhCyafBp7uZn/yJwKEtM1TUyyu/Rf/b6AS2Al7LktTn
         InkQ==
X-Gm-Message-State: AJIora9GTxa/phZkXYsh47yGXAgdIigx8raH3zDfc8s//jerGBuhlIVC
        uOp7ekX7otfcjOuVZyklFs6zuVrCKttBag==
X-Google-Smtp-Source: AGRyM1sGhN3kPsCRXpGwIS0KN1F+hayAdFlP3aPqIerwHYupXDbnptnxmhxIJYlrF/5cw+l2900yFBjIdeAaaQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:74a:0:b0:31c:c28:a620 with SMTP id
 71-20020a81074a000000b0031c0c28a620mr21591367ywh.137.1656735018635; Fri, 01
 Jul 2022 21:10:18 -0700 (PDT)
Date:   Sat,  2 Jul 2022 12:09:59 +0800
In-Reply-To: <20220702040959.3232874-1-davidgow@google.com>
Message-Id: <20220702040959.3232874-4-davidgow@google.com>
Mime-Version: 1.0
References: <20220702040959.3232874-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v5 4/4] selftest: Taint kernel when test module loaded
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

Make any kselftest test module (using the kselftest_module framework)
taint the kernel with TAINT_TEST on module load.

Also mark the module as a test module using MODULE_INFO(test, "Y") so
that other tools can tell this is a test module. We can't rely solely
on this, though, as these test modules are also often built-in.

Finally, update the kselftest documentation to mention that the kernel
should be tainted, and how to do so manually (as below).

Note that several selftests use kernel modules which are not based on
the kselftest_module framework, and so will not automatically taint the
kernel.

This can be done in two ways:
- Moving the module to the tools/testing directory. All modules under
  this directory will taint the kernel.
- Adding the 'test' module property with:
  MODULE_INFO(test, "Y")

Similarly, selftests which do not load modules into the kernel generally
should not taint the kernel (or possibly should only do so on failure),
as it's assumed that testing from user-space should be safe. Regardless,
they can write to /proc/sys/kernel/tainted if required.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kselftest.rst      | 9 +++++++++
 tools/testing/selftests/kselftest_module.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index a833ecf12fbc..1096a9833550 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -250,6 +250,14 @@ assist writing kernel modules that are for use with kselftest:
 - ``tools/testing/selftests/kselftest_module.h``
 - ``tools/testing/selftests/kselftest/module.sh``
 
+Note that test modules should taint the kernel with TAINT_TEST. This will
+happen automatically for modules which are in the ``tools/testing/``
+directory, or for modules which use the ``kselftest_module.h`` header above.
+Otherwise, you'll need to add ``MODULE_INFO(test, "Y")`` to your module
+source. selftests which do not load modules typically should not taint the
+kernel, but in cases where a non-test module is loaded, TEST_TAINT can be
+applied from userspace by writing to ``/proc/sys/kernel/tainted``.
+
 How to use
 ----------
 
@@ -308,6 +316,7 @@ A bare bones test module might look like this:
    KSTM_MODULE_LOADERS(test_foo);
    MODULE_AUTHOR("John Developer <jd@fooman.org>");
    MODULE_LICENSE("GPL");
+   MODULE_INFO(test, "Y");
 
 Example test script
 -------------------
diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
index e2ea41de3f35..63cd7487373f 100644
--- a/tools/testing/selftests/kselftest_module.h
+++ b/tools/testing/selftests/kselftest_module.h
@@ -3,6 +3,7 @@
 #define __KSELFTEST_MODULE_H
 
 #include <linux/module.h>
+#include <linux/panic.h>
 
 /*
  * Test framework for writing test modules to be loaded by kselftest.
@@ -41,6 +42,7 @@ static inline int kstm_report(unsigned int total_tests, unsigned int failed_test
 static int __init __module##_init(void)			\
 {							\
 	pr_info("loaded.\n");				\
+	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);	\
 	selftest();					\
 	return kstm_report(total_tests, failed_tests, skipped_tests);	\
 }							\
@@ -51,4 +53,6 @@ static void __exit __module##_exit(void)		\
 module_init(__module##_init);				\
 module_exit(__module##_exit)
 
+MODULE_INFO(test, "Y");
+
 #endif	/* __KSELFTEST_MODULE_H */
-- 
2.37.0.rc0.161.g10f37bed90-goog

