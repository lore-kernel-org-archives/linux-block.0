Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B931C38142
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 14:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjAXOCg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjAXOCg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 09:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E84474F6
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 06:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674568867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eo2GrUnkx8jKUa516q4eKoqkbm41JbPUJ1rKGdvQbMk=;
        b=LFGd2BlDaPFvVGFCkctlRjZnzdXL5x5sygtYrR0Xc/gcqqNrymPW2JDSZ+HmeBIKNrrajv
        CoGdWiD+2r+08hDc65UgGcoBaVuY32VJoJT5dKYuTVzNoZ8S0iJmhp4UkC2UKMZy+t95SK
        KkXeB6JHs/aH5VGk5uDmuPQ3hOZ1u0I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-a7Q6G-m3MkiaJjWzkfrdVQ-1; Tue, 24 Jan 2023 08:44:58 -0500
X-MC-Unique: a7Q6G-m3MkiaJjWzkfrdVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E2A83C025C7;
        Tue, 24 Jan 2023 13:44:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 244C640444C3;
        Tue, 24 Jan 2023 13:44:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <02063032-61e7-e1e5-cd51-a50337405159@redhat.com>
References: <02063032-61e7-e1e5-cd51-a50337405159@redhat.com> <20230123173007.325544-1-dhowells@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] iov_iter: Improve page extraction (pin or just list)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <852028.1674567895.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 24 Jan 2023 13:44:55 +0000
Message-ID: <852029.1674567895@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If you look here:

	https://lore.kernel.org/r/167391047703.2311931.8115712773222260073.stgit@=
warthog.procyon.org.uk/

you can see additional patches fixing other users.  Christoph asked if I c=
ould
pare down the patchset to the minimum to fix the bio case for the moment.

It will be easier to do the others once iov_iter_extract_pages() is upstre=
am
as the individual bits can go via their respective maintainers.

However, I do want to see about adding cifs iteratorisation in this merge
window also, which also depends on the iov_iter_extract_pages() function b=
eing
added.

David

