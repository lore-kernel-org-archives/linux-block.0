Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB7C7EE23
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 06:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjEVG31 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 02:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEVG30 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 02:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CA6A1
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684736926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L51D923F/Qnr60svKwlOplic/YuXek4iXgzeRvfwk/0=;
        b=jUgBzgRwxkEHLEFkFI8T56Io54rId9HVEsft1yembiZf5PTE7m4KFDkXilv1ynZWEE82BW
        K18bKuvMztqkn9R+oTjr1ZezI4nR9UVN3l3c3rP2jR+/a2aoQq8TFfwWQTv4uTDoVsjgDq
        IZdvKxnFDBv68t9d1+JmOma3baZOObY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-_JqmLVPHOXevZRe0HvSLeg-1; Mon, 22 May 2023 02:28:41 -0400
X-MC-Unique: _JqmLVPHOXevZRe0HvSLeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F1933C025A2;
        Mon, 22 May 2023 06:28:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC7E8C54184;
        Mon, 22 May 2023 06:28:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <376ab23b-52d0-d7fd-2dd9-414cbb474e01@linux.alibaba.com>
References: <376ab23b-52d0-d7fd-2dd9-414cbb474e01@linux.alibaba.com> <20230520000049.2226926-1-dhowells@redhat.com> <20230520000049.2226926-23-dhowells@redhat.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
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
        Christoph Hellwig <hch@lst.de>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v21 22/30] ocfs2: Provide a splice-read stub
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2362050.1684736916.1@warthog.procyon.org.uk>
Date:   Mon, 22 May 2023 07:28:36 +0100
Message-ID: <2362051.1684736916@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Joseph Qi <joseph.qi@linux.alibaba.com> wrote:

> Don't see direct IO logic now. Am I missing something?

See that patch description ;-)

    Provide a splice_read stub for ocfs2.  This emits trace lines and does an
    atime lock/update before calling filemap_splice_read().  Splicing from
    direct I/O is handled by the caller.

David

