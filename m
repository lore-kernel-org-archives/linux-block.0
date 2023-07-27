Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0056FC0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 16:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjG0QLQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjG0QLP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 12:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A1D2D4D
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690474226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6riGtniLbVW/0RUbKJK18+ZXuUEMwjT27R+MDiLMQAI=;
        b=Yr+KFc4NEp50oiB13FUfSHin8zMoVr3JIt0JLJjbcJAMYxYePUvIIkJ5dugBATkKC8kPgE
        jetQrLjzubanMgSs78LHImhXxCiXddeXP7hQd5Z6wkBqSMp2LEj9jjOiXTYzXLiX9XWsFC
        /nytva2qcTkMxMnCRq54CqWZ1NUbvng=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-nOoNmV6EMre8aO0nn0whDw-1; Thu, 27 Jul 2023 12:10:24 -0400
X-MC-Unique: nOoNmV6EMre8aO0nn0whDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BE30185A7A5;
        Thu, 27 Jul 2023 16:10:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC402C57964;
        Thu, 27 Jul 2023 16:10:21 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] shmem: Fix splice of a missing page
Date:   Thu, 27 Jul 2023 17:10:15 +0100
Message-ID: <20230727161016.169066-2-dhowells@redhat.com>
In-Reply-To: <20230727161016.169066-1-dhowells@redhat.com>
References: <20230727161016.169066-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix shmem_splice_read() to splice only part of the partial page at the end
of a splice and not all of it.

This can be seen by splicing from a tmpfs file that's not a multiple of
PAGE_SIZE in size.  Without this fix, it splices extra data to round up to
PAGE_SIZE.

Fixes: bd194b187115 ("shmem: Implement splice-read")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Hugh Dickins <hughd@google.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2f2e0e618072..0164cccdcd71 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2841,7 +2841,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			folio_put(folio);
 			folio = NULL;
 		} else {
-			n = splice_zeropage_into_pipe(pipe, *ppos, len);
+			n = splice_zeropage_into_pipe(pipe, *ppos, part);
 		}
 
 		if (!n)

