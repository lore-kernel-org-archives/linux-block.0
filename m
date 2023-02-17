Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B819BC05027
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 21:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjBQVZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQVZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 16:25:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2081564B22
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 13:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676669052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Trjzm8ZWw6cjkiLB0AQG3kmzyvYnM9q+Ge20cw7wo3o=;
        b=M34clm0EV4pWLCUeiIvbsptSUGK5PuWfQ6w5oNtkqzPBvoAuEeY3eEorL/5Lisulj4rIfo
        jtVzuKpqQdEwpXolZzCWlFuKNBE/yQ69D4vE89CCL3baoOi1amCI1kl1q+Hw0dd4t1Tszh
        Kk1f814hj6N8m0DqywW6FVoLNcUyYnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-mfu97Z-QNhSLEguEUvwFOQ-1; Fri, 17 Feb 2023 16:24:07 -0500
X-MC-Unique: mfu97Z-QNhSLEguEUvwFOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDB9F802314;
        Fri, 17 Feb 2023 21:24:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B59F40CF8EC;
        Fri, 17 Feb 2023 21:24:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <877cwgknyi.fsf@oc8242746057.ibm.com>
References: <877cwgknyi.fsf@oc8242746057.ibm.com>
To:     egorenar@linux.ibm.com
Cc:     dhowells@redhat.com, axboe@kernel.dk, david@redhat.com,
        hch@infradead.org, hch@lst.de, hdanton@sina.com, jack@suse.cz,
        jgg@nvidia.com, jhubbard@nvidia.com, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        logang@deltatee.com, viro@zeniv.linux.org.uk, willy@infradead.org,
        mhartmay@linux.ibm.com
Subject: Re: [PATCH v14 08/17] splice: Do splice read from a file without using ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <687039.1676669042.1@warthog.procyon.org.uk>
Date:   Fri, 17 Feb 2023 21:24:02 +0000
Message-ID: <687040.1676669042@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

egorenar@linux.ibm.com wrote:

>  [ 5157.233284]  [<0000000000000002>] 0x2 
>  [ 5157.233288]  [<000000001f694e26>] filemap_get_pages+0x276/0x3b0 

Yeah.  I think this was fixed by the provision of a shmem-specific splice read
(patch 04/17 in this series).

David

