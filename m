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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2ECC4320A
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CC160FDB
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhG0VR7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbhG0VRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 17:17:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FC8C0617BC
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:17:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso6729696pjq.2
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9wMesWb3kMvGhORYmMr8FR6o9+jwEvZSo1EsZxY8W0=;
        b=BN7P01Ur0nT1MgFEaFehSRb7jJppIMvpuqQP+s+oBiWS7VXbf/RvYexr0Hx4+J+tRF
         ub6d2NuQ/h6uhZ5C5OC3+rwkID8I367GLLdmYSUSQoeXhXVWNYV2m0sd3TTyLfRvYZRi
         tIFkyuHmHnqC70kWh05pztablIQYnYXX+GWGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9wMesWb3kMvGhORYmMr8FR6o9+jwEvZSo1EsZxY8W0=;
        b=uAy0eGoSzg4xT+qEnYbbwlVbqqdggnb9JKfUigzr86XbCFjyB55gWMLr2fzRuISBkg
         +bi4RMKWQZpZjoMN7/eykHZnj7BaZp03FB81HZH2Y9dtIeRyCpATMgmhb977diEI6Kbe
         EJXcFXQCd0EseaeaO/dOC+hHpCZMBVCa6rq4YfjHm0ZTdz8r+k19ZI9nCfTNFedNrq6v
         B62I4+TSVztH22GVLyPpj2IAm7ixgAKQ9lYIko73tw1vOB3HFTTQ7J+At2OFtgduflgS
         XakPziKZVCQe0llawigqnaVdg/2jN2tJi5oL9jENsXLrT226AeQkSRMC81ofkzxqKFc/
         ob9g==
X-Gm-Message-State: AOAM5300sCcqMDqJKTtjCjpb0NMteOWAz776HuPWZs3EdEj7zR3Epl8f
        tvVdXOY5FMszu95vS9PAN9JFCg==
X-Google-Smtp-Source: ABdhPJwBzhqNz9CV9N0TSyJ7ZTBhPPhkncXxe8pHuZBIHnuiml3joPIijrND7KmjOEKulsBBdR6JNQ==
X-Received: by 2002:a62:584:0:b029:32e:3b57:a1c6 with SMTP id 126-20020a6205840000b029032e3b57a1c6mr24589168pff.13.1627420620372;
        Tue, 27 Jul 2021 14:17:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lk5sm3712997pjb.53.2021.07.27.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:16:58 -0700 (PDT)
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
Subject: [PATCH 58/64] powerpc: Split memset() to avoid multi-field overflow
Date:   Tue, 27 Jul 2021 13:58:49 -0700
Message-Id: <20210727205855.411487-59-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; h=from:subject; bh=EqAYyR61If64Fj2IYKFg3jD8wd3YsI3R0DZAgupjjpE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHON8m2NPAIDr9Q/N7SXLMGlDKKJPMFM5SUAuhto 7+vlDg+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzjQAKCRCJcvTf3G3AJq+CEA Ca4qR9dFfukeDpwBivSWmdN4IXrLxxds4i79tyF2RZ1NetlF3zQFjf0dOJJ6NfqCZjinnNwHjnPaFi 9x4UwneOOuPj/4rf8k7cSpmM2UreUaAAA8VP/jFKg8vdwSBqelmbZjm8ng/qha6pxe9jqRvhE2RWKP qnrUYIUXlqe7N3FgL/8eOB67y/Un3Rfqu05z/doNPDcGWYTfIhpaZu3n+amLx44YduL03EwcMECH/l NDarqGZ78zXiW9XBAw38H8M3+unTerG5RPPulpFMa3XJ+hy0ln0RAD/CKthoOCrGmjVHEls689FYmk 47Xi02bCJdYfIgjqNVNZcc95yunNV29nLCcUCjqRA9qZpvkMrJWQANAATLtxAcI+/txMZUwS94jUFC otBX6K+dP0tshHI5p9QXMMjeOFJUZsvIm5n+eNLtqZADzbxH5992mbjlaJZzSynXuRU7LnKYFwp99u ACzU3xk+GoPHSQbfn0SU7L/H8QNlNuzxIiWmgfUKY2AXa7GfFeO+JPWTK/H/PczC9Or0vmzcwp+j06 gmLqgbtlJS5EyLTqxwdJDfRPF9CCi/hV2nu4l+oo6Pue1qSXQEmcxzqGPzn+HR7xkb5suJeevW+l7Z gDF++XCKaI8rWqYNDAdfLYj6eQLBZMJ8AM/75DxdC9t3gUyhjbCYaLueTqow==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Instead of writing across a field boundary with memset(), move the call
to just the array, and an explicit zeroing of the prior field.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/macintosh/smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 94fb63a7b357..59ce431da7ef 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -848,7 +848,8 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
 	cmd->read = cmd->info.devaddr & 0x01;
 	switch(cmd->info.type) {
 	case SMU_I2C_TRANSFER_SIMPLE:
-		memset(&cmd->info.sublen, 0, 4);
+		cmd->info.sublen = 0;
+		memset(&cmd->info.subaddr, 0, 3);
 		break;
 	case SMU_I2C_TRANSFER_COMBINED:
 		cmd->info.devaddr &= 0xfe;
-- 
2.30.2

