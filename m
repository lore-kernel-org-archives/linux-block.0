Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC266C7EE2D
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 11:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbjEZLaG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 07:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243137AbjEZLaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 07:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A813A
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 04:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685100557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h4Wb8uN/beFIyeWc47iGMcgU19K20EwZTfMIE97bOJg=;
        b=QrlP2VbR8XIEkdejHfg+s1S4dAAlnu35Zh6gRd9d5phtF+pXWCi9n3L5LIK2sPPzqSlaK/
        4ynd1o+3T1WWxdcKrGgQFbPugeqawKEAvBkZAcxe9/Iy3HjtpMKha7xxq7JoNiwZ76AFOe
        7ZnxX14iadqUwLgtKFza7gV+0JJXk/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-46zss16mM2KLYOTz-LhglQ-1; Fri, 26 May 2023 07:29:12 -0400
X-MC-Unique: 46zss16mM2KLYOTz-LhglQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FCD985A5AA;
        Fri, 26 May 2023 11:29:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6611A492B0A;
        Fri, 26 May 2023 11:29:08 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 0/3] block: Make old dio use iov_iter_extract_pages() and page pinning
Date:   Fri, 26 May 2023 12:28:56 +0100
Message-Id: <20230526112859.654506-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph, David, Lorenzo,

Here are three patches that go on top of the similar patches for bio
structs now in the block tree that make the old block direct-IO code use
iov_iter_extract_pages() and page pinning.

There are three patches:

 (1) Make page pinning neither add nor remove a pin to/from a ZERO_PAGE,
     thereby allowing the dio code to insert zero pages in the middle of
     dealing with pinned pages.  This also mitigates a potential problem
     whereby userspace could force the overrun the pin counter of a zero
     page.

     A pair of functions are provided to wrap the testing of a page or
     folio to see if it is a zero page.

 (2) Provide a function to allow an additional pin to be taken on a page we
     already have pinned (and do nothing for a zero page).

 (3) Switch direct-io.c over to using page pinning and to use
     iov_iter_extract_pages() so that pages from non-user-backed iterators
     aren't pinned.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-old-dio

David

Changes
=======
ver #3)
 - Move is_zero_page() and is_zero_folio() to mm.h for dependency reasons.
 - Add more comments and adjust the docs about pinning zero pages.
 - Rename page_get_additional_pin() to folio_add_pin().
 - Use is_zero_folio() in folio_add_pin().
 - Rename need_unpin to is_pinned in struct dio.

ver #2)
 - Fix use of ZERO_PAGE().
 - Add wrappers for testing if a page is a zero page.
 - Return the zero page obtained, not ZERO_PAGE(0) unconditionally.
 - Need to set BIO_PAGE_PINNED conditionally, and not BIO_PAGE_REFFED.

Link: https://lore.kernel.org/r/ZGxfrOLZ4aN9/MvE@infradead.org/ [1]
Link: https://lore.kernel.org/r/20230525155102.87353-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20230525223953.225496-1-dhowells@redhat.com/ # v2

David Howells (3):
  mm: Don't pin ZERO_PAGE in pin_user_pages()
  mm: Provide a function to get an additional pin on a page
  block: Use iov_iter_extract_pages() and page pinning in direct-io.c

 Documentation/core-api/pin_user_pages.rst |  6 ++
 fs/direct-io.c                            | 72 ++++++++++++++---------
 include/linux/mm.h                        | 27 ++++++++-
 mm/gup.c                                  | 58 +++++++++++++++++-
 4 files changed, 131 insertions(+), 32 deletions(-)

