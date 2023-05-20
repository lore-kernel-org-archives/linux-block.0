Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE9BC7EE23
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 00:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjETAC2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 20:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjETAC1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 20:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18186E5F
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 17:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684540866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJaiYO7hPfGCITlMv/e2fYDm8/jpubbHDQ4RMy5/oPM=;
        b=FFeMIcKJTqZbZKKj5LAW89UiFZhjInYtbaZrjqvE+5wBf0tZIl7mZGg1iKtLt4DSl1qGN1
        KpajmYgvgmsTJtsLaiLqfeG+XTkkn+nbyTOZ0AModhY+LIH1MMgDMtxIXdAoyt93l7PO+8
        bjbVSGJQSgLz0Oou5kdxcjPoA0bpQsk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-gdX8HUEaPSKe1E3KxEDqow-1; Fri, 19 May 2023 20:01:00 -0400
X-MC-Unique: gdX8HUEaPSKe1E3KxEDqow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C53B1185A78E;
        Sat, 20 May 2023 00:00:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B5751121314;
        Sat, 20 May 2023 00:00:57 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Steve French <stfrench@microsoft.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v21 02/30] splice: Make filemap_splice_read() check s_maxbytes
Date:   Sat, 20 May 2023 01:00:21 +0100
Message-Id: <20230520000049.2226926-3-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-1-dhowells@redhat.com>
References: <20230520000049.2226926-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make filemap_splice_read() check s_maxbytes analogously to filemap_read().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Steve French <stfrench@microsoft.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 mm/filemap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index a2006936a6ae..0fcb0b80c2e2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2887,6 +2887,9 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 	bool writably_mapped;
 	int i, error = 0;
 
+	if (unlikely(*ppos >= in->f_mapping->host->i_sb->s_maxbytes))
+		return 0;
+
 	init_sync_kiocb(&iocb, in);
 	iocb.ki_pos = *ppos;
 

