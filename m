Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B436C49361
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A6761468
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 13:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFON2a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhFON2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 09:28:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C10C061574;
        Tue, 15 Jun 2021 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tk1mvrcMufCVrgPg3C2xpZf19iy4PPS7BLzt3IIAZvo=; b=wANQzPa41ytnopaUFssGsxbY/M
        0hq96FVjjN51t4RFAdxzVXUFPl0WUQLIbryYoFCPF/RjQES70xir5/HgL6PJk1gNMd37GODvP/1Dm
        Uzt6nVMXjvWx9mYamO6qDeBp7iZ/XNXIGVbmPHNVofwUiqxf9BcX7viQOfbejADb2yzdjwQuWw1ez
        Qh42dGYWXVx7ED1ej5SSPI51boZURyYoc8+CShjqpV6o+VAVTSqlIA3wU+IjHhKuwUW7e4eZzbhFS
        uVX7vILZQklZV3RqCK7W6WJdHFzvyE3HhNauq8NtfVgWYDXTgLnBzDfEQrl8sh75f66KWeuxyh2XB
        dTCoPkmw==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt94D-006nuj-Vv; Tue, 15 Jun 2021 13:25:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 02/18] mm: use kunmap_local_dirty in memcpy_to_page
Date:   Tue, 15 Jun 2021 15:24:40 +0200
Message-Id: <20210615132456.753241-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

memcpy_to_page can write to potentially mapped page cache pages, so
use kunmap_local_dirty to make sure flush_kernel_dcache_pages is
called.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/highmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 65f548db4f2d..d0497c0daf80 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -333,7 +333,7 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
 
 	VM_BUG_ON(offset + len > PAGE_SIZE);
 	memcpy(to + offset, from, len);
-	kunmap_local(to);
+	kunmap_local_dirty(page, to);
 }
 
 static inline void memzero_page(struct page *page, size_t offset, size_t len)
-- 
2.30.2

