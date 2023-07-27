Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE544C001E0
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 16:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjG0QLQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjG0QLP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 12:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B05210B
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690474225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ao2hx2MpjsdXiW9qmpQigRZTXCD0Vl8r3CcjzgIUN9M=;
        b=CQSxev7VUJm2sTHDnip+Icumy7zcERbkhjIBYDMgMO8O8DIANSc18Oz7Di+ip2ouh2o8GT
        dCfVKO7sIkhPn+374UDpL8ixHSpQbdLNG28uHIJz3EiathDldvWOEpMuZQqYxjcCZ9HVCs
        ogaho5P4C5i0h3cqA7Fllj7IVHF+35g=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-B6PfHW9NMze2sIAZSWlWkg-1; Thu, 27 Jul 2023 12:10:22 -0400
X-MC-Unique: B6PfHW9NMze2sIAZSWlWkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 493C91C068CE;
        Thu, 27 Jul 2023 16:10:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2749200BA7C;
        Thu, 27 Jul 2023 16:10:19 +0000 (UTC)
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
Subject: [PATCH 0/2] shmem, splice: Fixes for shmem_splice_read()
Date:   Thu, 27 Jul 2023 17:10:14 +0100
Message-ID: <20230727161016.169066-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hugh,

Here are a couple of fix patches for shmem_splice_read():

 (1) Fix the splicing of a zero_page in place of a missing page.  This should
     only splice in the calculated part of the page and everything to the end
     of the page.

 (2) Apply a couple of fixes already applied to filemap_splice_read(),
     including using in->f_mapping_host rather than file_inode(in) and
     ignoring splices that start at or after s_maxbytes.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=splice-fixes

David

David Howells (2):
  shmem: Fix splice of a missing page
  shmem: Apply a couple of filemap_splice_read() fixes to
    shmem_splice_read()

 mm/shmem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

