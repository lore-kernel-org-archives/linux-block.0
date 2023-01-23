Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D58C05027
	for <linux-block@archiver.kernel.org>; Mon, 23 Jan 2023 16:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjAWQlc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjAWQlQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 11:41:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A1D2D149
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674491936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6M4p2Xue1wGBtqsFC7+lffkyWuM29QlWRyXf+rirlA=;
        b=HGX9pV33t8r7PMupKouDomTUalLKGvhlZMDl1dtm4pPi4wB9rmYIBOXD7qg58hJkgB3a5C
        Mh/QUPnJaT27KU1KwtZsXfN0gT8HS1kXq5eAkAqXkK6gffI0wcBciqjHBay9pbxP214ioI
        4rj22OxumvQMllyxd9X/XGoDXjLGEXA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-k-RZv03IPUWLE_Rw0xersg-1; Mon, 23 Jan 2023 11:38:50 -0500
X-MC-Unique: k-RZv03IPUWLE_Rw0xersg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABC9B3806713;
        Mon, 23 Jan 2023 16:38:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65D9C140EBF4;
        Mon, 23 Jan 2023 16:38:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y862ZL5umO30Vu/D@casper.infradead.org>
References: <Y862ZL5umO30Vu/D@casper.infradead.org> <20230120175556.3556978-1-dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or just list)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <318137.1674491927.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 23 Jan 2023 16:38:47 +0000
Message-ID: <318138.1674491927@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> Why do we want to track that information on a per-page basis?  Wouldn't =
it
> be easier to have a VM_NOCOW flag in vma->vm_flags?  Set it the first
> time somebody does an O_DIRECT read or RDMA pin.  That's it.  Pages in
> that VMA will now never be COWed, regardless of their refcount/mapcount.
> And the whole "did we pin or get this page" problem goes away.  Along
> with folio->pincount.

Wouldn't that potentially make someone's entire malloc() heap entirely NOC=
OW
if they did a single DIO to/from it.

Also you only mention DIO read - but what about "start DIO write; fork(); =
touch
buffer" in the parent - now the write buffer belongs to the child and they=
 can
affect the parent's write.

David

