Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6BCC54E94
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 09:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjAZJuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 04:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjAZJuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 04:50:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EA710414
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 01:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674726574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EG/449qSmt5dxUptSk+N35YPkCWa7qDSTbYqeA0hffw=;
        b=Jjb8nhu+ZxzmiVZ7s02PjW6DTd2x4L4trl/T8gulN7oicSxLcKHL490Dsg4q2M5iMNLzAS
        UtNeH29NZmmCIwbCt8WGbyR47eXQ6FaGQ2hof8MdEFOt/JSnyCiptgFmMaXMn8suZcgobm
        xCuWQ2U98MOXk+sK2cytIaVVLt/AByE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-_19ox34JNBWf8p6rKRDejQ-1; Thu, 26 Jan 2023 04:49:30 -0500
X-MC-Unique: _19ox34JNBWf8p6rKRDejQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87602830F51;
        Thu, 26 Jan 2023 09:49:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6ED69492B01;
        Thu, 26 Jan 2023 09:49:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <af0e448a-9559-32c0-cc59-10b159459495@redhat.com>
References: <af0e448a-9559-32c0-cc59-10b159459495@redhat.com> <20230125210657.2335748-1-dhowells@redhat.com> <20230125210657.2335748-2-dhowells@redhat.com>
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
Subject: Re: [PATCH v10 1/8] iov_iter: Define flags to qualify page extraction.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2613248.1674726566.1@warthog.procyon.org.uk>
Date:   Thu, 26 Jan 2023 09:49:26 +0000
Message-ID: <2613249.1674726566@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> Just a note that the usage of new __bitwise types instead of "unsigned" is
> encouraged for flags.
> 
> See rmap_t in include/linux/rmap.h as an example.

Hmmm...  rmap_t really ought to be unsigned int.

David

