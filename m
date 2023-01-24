Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE610C54E94
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 14:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjAXOqj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjAXOqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 09:46:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9188A7D
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 06:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674571555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fYiLuIxDhxiPph2V06Yyb1fMH7liPtcXmyWu5UVVaS4=;
        b=Hb126B+R1MNEPWkAKs22kvVOCWQtX4oCjmej9xvKPZbVUoCW4s2wqpcriJ1l6zWgw2gdqC
        a3XfLaCTvazz1+AKHryMCPszlTNGp0J3x6Vb7r86XmK1dHo6guV2ST2DElgFJKmgr5ZATK
        WtTfgdDrb6oyFf66SLmMeqdO6ZlSkM8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-LK_sA-vOO2-ScuK82JjlNQ-1; Tue, 24 Jan 2023 09:45:52 -0500
X-MC-Unique: LK_sA-vOO2-ScuK82JjlNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 512D21C07587;
        Tue, 24 Jan 2023 14:45:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1C7C53A0;
        Tue, 24 Jan 2023 14:45:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5bc85aff-e21e-ab83-d47a-e7b7c1081ab0@redhat.com>
References: <5bc85aff-e21e-ab83-d47a-e7b7c1081ab0@redhat.com> <1b1eb3d8-c6b4-b264-1baa-1b3eb088173d@redhat.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-3-dhowells@redhat.com> <874093.1674570959@warthog.procyon.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v8 02/10] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <874736.1674571549.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 14:45:49 +0000
Message-ID: <874737.1674571549@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> At least reduces the occurrences of FOLL_PIN :)

I don't see where the problem is in letting people supply FOLL_PIN or
FOLL_GET.  Why even have pin_user_pages() and get_user_pages() since they end
up at the same place.  They should be inline wrappers, if separate functions
at all.

David

