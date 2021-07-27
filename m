Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB87C00143
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DFC60F9D
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhG0VHR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhG0VHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 17:07:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F8C061384
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:06:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ca5so1790782pjb.5
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/9n5XlKkS6wfkCIPw1DbbDsmNaE09gzmWAUlzSJHk0=;
        b=SW72vFpyRvi/mMVr/UQMOgHPlxYF/P0e1ZiidnPntTAcbmVZzEGGh8mQvyc6/PMYan
         7VRaIK2m566aD8CTsIKSvbx/ZXJ+9IYZ/X/O7tqEYF1n1rL4di55gpn/tChdbhLwc+Wz
         CXtVDDX34F4hVt3hvgvuSFi8Unf3XeFPwkISI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/9n5XlKkS6wfkCIPw1DbbDsmNaE09gzmWAUlzSJHk0=;
        b=AX6NnbKc8+4QCCtftTd5uBqWOQbmxMGMpOYe9ElyFd5x1uniOvsBMQB7AtVjNwGO/Q
         ssqKcQqNOtVkqxcysvQyxnRM4TVQInOyqTQ1YMEJq+LHHcg3W/db8rwGUm/oiTbPSIwE
         YDccb6Nv4PXHvaFE8Q1jGV1os3QqEh1BBvYcRpnqZ1Say6zzrpbEO2xZqEOQmgXHolos
         sYB+luGbeldEeP9SjHAGJgCwCZlQeuutcHxSQvVp11SwgGdopL6BEvA3bNI83jI6z8O4
         weIIY8LYgDEbXhCucSDCaBovb6qQpQO/+baITHZUd14VGv0yoA+q/OV2VUE0EP1YpLL7
         i+vw==
X-Gm-Message-State: AOAM532xSUDKsogZTZML9BxGPit9KRtjcJOanzxB0FS//aimj/FnYIhR
        zBDwf+gCq8XmrdZkdwmF556Hzw==
X-Google-Smtp-Source: ABdhPJxaFQSeLhkc1zJ2oaBRJsMZBtjwIKQhIZuTJXa2K2J8IKVPpYMViisfXlARKBOGaL/7RusDbg==
X-Received: by 2002:a17:90a:12c7:: with SMTP id b7mr6026153pjg.205.1627420017868;
        Tue, 27 Jul 2021 14:06:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r18sm5038817pgk.54.2021.07.27.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:06:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 41/64] net: dccp: Use memset_after() for TP zeroing
Date:   Tue, 27 Jul 2021 13:58:32 -0700
Message-Id: <20210727205855.411487-42-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; h=from:subject; bh=setFCuudESAmPvU7TENmlV2MS4FRl7JRml2jjTFJDIg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOJKZ5loXhOKkjkBoj4absMkEGlM+ZkGAgDZtTY /isiJOGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBziQAKCRCJcvTf3G3AJl2GEA CkmbILRtScVKazMb1tWpR5Wl/pQ4wUktuV62qIpYEEpFPkHrnESIQz1ChkzSepdcASTNc4T6oa0NP9 WsXo723hzRQElBcUpAdaEQZWe/aRzQgxz6NuJ0ucec44ap26fdlOUq5jkNdSul5xj992thaeMiUWHl M4YJzdgCpzk8OEKhzLzvrViKkK+IaPDmTMBwHh7u5gjX9tk2OqSPx/ZXot6tYvhFg6/Oy0vv+xHrlp iovAgyyLvDPGPpUEgGj2aKBFXc/d/xxdCSuI3b1elrnHoEBod1sM3BVLd8BTraljZmNAi7wrINJzHM eu2aKaVwpvUJwWQr2BuBBRGeV74y1K8w+/Tvp0fufvz6558D1uGi5jCrDj5V4/Nj5+HrvI6IbWlYbY NSCPJB6kzUX1DRdtcu/6/wMtBFe02I7zLytHfwOcQVNqWqm6EA+YewjYVECp7lCvhT+po+Tp2LcZA6 YKyyOzP6+CTDLOyriNbgoebelLFhlWWOSb9rZGEBhs9FxI4qFJJAxmatGkCcUH0MYAz6v5PPfjvR86 yjrrxYWYwC6cjmhctqIhpAdMEd0GZec2ed3KYFABa9OyGSC8Ezex48JITcr9RBnKCdqux3UCJodziE nhi84Hw40jD0Ho9czi4juaFwDxA2xtuq+zKB1K159GTFsJfOh3CFAYS1xoow==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_after() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/dccp/trace.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/dccp/trace.h b/net/dccp/trace.h
index 5062421beee9..3c2594da49fc 100644
--- a/net/dccp/trace.h
+++ b/net/dccp/trace.h
@@ -60,9 +60,7 @@ TRACE_EVENT(dccp_probe,
 			__entry->tx_t_ipi = hc->tx_t_ipi;
 		} else {
 			__entry->tx_s = 0;
-			memset(&__entry->tx_rtt, 0, (void *)&__entry->tx_t_ipi -
-			       (void *)&__entry->tx_rtt +
-			       sizeof(__entry->tx_t_ipi));
+			memset_after(__entry, 0, tx_s);
 		}
 	),
 
-- 
2.30.2

