Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2C5C25B4E
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 19:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjATTTo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjATTTn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 14:19:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E909D287
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 11:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674242334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+iEmqgi2xG1bd5OetUWtWkkvH6CIkfAlH9mAdhcmUY=;
        b=cphIy2GZ/hkA8IbAViWcG0maFb80WlgZo8GkggmqoODN/hP74utDYmf66GBKouqC73/opT
        dijcCjiY7XCNrEGFRfr7Tez256bkAWmQUdpy2BUNuMZANGO4YeKa/9fMZM6zxMU+Wchu2w
        oXiu3ZZNVHtbsd06593+ziggg3EkTTE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574--LfyQgVcOqum_snKdJpVRw-1; Fri, 20 Jan 2023 14:18:47 -0500
X-MC-Unique: -LfyQgVcOqum_snKdJpVRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A509101A521;
        Fri, 20 Jan 2023 19:18:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB7A22166B2A;
        Fri, 20 Jan 2023 19:18:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8rkjYn7HY/IwHrL@casper.infradead.org>
References: <Y8rkjYn7HY/IwHrL@casper.infradead.org> <20230120175556.3556978-1-dhowells@redhat.com> <20230120175556.3556978-9-dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 8/8] mm: Renumber FOLL_GET and FOLL_PIN down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3560195.1674242325.1@warthog.procyon.org.uk>
Date:   Fri, 20 Jan 2023 19:18:45 +0000
Message-ID: <3560196.1674242325@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> Although I was hoping you'd renumber some of the others since we
> currently have gaps at 0x200, 0x400, 0x1000, and 0x4000 as well
> as the 0x40 you're using here.

Since the other patches don't require this one, I can renumber them all and
send it directly to Andrew.

David

