Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B3C636CD
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 10:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjBGKpo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 05:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjBGKpn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 05:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704253AAD
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 02:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675766696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cReNp7hDj843BCfXnq5z9fX/qXUWLWCg2gp8gMVVH90=;
        b=YrPeacCcdot0Wx5PBnTwWDLlaLXlA6dXtmcHBV2ByljtW5+dnqKxYdmZ2P8XZzRvlbFUPq
        XmwJ6IUmyrAEG7/Ta7ZabInRSSYqC8I4BQIFa8qjq3+bwsQ2RUXTVvFef+ftvJmWHve6aF
        f1PTDanMzlJHjpyWcZDq57BkrHOvZO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-iHOssuylNCGAnJ8sr6nDAw-1; Tue, 07 Feb 2023 05:44:51 -0500
X-MC-Unique: iHOssuylNCGAnJ8sr6nDAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E73C6800050;
        Tue,  7 Feb 2023 10:44:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 969A240398A0;
        Tue,  7 Feb 2023 10:44:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230207094731.1390-1-hdanton@sina.com>
References: <20230207094731.1390-1-hdanton@sina.com> 
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Need help tracking down a bug in the bio-FOLL_PIN patches
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3024112.1675766689.1@warthog.procyon.org.uk>
Date:   Tue, 07 Feb 2023 10:44:49 +0000
Message-ID: <3024113.1675766689@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hillf Danton <hdanton@sina.com> wrote:

> 	pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
> 	iov_iter_revert.part.0+0x402/0x730 lib/iov_iter.c:935
> 	iov_iter_revert+0x4c/0x60 lib/iov_iter.c:919

Yeah.  That seems to be the problem.

Thanks,
David

