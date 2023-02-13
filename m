Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB5BC64EC7
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 23:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjBMXNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjBMXNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 18:13:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB49A1EFE8
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676329977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LYmJn2Xer4KEDlDXHqGYG+hy1nC8sep09jW5bSjh8tI=;
        b=HDBihKVTja4a91wiZEHahY1okLv7+dm+WEqfW+QkQgq/3V1nZv4kmfz2XdH6VyR2AvxaWL
        KmYH0rZdkmm30qFjithRfivr76twHDlHBr32Y7VuNRgJ+KLor13q6oTrx1FMuJj7eR/l7a
        wvOBo1OnbNs17yguCgh8j74jpOdtig0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-xMiptjDDNwet5_-0FdnxTw-1; Mon, 13 Feb 2023 18:12:54 -0500
X-MC-Unique: xMiptjDDNwet5_-0FdnxTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C51429A9D4E;
        Mon, 13 Feb 2023 23:12:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 477A940CF8ED;
        Mon, 13 Feb 2023 23:12:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <55e2bef1-e8b5-3475-21df-487bddb47f5b@roeck-us.net>
References: <55e2bef1-e8b5-3475-21df-487bddb47f5b@roeck-us.net> <20230213180632.GA368628@roeck-us.net> <20230209102954.528942-1-dhowells@redhat.com> <20230209102954.528942-4-dhowells@redhat.com> <2416073.1676328192@warthog.procyon.org.uk>
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
Content-ID: <2451112.1676329970.1@warthog.procyon.org.uk>
Date:   Mon, 13 Feb 2023 23:12:50 +0000
Message-ID: <2451113.1676329970@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> wrote:

> Both are initrd.

Do you mean rootfs?  And, if so, is that tmpfs-based or ramfs-based?

David

