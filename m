Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3841C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 21:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8AE20850
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 21:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfCSVL3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:11:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbfCSVL3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 17:11:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9655EB606;
        Tue, 19 Mar 2019 21:11:27 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 2/2] mm, sl[aou]b: test whether kmalloc() alignment works as expected
Date:   Tue, 19 Mar 2019 22:11:08 +0100
Message-Id: <20190319211108.15495-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319211108.15495-1-vbabka@suse.cz>
References: <20190319211108.15495-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Quick and dirty init test that kmalloc() alignment works as expected for
power-of-two sizes after the previous patch.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index e591d5688558..de10ca9640e0 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1621,3 +1621,22 @@ int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 	return 0;
 }
 ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
+
+static int __init slab_kmalloc_test(void)
+{
+	int i;
+
+	for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
+		unsigned int size = 1 << i;
+		void * obj = kmalloc(size, GFP_KERNEL);
+		unsigned long objaddr = (unsigned long) obj;
+
+		printk("Size %u obj %px alignment: %s", size, obj,
+			(((objaddr & (size - 1)) == 0) ? "OK" : "WRONG"));
+		kfree(obj);
+	}
+
+	return 0;
+}
+
+__initcall(slab_kmalloc_test);
-- 
2.21.0

