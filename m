Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCFFC636D3
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 18:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjBHSPx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 13:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBHSPw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 13:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C2B23119
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675880107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PTjtXDgu2q/FuBRhvL58Zww1kvuwz26nkJJzavvqz6o=;
        b=Zw3PCxNenyNPAeBiUqHerIYUjObmCqglLILwL5MFOqeh5jPFxrOYPLH5O0HiOX/Eq0BucP
        HPg600LT0RF8epOV9jKB+2+0JrNbfD7m7It+KeR8JqVRT1r6rwlb1ZBWWJBhApJ4Xj8xrL
        cZt2543kO87kQ0RH9oqmIV2/15sRMHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-fst53555NBqSVP3pMESD2g-1; Wed, 08 Feb 2023 13:15:06 -0500
X-MC-Unique: fst53555NBqSVP3pMESD2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FB95857A89;
        Wed,  8 Feb 2023 18:15:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2155735454;
        Wed,  8 Feb 2023 18:15:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+PaF7q10xSoqynj@casper.infradead.org>
References: <Y+PaF7q10xSoqynj@casper.infradead.org> <Y+MydH2HZ7ihITli@infradead.org> <20230207171305.3716974-1-dhowells@redhat.com> <20230207171305.3716974-2-dhowells@redhat.com> <176199.1675872591@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v12 01/10] vfs, iomap: Fix generic_file_splice_read() to avoid reversion of ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <180258.1675880102.1@warthog.procyon.org.uk>
Date:   Wed, 08 Feb 2023 18:15:02 +0000
Message-ID: <180259.1675880102@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> What's the point in iov_iter_count() anyway?  It's more characters
> than iter->count, so why not use it directly?

I presume it got added for a reason and should be used in preference to direct
access.

David

