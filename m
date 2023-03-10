Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53EAC64EC4
	for <linux-block@archiver.kernel.org>; Fri, 10 Mar 2023 16:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjCJQRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjCJQRY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Mar 2023 11:17:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC3CFAEF6
        for <linux-block@vger.kernel.org>; Fri, 10 Mar 2023 08:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678464684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VF7DOSFSoxperMCR1c0beoAVNr9jhMKzR2GYQ6m9DTA=;
        b=exa6xlXj2aMYjJ3WCYa8U7yy0k9ks9PUjPu2Dobm7tN/gnsXbDeYHMNVUliazChnAjbbVx
        LeTvBnj89wEv8B06BFOp67yOC9wBUmqOfVh7aaumzi99tyrcqomYtvsfbrX8gSJC4x2cQg
        XcgHuQ2XHB5qJxV2b3+QBEExfq5lwPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-0nmZr2faN_Ob6cqxJso-SQ-1; Fri, 10 Mar 2023 11:08:14 -0500
X-MC-Unique: 0nmZr2faN_Ob6cqxJso-SQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 612A3185A794;
        Fri, 10 Mar 2023 16:08:13 +0000 (UTC)
Received: from thuth.com (unknown [10.45.224.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C0A2492C3E;
        Fri, 10 Mar 2023 16:08:11 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, Chas Williams <3chas3@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 5/5] scripts: Update the CONFIG_* ignore list in headers_install.sh
Date:   Fri, 10 Mar 2023 17:07:57 +0100
Message-Id: <20230310160757.199253-6-thuth@redhat.com>
In-Reply-To: <20230310160757.199253-1-thuth@redhat.com>
References: <20230310160757.199253-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The file in include/uapi/linux/ have been cleaned in the previous patches,
so we can now remove these entries from the CONFIG_* ignore-list.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/headers_install.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 4041881746ad..36b56b746fce 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -83,10 +83,6 @@ arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_IA32_EMULATION
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_X86_64
 arch/x86/include/uapi/asm/mman.h:CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-include/uapi/linux/atmdev.h:CONFIG_COMPAT
-include/uapi/linux/eventpoll.h:CONFIG_PM_SLEEP
-include/uapi/linux/hw_breakpoint.h:CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
-include/uapi/linux/pktcdvd.h:CONFIG_CDROM_PKTCDVD_WCACHE
 "
 
 for c in $configs
-- 
2.31.1

