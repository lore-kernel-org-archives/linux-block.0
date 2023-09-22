Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629CECD4942
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 12:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjIVMDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjIVMDd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 08:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E36198
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695384160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZvLwoc939E6B4TZcwRPSf2buY4OlPtMZfRg4M/9mP0=;
        b=ZE1Q66RMltzG/3H2hIqk1DESyqIeQJnYO0cgCR5DraLy4ts/wwfk1Hsh46AlrTl5h8oncg
        EzogCJvXmiDf173TkG+Tlwnw25a6sBFisCtVrgpIyL1hY2ieHKp5LFf4ZwsVx/N5qh36uR
        Mk+dU5Ny9LwaN35fJ1rbEHqabiAbIEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-9KECr8cHMfC82Ed_BGv0kQ-1; Fri, 22 Sep 2023 08:02:35 -0400
X-MC-Unique: 9KECr8cHMfC82Ed_BGv0kQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4981C803470;
        Fri, 22 Sep 2023 12:02:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AA7310F1BE8;
        Fri, 22 Sep 2023 12:02:32 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/13] iov_iter: Remove last_offset from iov_iter as it was for ITER_PIPE
Date:   Fri, 22 Sep 2023 13:02:15 +0100
Message-ID: <20230922120227.1173720-2-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-1-dhowells@redhat.com>
References: <20230922120227.1173720-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that ITER_PIPE has been removed, iov_iter::last_offset is no longer
used, so remove it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 include/linux/uio.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 42bce38a8e87..2000e42a6586 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -44,10 +44,7 @@ struct iov_iter {
 	bool nofault;
 	bool data_source;
 	bool user_backed;
-	union {
-		size_t iov_offset;
-		int last_offset;
-	};
+	size_t iov_offset;
 	/*
 	 * Hack alert: overlay ubuf_iovec with iovec + count, so
 	 * that the members resolve correctly regardless of the type

