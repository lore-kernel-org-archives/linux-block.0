Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC55FC7EE29
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 13:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjEVNzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 09:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjEVNzJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 09:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE5D1A7
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfMcLqK7SdZvPGZvy5b2RGzipVUrB/qFQK+4kiqdRos=;
        b=M3vixxSSgb0iQ/6frdFHzwwdhj6liruvkjJwfhRFB3tR9RgHxLx1bqw9Y/pv/YDlrIXpyq
        wiCm1MOmqvqtaWvRRy3JBzJ+Sj1Vrx9TVTb4atcm04IMZcVMlormiWrgChJ0AxqzG3JKSg
        oVk6g8r+R+xjOkQ6VX85PKD42umamVs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-P98tTMU2PTmMkmG9xXy80A-1; Mon, 22 May 2023 09:52:08 -0400
X-MC-Unique: P98tTMU2PTmMkmG9xXy80A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8E383C0BE2D;
        Mon, 22 May 2023 13:52:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13CC640C6CD6;
        Mon, 22 May 2023 13:52:03 +0000 (UTC)
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
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v22 26/31] trace: Convert trace/seq to use copy_splice_read()
Date:   Mon, 22 May 2023 14:50:13 +0100
Message-Id: <20230522135018.2742245-27-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the splice from the trace seq buffer, just use copy_splice_read().

In the future, something better can probably be done by gifting pages from
seq->buf into the pipe, but that would require changing seq->buf into a
vmap over an array of pages.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Masami Hiramatsu <mhiramat@kernel.org>
cc: linux-kernel@vger.kernel.org
cc: linux-trace-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebc59781456a..c210d02fac97 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5171,7 +5171,7 @@ static const struct file_operations tracing_fops = {
 	.open		= tracing_open,
 	.read		= seq_read,
 	.read_iter	= seq_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= copy_splice_read,
 	.write		= tracing_write_stub,
 	.llseek		= tracing_lseek,
 	.release	= tracing_release,

