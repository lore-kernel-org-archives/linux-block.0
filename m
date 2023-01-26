Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD979C54EAA
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 23:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjAZX7S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 18:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjAZX7K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 18:59:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23B2DE58
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 15:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674777421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKThdaP2GlTwXMt/TnWZotCXGuKPxiAvQX1pLLF779E=;
        b=Yg2UtBdF6rBahUMzvZxMIqfhyl2/pnurtm8zJLNc9//mEXjIhYAIHiEEHBnzYYRuxmOVya
        PNnVcHiw969na4/q5ai+gjgmoHclQOZCMdE0qSqb3ssyfObJDua0d8ZD6lBFYxwU0dmbel
        FfdvK7B//t+AtJ9PrUOLhxNbJTaTIPg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-L1RQGqy5MLmeSuxJlfKllQ-1; Thu, 26 Jan 2023 18:56:55 -0500
X-MC-Unique: L1RQGqy5MLmeSuxJlfKllQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C43E3C025CC;
        Thu, 26 Jan 2023 23:56:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C732492C14;
        Thu, 26 Jan 2023 23:56:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
References: <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com> <20230126141626.2809643-1-dhowells@redhat.com> <20230126141626.2809643-3-dhowells@redhat.com> <Y9L3yA+B1rrnrGK8@ZenIV> <Y9MAbYt6DIRFm954@ZenIV>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2907149.1674777410.1@warthog.procyon.org.uk>
Date:   Thu, 26 Jan 2023 23:56:50 +0000
Message-ID: <2907150.1674777410@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Al says that pinning a page (ie. FOLL_PIN) could cause a deadlock if a page is
vmspliced into a pipe with the pipe holding a pin on it because pinned pages
are removed from all page tables.  Is this actually the case?  I can't see
offhand where in mm/gup.c it does this.

David

