Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B612C636CD
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 21:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjA3Vxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 16:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjA3Vxn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 16:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB52113
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 13:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675115570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWqwrq0XlGsW8ySWeVmnvrSlFmLC23Ffi26+Gl59DIw=;
        b=CY0WIpC27VjSIMtw6bVM37HHvDfTcOL6WyWOZhPsFeq2byFGOTX0OnTG3gSXEB1DR5iII0
        rwvIOzBPx1r22EfRxqezCmBEieumOgy2GEhaMZDeBPpZg+k9ROUp7BVCzW+96xpjybozy7
        M7YPfsKRGjSqBhk4MxE4avz1ajdaLdE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-cfv8DK96NrqRPAR1dYLiXQ-1; Mon, 30 Jan 2023 16:52:46 -0500
X-MC-Unique: cfv8DK96NrqRPAR1dYLiXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85CFB800DA6;
        Mon, 30 Jan 2023 21:52:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD77E140EBF5;
        Mon, 30 Jan 2023 21:52:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
References: <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk> <3351099.1675077249@warthog.procyon.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3519100.1675115561.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 30 Jan 2023 21:52:41 +0000
Message-ID: <3519101.1675115561@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> > Hi Jens,
> > =

> > Could you consider pulling this patchset into the block tree?  I think=
 that
> > Al's fears wrt to pinned pages being removed from page tables causing =
deadlock
> > have been answered.  Granted, there is still the issue of how to handl=
e
> > vmsplice and a bunch of other places to fix, not least skbuff handling=
.
> > =

> > I also have patches to fix cifs in a separate branch that I would also=
 like to
> > push in this merge window - and that requires the first two patches fr=
om this
> > series also, so would it be possible for you to merge at least those t=
wo
> > rather than manually applying them?
> =

> I've pulled this into a separate branch, but based on the block branch,
> for-6.3/iov-extract. It's added to for-next as well.

Many thanks!

David

