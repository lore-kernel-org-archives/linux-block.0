Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59D0C27C7C
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 17:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjATR5l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 12:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjATR5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 12:57:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA75474DC
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674237376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ta463GNWpnL1eda0EOJixqIlh22m7Il+MjZ51ImK1zc=;
        b=ZGfZ9Vd9Z3tYWuVKrx147NmeVtP5Y9Pilq/JdD6XLGn7fRPsGoF+iFjUqvRCcjIlB9ejdB
        +v1dsOryLpFMxtxOB56cLvGzoTRNT/YxJZWXBTyisNM8GWOzWL4OertZoCCePR9JSRGD4y
        xJCfF2iqczEW5kiKUlnR4IC2az3oA34=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-QpHAzj-iPBujrtcfNdvXMQ-1; Fri, 20 Jan 2023 12:56:13 -0500
X-MC-Unique: QpHAzj-iPBujrtcfNdvXMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13593380450D;
        Fri, 20 Jan 2023 17:56:13 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A47B640C6EC4;
        Fri, 20 Jan 2023 17:56:11 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 5/8] block: Add BIO_PAGE_PINNED
Date:   Fri, 20 Jan 2023 17:55:53 +0000
Message-Id: <20230120175556.3556978-6-dhowells@redhat.com>
In-Reply-To: <20230120175556.3556978-1-dhowells@redhat.com>
References: <20230120175556.3556978-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BIO_PAGE_PINNED to indicate that the pages in a bio were pinned (FOLL_PIN)
and that the pin will need removing.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Jan Kara <jack@suse.cz>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: linux-block@vger.kernel.org
---
 include/linux/blk_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 86711fb0534a..42b40156c517 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -319,6 +319,7 @@ struct bio {
  */
 enum {
 	BIO_PAGE_REFFED,	/* Pages need refs putting (equivalent to FOLL_GET) */
+	BIO_PAGE_PINNED,	/* Pages need unpinning (equivalent to FOLL_PIN) */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_QUIET,		/* Make BIO Quiet */

