Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E266CC3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 11:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjAQLM3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 06:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbjAQLMI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 06:12:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248D22A98A
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 03:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673953882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nuM9+xr5fOVlA89rJyyrxh9F5lYvIvToBzJga0NsV4M=;
        b=fm9opR5zhaYdLYdt4cBFez47p4bdxh05YyfjhJTvHsp2+//ztRrqxjcW5D+xzhxkqlc13/
        4JZkmWtFUwGMCveklrflOUe/LejWQ4Uf6rqPH6B79k/LELAcEkY2jK5VS35ZQlnfc/7z2Y
        XZYiRxayYIyLmladaskuWEEVcee08iI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-2CnmrGpNOjuBRZ-OVGrQfQ-1; Tue, 17 Jan 2023 06:11:19 -0500
X-MC-Unique: 2CnmrGpNOjuBRZ-OVGrQfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB446857A88;
        Tue, 17 Jan 2023 11:11:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60AABC15BA0;
        Tue, 17 Jan 2023 11:11:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8ZTyx7vM8NpnUAj@infradead.org>
References: <Y8ZTyx7vM8NpnUAj@infradead.org> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in call_write_iter()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2337530.1673953876.1@warthog.procyon.org.uk>
Date:   Tue, 17 Jan 2023 11:11:16 +0000
Message-ID: <2337531.1673953876@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> I suspect the best is to:
> 
>  - rename init_sync_kiocb to init_kiocb
>  - pass a new argument for the direction to it.  I'm not entirely
>    sure if flags is a good thing, or an explicit READ/WRITE might be
>    better because it's harder to get wrong, even if a the compiler
>    might generate worth code for it.

So something like:

	init_kiocb(kiocb, file, WRITE);
	init_kiocb(kiocb, file, READ);

David

