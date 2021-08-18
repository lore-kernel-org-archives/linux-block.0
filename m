Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA532C43214
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977EF61058
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhHRGRd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbhHRGQr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:16:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E67C029829
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:14:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso8247255pjb.2
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqHRpTF29XKCvHESFQ890ZRLt8tV/z5c3XHhrLDSkrI=;
        b=eDnWZw9KRm46hwXvZT4C7S5d+90hyINh4v1SZZHIktQhca39Kv5j4305RFuRZO4r+N
         FpSZgAZO8EAZPKCqstt9sYRz4H1aNUG21Hkzfac89V2BS6o4rE2tpIfJtZvJgvvE0tGw
         8wAP/HK8m8mUdps9C8RUZGGooYOTstKeYh1Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqHRpTF29XKCvHESFQ890ZRLt8tV/z5c3XHhrLDSkrI=;
        b=cBFwA0/TCta3ABqCCLqdCF62cLqnP3CvCeqmoKmLaaZFRD5zj4+zc5xYNCJMwOD1TT
         Gs/iBAvQnwQ/WVVfFuV9Q2BjIds+6b1qE/zHz6F9P2SRsb5nBwdl/BLwt4hkpk+ZFUYv
         0S+r1FS5z1TqAFsBCDv+hjnmcpymRLCvQaZCjH7ptu5lN3HI80aj4xw9YfR/8aZFlLmR
         6X+8rQFLnPo4fUBcht6RUXfzos2lLVh2TziEyxHoTbk54zUSpZ9KlHT8ZEg+dvXjwYx4
         wLfwY180/8zFWqS0QIpDNDfKcmlc45fKWUN/q6QGd1vwOd45Y4sX9bQA1sv2BD5QfWa+
         oeOA==
X-Gm-Message-State: AOAM532QZMRUvS1HhdNGizFqNgpF8Qx3p91aSmchWSQGzjgLloVfMvoh
        SkKuox8j5yz0FfvdizRI7Fl1AmLoAQWPww==
X-Google-Smtp-Source: ABdhPJzs0l6+96q5WrJaIq9sc6XvKb4+TMWLp34figTZCCyBwzySh6PWPIKNRtNT4xpSHHkkTwp3EA==
X-Received: by 2002:a17:902:cec3:b0:12d:92c4:1ea6 with SMTP id d3-20020a170902cec300b0012d92c41ea6mr5883424plg.36.1629267264338;
        Tue, 17 Aug 2021 23:14:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u10sm5718071pgj.48.2021.08.17.23.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:14:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 50/63] tracing: Use memset_startat() to zero struct trace_iterator
Date:   Tue, 17 Aug 2021 23:05:20 -0700
Message-Id: <20210818060533.3569517-51-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; h=from:subject; bh=tJ+Y8mubd5vChiEdKyhrwIAPkGIRLmuKu7c5cVoFF8E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMpD14ogHSXr5bFvuUHYu3T5qJe0zYALPCZMtZa BMo6QAuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjKQAKCRCJcvTf3G3AJmAwD/ 0a3+zKByTlHW7da31ew04MLWM2GyDtX5IWTWqZsa8eYoXbBB5X7LZRQLJ1vlQZHRLhepR9ZpITXmne EiQC9Yi2RCSGHYXs1DT8c2kWev59MckO9Ru6PbJsXCCCEtTQ6DMpe/Jx5fGA8+6uai2MdlkbPr1hcJ pBSeJNFQs0Pv1vqmL283XNUPLYaVRRlPmA9Gp6u3cYUEC+MvJh//1ksZAZO4Nyg2WQnN8olRr3f3NE /FPwlpkC0jjYP6MOJqAsGXQsShWeRQihUK27+fSMl0qP0sQvOypGdnWB5Xt9pHnrb59B+NoIWV3usD tlUXL9PjYEJYMDWPQTUUNPBMZZKOHI+48wGm37V+dXOW7TWP6k1ZaORRpaSbK4ePyA4y/UOyFr9kg/ uCpCZQbVxO0XsyHwZnPxyR0ffSAr5pZsGQoIXVSdGOiCT/l0l3GHYuulIqOqhrbldUvZjy3etP7MiI hx1VUn4EjkhIMB8HWOeouTN9VqnOXsp0Uoh3nMHIAOMLkJS8l1ptPjxUjAbP1ZRctjIKVTGS6xk+Mc BWlhshbZH64vEGQ9HoKgHm6UlwyYt5R2mkzOSjk0VSY4jGO4wg5giXsw55wRe6w4igcWbd0lCpFOWG qRUJgP1YlRnTAtp59niaAQ2aRXBKcpue4WIdo6iOcrFKIwc2EolBb7yDoGAA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() to avoid confusing memset() about writing beyond
the target struct member.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 13587e771567..9ff8c31975cd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6691,9 +6691,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 		cnt = PAGE_SIZE - 1;
 
 	/* reset all but tr, trace, and overruns */
-	memset(&iter->seq, 0,
-	       sizeof(struct trace_iterator) -
-	       offsetof(struct trace_iterator, seq));
+	memset_startat(iter, 0, seq);
 	cpumask_clear(iter->started);
 	trace_seq_init(&iter->seq);
 	iter->pos = -1;
-- 
2.30.2

