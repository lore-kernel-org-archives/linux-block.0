Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F518C61DA4
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 22:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBNW57 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjBNW56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 17:57:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2542B609
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 14:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676415416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1eB3+uWhBW292dy0PfFX0Qmu/QtjvuUp1sDv9ahW6A=;
        b=aCEfZrlmiIuIGpigegrO40CrivaD0iYRWr9ea/yGQRKZkOVGEX+N29ODK4oQrM9hLSpjFF
        vtXWHgKiM2IBP1hFzzEvzuWY9JHdh51lxqn3QwlWem7j33vT85B1cJiLXXV/aJKPY+1c2W
        eppELO8mnIxxLlFRoUhB+XCZXlsIFpI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-vSwp5IO2PbGa6pnbSTtAuQ-1; Tue, 14 Feb 2023 17:56:55 -0500
X-MC-Unique: vSwp5IO2PbGa6pnbSTtAuQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB9D11C041AC;
        Tue, 14 Feb 2023 22:56:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C08FA2026D4B;
        Tue, 14 Feb 2023 22:56:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230214171330.2722188-1-dhowells@redhat.com>
References: <20230214171330.2722188-1-dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, smfrench@gmail.com
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v14 00/17] iov_iter: Improve page extraction (pin or just list)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2877091.1676415412.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 14 Feb 2023 22:56:52 +0000
Message-ID: <2877092.1676415412@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

If you decide not to take my patches in this merge window, would you have =
any
objection to my patches 1-3 and 10-11 in this series going through Steve
French's cifs tree so that he can take my cifs iteratorisation patches?

Patches 1-3 would add filemap_splice_read() and direct_splice_read(), but =
not
connect them up to anything and 10-11 would add iov_iter_extract_pages(). =
 I
can then give Steve a patch to make cifs use them as part of my patches fo=
r
that.

This would only affect cifs.  See my iov-cifs branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Diov-cifs

for an example of how this would look.

David

