Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97402C433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 03:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiFBDUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 23:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiFBDUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 23:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E484243BA8
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 20:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654139998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VAgArk0BcNk+9GP0AOx8PMvAT8X1PDlB7xL7ZWCfJ7g=;
        b=EBhcesJzxxzBSlVWlg4E5A/9dlk7O7OJ2+EX8wEqX6lBzXaxJDgBtok9a43gNyK+u4Iufr
        KSPwC9y2Tz6juvf5ARarIDJgUyXCkNKppeCnx7NX+RvtgjXF1L1i/dsjr1sNjw2HQoWoEn
        UYKcDNSNzwws4+Fy47rBcEP692McvMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-Uw4D5aDwNOa_EmLS7mxQdw-1; Wed, 01 Jun 2022 23:19:54 -0400
X-MC-Unique: Uw4D5aDwNOa_EmLS7mxQdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0CA38032E5;
        Thu,  2 Jun 2022 03:19:53 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F8C140CF8EB;
        Thu,  2 Jun 2022 03:19:47 +0000 (UTC)
Date:   Thu, 2 Jun 2022 11:19:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] ubd: add io_uring based userspace block driver
Message-ID: <YpgsTojc4mVKghZA@T590>
References: <20220509092312.254354-1-ming.lei@redhat.com>
 <20220530070700.GF1363@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530070700.GF1363@bug>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Pavel,

On Mon, May 30, 2022 at 09:07:00AM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the driver part of userspace block driver(ubd driver), the other
> > part is userspace daemon part(ubdsrv)[1].
> 
> > @@ -0,0 +1,1193 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Userspace block device - block device which IO is handled from userspace
> > + *
> > + * Take full use of io_uring passthrough command for communicating with
> > + * ubd userspace daemon(ubdsrvd) for handling basic IO request.
> 
> > +
> > +static inline unsigned int ubd_req_build_flags(struct request *req)
> > +{
> ...
> > +	if (req->cmd_flags & REQ_SWAP)
> > +		flags |= UBD_IO_F_SWAP;
> > +
> > +	return flags;
> > +}
> 
> Does it work? How do you guarantee operation will be deadlock-free with swapping and
> writebacks going on?

The above is just for providing command flags to user side, so that the
user side can understand/handle the request better.

prtrl(PR_SET_IO_FLUSHER) has been merged for avoiding the deadlock.

> 
> What are restriction on ubdsrv? What happens when it needs to allocate memory, or is
> swapped out?

Yeah, ubd_copy_pages() needs to pin pages for copying data between
user VM and block request pages, and get_user_pages may run out of pages.
But I think forward progress can still be provided by reserving one VM buffer
with single page locked.

> Have mm people seen this?

I remembered that the early RFC with related discussion is CCed to mm
list, and all follow-up are CC to linux-kernel.

Not one big deal, will Cc mm list in the future post.


thanks,
Ming

