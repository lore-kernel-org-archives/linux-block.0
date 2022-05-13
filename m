Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644ECC433F5
	for <linux-block@archiver.kernel.org>; Fri, 13 May 2022 08:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378318AbiEMIcn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 May 2022 04:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378266AbiEMIcf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 May 2022 04:32:35 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5713A2A7C36
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 01:32:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x23-20020a170902b41700b0015ea144789fso4051787plr.13
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0ybWbXGPDsdksfVbXJMzQ1kLilXdTLhR2XM1EfoNTaQ=;
        b=mDbxxzGMPRe66EbTeOC0DGcg92DtfgZjKodWRekjDNOouMcdlsxRTubPmRzKzEg//+
         NCtUoa0kB6dTGI5dBm+INXN2ngqEyVFZVXDa1xF8ystd1DFn7NF/874SjcTIb3v1qTDL
         UymPtLbOczNqc1qU+w3EfujQ9VYJzaSa2Qnvmnf/lzLYCpJn4fZi+optc113jKzHURNo
         Icw7XTBDwAPWE0plpyLnMfuriavPbm//BT2ukq/OrV6jT80TPt0YfRKsZBzv9Q1B6pqz
         vgtX3KGFCOlzV8Ozs/+RNXW5okVxVEvqN77emPfFAivLiAuMxWkThJEtfhfN9RcB3J/t
         lPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0ybWbXGPDsdksfVbXJMzQ1kLilXdTLhR2XM1EfoNTaQ=;
        b=u7aAbI6319erCXAYUVHcc5/Jc7GEY0GeySbSfftRLT5cjsoJSFLEO3cXDnKiYlIVVJ
         qE76KjDPDdsP2a4l+uNK8pkrreMZ9MNWWUvxwQm43We+6iqKMgIjS7IfkPy13dT/Aizt
         id+6cm8VqoCrEhBZMdRXaCfiIr8/ceEuY4AfoB0UZQxQYAZUl0V/PSwZ7lPh2PQ/SOT8
         1/WPNSxzJzoXw8EGmbFr+tDXvDAa82uwSHZvbRjfTBZZLNQI+jnaAhtxluWN7NM49+Pq
         K7mTff2WarZKN2X49wFRuW8fdBguQbyEX8fcx5Y58LaRVjeu6QDChntrf85JvoliSY39
         7VjQ==
X-Gm-Message-State: AOAM530i6NpjDx9SkGU5lOHYHxkiqF/Ut6IOBOuM8TRAxHqVXNKfCUoB
        YD91bq/g3VRrqMYHgTC1luxHKdd/Hc6+Ag==
X-Google-Smtp-Source: ABdhPJwfM5WbnpLP6WV99kx1KJIHYyM2xlBrsLZ0h+Pzul4XBI2zEL0Co3qEuGI3DWYVY6zO3MyaEFEHAAIkrg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:903:248:b0:155:ecb7:dfaf with SMTP id
 j8-20020a170903024800b00155ecb7dfafmr3832462plh.84.1652430751562; Fri, 13 May
 2022 01:32:31 -0700 (PDT)
Date:   Fri, 13 May 2022 16:32:12 +0800
In-Reply-To: <20220429043913.626647-1-davidgow@google.com>
Message-Id: <20220513083212.3537869-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 2/3] kunit: Taint the kernel when KUnit tests are run
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
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
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
Due to KUnit tests not being intended to run on production systems, and
potentially causing problems (or security issues like leaking kernel
addresses), the kernel's state should not be considered safe for
production use after KUnit tests are run.

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 0f66c13d126e..2b808117bd4a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,7 @@
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
+#include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
 
@@ -498,6 +499,9 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
 
+	/* Taint the kernel so we know we've run tests. */
+	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
+
 	kunit_print_subtest_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
-- 
2.36.0.550.gb090851708-goog

