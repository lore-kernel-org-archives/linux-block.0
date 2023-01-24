Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE65C61D97
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 21:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjAXVT5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 16:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjAXVTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 16:19:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C35651C52
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 13:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674595085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cp0bQAXkNYOtockNiUGfxh3g6gE8MLITE+yOOD5XVmY=;
        b=aVXVN4pO+IhVweRTDkbEH/wwe6HUFahTmne1NQ8qoCdkhCPKWxwYFSiKiQGwoiPX0X4x/p
        ii584mn6+dV27fLihhi5ZJ/36xh6fISZaUzlDgQLXJEz8Ecbpko/zSO0S9S+tzA/O7Lap3
        k/5JvHfzP3yT7owDR3SOZ4zMjOOJy04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-nDIqO7AtO72E8yH6xux5Lw-1; Tue, 24 Jan 2023 16:18:01 -0500
X-MC-Unique: nDIqO7AtO72E8yH6xux5Lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 510B485C06B;
        Tue, 24 Jan 2023 21:18:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70FD9140EBF5;
        Tue, 24 Jan 2023 21:17:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <b7833fd7-eb7d-2365-083d-5a01b9fee464@nvidia.com>
References: <b7833fd7-eb7d-2365-083d-5a01b9fee464@nvidia.com> <20230124170108.1070389-1-dhowells@redhat.com> <20230124170108.1070389-6-dhowells@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH v9 5/8] block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted logic
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1353770.1674595077.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 24 Jan 2023 21:17:57 +0000
Message-ID: <1353771.1674595077@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

John Hubbard <jhubbard@nvidia.com> wrote:

> > +	/* for now require references for all pages */
> =

> Maybe just delete this comment?

Christoph added that.  Presumably because this really should move to pinni=
ng
or be replaced with iomap, but it's not straightforward either way.  Chris=
toph?

David

