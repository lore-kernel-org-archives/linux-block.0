Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10528C636CC
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 17:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBMRQO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 12:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBMRQO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 12:16:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4091E5F6
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 09:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676308524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lOkMPiRsM3su8G8btqTABKq0jq916HIkb564+wSAHZY=;
        b=Jc04plX+CV/T4afJamV6iqGQi3W8RsBUdmPg2m4kzQlj7IGdUWqSUM/oc4WuC+chNBw8IX
        Yti3UCtCyGOw85cfVtU9//spHQcgZpi90eDfIClpMeI8iuCTdqFZ0swpPJ23RuFG52jmLF
        A0gB/9XtNgXPXRmlIMx2k6g7rcpjDB0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-i8k1n6HjNNe-lzbx8dv4Xw-1; Mon, 13 Feb 2023 12:15:19 -0500
X-MC-Unique: i8k1n6HjNNe-lzbx8dv4Xw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5B321C0896E;
        Mon, 13 Feb 2023 17:15:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7192F2026D4B;
        Mon, 13 Feb 2023 17:15:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+pdHFFTk1TTEBsO@makrotopia.org>
References: <Y+pdHFFTk1TTEBsO@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: regression in next-20230213: "splice: Do splice read from a buffered file without using ITER_PIPE"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2344207.1676308516.1@warthog.procyon.org.uk>
Date:   Mon, 13 Feb 2023 17:15:16 +0000
Message-ID: <2344208.1676308516@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Daniel Golle <daniel@makrotopia.org> wrote:

> I'm Currently trying linux-next daily on various MediaTek ARM64 SoCs.
> As of next-20230213 I'm now facing this bug:

Do you have any information about what the machine was using as the source and
destination of sendfile()?  What filesystem was involved?  It looks like it
was doing a cat.

> [   30.379325]  filemap_get_pages+0x254/0x604

Would you also be able to find out what line that was on?

David

