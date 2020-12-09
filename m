Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C94EC4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 20:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC4E23D1C
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 20:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgLIUry (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgLIUrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 15:47:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F10C0613CF;
        Wed,  9 Dec 2020 12:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=62AZlsv1U7MmdVe+7QYsPomj1JbAvEv3m2KxaRaeI1s=; b=hnZkNtmsN+Zz+Ytw6E4aGAbna1
        50wtz8CxIexVZtnl+Am89O17KjRJbEM3ppv3yXxfAtzQ8LROIcox4JTDkfN+qe1NrO0I1pUwFq2KH
        xE6JfRIN9CWWEF29Vo3IM/IvNSlv2Vfth/02i+Gvh/U4om04u3n4Z88dKRE6PMRLoK/06RDT3eR7K
        u9/TMbM9mUOXR6YKj20a79N+iC6rMYv/7W79phklo/NrFwG1Y084O99Ty0D1qQLwDHPtrfr1b7nBn
        08rVRIsZTHTUACtucWqy0mnP5uMSpBnUoFlCrcIG+8A6l9blLiv/zU2sbc8ptaTX+T3XhJ85D2Xpu
        2qVgA+ng==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn6MX-0000N6-Q8; Wed, 09 Dec 2020 20:47:02 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH] block: blk-iocost: fix build for ARCH with missing local64.h files
Date:   Wed,  9 Dec 2020 12:46:57 -0800
Message-Id: <20201209204657.6676-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When building block/blk-iocost.c on arch/x6x/ or arch/nios2/, the
build fails due to missing the <asm/local64.h> file.

Fix this by adding local64.h as a "generic-y" file in their respective
Kbuild files, so that they will use a copy of <asm-generic/local64.h>
instead (copied to arch/*/include/generated/local64.h by the
build system).

c6x or nios2 build error:
../block/blk-iocost.c:183:10: fatal error: asm/local64.h: No such file or directory
  183 | #include <asm/local64.h>

Fixes: 5e124f74325d ("blk-iocost: use local[64]_t for percpu stat")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
---
 arch/c6x/include/asm/Kbuild   |    1 +
 arch/nios2/include/asm/Kbuild |    1 +
 2 files changed, 2 insertions(+)

--- linux-next-20201208.orig/arch/c6x/include/asm/Kbuild
+++ linux-next-20201208/arch/c6x/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
+generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += user.h
--- linux-next-20201208.orig/arch/nios2/include/asm/Kbuild
+++ linux-next-20201208/arch/nios2/include/asm/Kbuild
@@ -2,6 +2,7 @@
 generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
+generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += spinlock.h
 generic-y += user.h
