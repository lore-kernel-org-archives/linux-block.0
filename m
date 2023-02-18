Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8633EC64EC4
	for <linux-block@archiver.kernel.org>; Sat, 18 Feb 2023 09:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBRJTZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Feb 2023 04:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBRJTX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Feb 2023 04:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D45E2A157
        for <linux-block@vger.kernel.org>; Sat, 18 Feb 2023 01:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676711902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R3BrmhBgQgWTKEiCYwN2vM7iyjzhHhTKrOpbAg9oclw=;
        b=dfSxNkFOrr78CsHbeVAs1ywoAnzFXwMuX7oNXCHFtreATrY7q81+HlNWj9NJBf3Q5tnj0j
        ze3hfUHl/eW0IEv72/FDyXUXieuWjTkZdDX1tSpyosUnHvO81VvblYrpnaPo8DumRd1y/o
        cobLnJomx/xDdyUeUPIRXYYWi3M1CX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-J1y4fjxvOBaocJW_UBOeNQ-1; Sat, 18 Feb 2023 04:18:17 -0500
X-MC-Unique: J1y4fjxvOBaocJW_UBOeNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84A2980352D;
        Sat, 18 Feb 2023 09:18:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F7A6492B00;
        Sat, 18 Feb 2023 09:18:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87a61b9y20.fsf@oc8242746057.ibm.com>
References: <87a61b9y20.fsf@oc8242746057.ibm.com> <87a61ckowk.fsf@oc8242746057.ibm.com> <732891.1676670463@warthog.procyon.org.uk>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     dhowells@redhat.com, axboe@kernel.dk, david@redhat.com,
        hch@infradead.org, hch@lst.de, hdanton@sina.com, jack@suse.cz,
        jgg@nvidia.com, jhubbard@nvidia.com, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        logang@deltatee.com, viro@zeniv.linux.org.uk, willy@infradead.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH v14 08/17] splice: Do splice read from a file without using ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1085543.1676711893.1@warthog.procyon.org.uk>
Date:   Sat, 18 Feb 2023 09:18:13 +0000
Message-ID: <1085544.1676711893@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Alexander Egorenkov <egorenar@linux.ibm.com> wrote:

> > +			n = min_t(loff_t, len, isize - *ppos);
> > +			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
> >  			if (!n)
> >  				goto out;
> >  			len -= n;
> 
> Yes, this change fixed the problem.

Thanks!

David

