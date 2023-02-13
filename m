Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6A5C64ED6
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 11:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjBMLRD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 06:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjBMLRC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 06:17:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EDF1817C
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 03:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676286946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9EmbCIQfylwGelzNLd9AZZbwXGcom6ymeHxaQr8/bA=;
        b=SvJhygRC7j2T7hbO9aXX2M4sa7C+7X0NYmYyEltzB0y2JXbHpkx6Evm0qDGhC5IB75nBtA
        k/GU28dM6XsThLWNgw45oE1S/aRJGJF7RFJYhl+1rJGOcmiL2WRKd4cTe+DWocW4K916co
        pyryY3BT4FTf3TftZdtONOmAVXl7riE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175--PrZZsNwMnSPcZWbh6Nu3Q-1; Mon, 13 Feb 2023 06:15:41 -0500
X-MC-Unique: -PrZZsNwMnSPcZWbh6Nu3Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB65185CCE0;
        Mon, 13 Feb 2023 11:15:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94145492B03;
        Mon, 13 Feb 2023 11:15:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+oOa3bbJZallKtl@infradead.org>
References: <Y+oOa3bbJZallKtl@infradead.org> <Y+n0n2UE8BQa/OwW@infradead.org> <20230209102954.528942-1-dhowells@redhat.com> <20230209102954.528942-4-dhowells@redhat.com> <1753989.1676283061@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v13 03/12] splice: Do splice read from a buffered file without using ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1830952.1676286937.1@warthog.procyon.org.uk>
Date:   Mon, 13 Feb 2023 11:15:37 +0000
Message-ID: <1830953.1676286937@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > > Also why doesn't this use init_sync_kiocb?
> > 
> > I'm not sure I want ki_flags.
> 
> Why?

I'm not sure I want ki_flags setting from f_iocb_flags I should've said.  I'm
not sure how the IOCB_* flags that I import from there will affect the
operation of the synchronous read splice.  IOCB_NOWAIT, for example, or, for
that matter, IOCB_APPEND.

David

