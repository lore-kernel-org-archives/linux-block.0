Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88490C6379F
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 22:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjBMWoH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 17:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBMWoG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 17:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0D01E1F6
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676328201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MvJyZLq27FWxSw/lw8AFrwhZrqpXu3dfjNVlytfVw4=;
        b=bzDlkt0xr6Y1zO6bSP1oGY+akp9nAqPzy1Q1SZK++Bk722IucFpPJCQ4pydgZ0zAxwf87O
        tNbcK+F5FvMC0pFzonxg3+FoDIsrAQg3Y+ImMlc5ZUUZ2lXPJWBct/auIDcQ8RonD737Zk
        TtKRWbuXcwTF8pZnoU10JcESoe3wooQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-NYCZe6bNMO-V6g3bY9PIng-1; Mon, 13 Feb 2023 17:43:16 -0500
X-MC-Unique: NYCZe6bNMO-V6g3bY9PIng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 964B02932487;
        Mon, 13 Feb 2023 22:43:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7053B401014C;
        Mon, 13 Feb 2023 22:43:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230213180632.GA368628@roeck-us.net>
References: <20230213180632.GA368628@roeck-us.net> <20230209102954.528942-1-dhowells@redhat.com> <20230209102954.528942-4-dhowells@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
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
Content-ID: <2416072.1676328192.1@warthog.procyon.org.uk>
Date:   Mon, 13 Feb 2023 22:43:12 +0000
Message-ID: <2416073.1676328192@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> wrote:

> [    4.660118] PC is at 0x0
> [    4.660248] LR is at filemap_read_folio+0x17/0x4e

Do you know what the filesystem is that's being read from?

I think the problem is that there are a few filesystems/drivers that call
generic_file_splice_read() but don't have a ->read_folio().  Now most of these
can be made to call direct_splice_read() instead, leaving just coda, overlayfs
and shmem.

Coda and overlayfs can be made to pass the request down a layer.  I'm about to
look into shmem.

David

