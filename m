Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BA5C77B73
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 13:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjEVNws (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjEVNwM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 09:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D192DE40
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OAfj5fBZSZu8a/UyjUmcAHzT3o8yzjmkKwDwGprM6r0=;
        b=gvdQeTHvvGiIFDS5lxNMpckA/C7S259eURZltxOEq83FKRGPKJd+6AUQKKv+l7tnsqjTWU
        t8JwpZC9OkYMMPqBqbkNwvKqH0/Xjpf4cJotZAFvh0Pmi4IBQyfU1WzaO+yhFlPxgbzHf+
        40LHZq4ZEP0b12aknb+s49x8h9ydYio=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-ESFFS34sPvibgfGTGCbRAQ-1; Mon, 22 May 2023 09:50:49 -0400
X-MC-Unique: ESFFS34sPvibgfGTGCbRAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 160012812947;
        Mon, 22 May 2023 13:50:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0BB8C1ED99;
        Mon, 22 May 2023 13:50:45 +0000 (UTC)
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v22 06/31] splice: Check for zero count in vfs_splice_read()
Date:   Mon, 22 May 2023 14:49:53 +0100
Message-Id: <20230522135018.2742245-7-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make vfs_splice_read() return immediately if the length is 0.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/splice.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index d815a69f6589..fe3309ffeb26 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -891,6 +891,8 @@ long vfs_splice_read(struct file *in, loff_t *ppos,
 
 	if (unlikely(!(in->f_mode & FMODE_READ)))
 		return -EBADF;
+	if (!len)
+		return 0;
 
 	/* Don't try to read more the pipe has space for. */
 	p_space = pipe->max_usage - pipe_occupancy(pipe->head, pipe->tail);

