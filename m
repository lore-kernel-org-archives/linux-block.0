Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D5E9371B
	for <linux-block@archiver.kernel.org>; Sat,  7 Oct 2023 07:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbjJGHaN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Oct 2023 03:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343709AbjJGHaM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Oct 2023 03:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D265DE9
        for <linux-block@vger.kernel.org>; Sat,  7 Oct 2023 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696663764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P2XYj63JutQ2NopEHr3614ehw4VQD2DCO6wPQwn2C2A=;
        b=fF2gTVqKhCMw8tn+VTfkd4YlXFFKXVkHJhpoyX4w+9zV3eL/T9m4l+hVod/d6XsGHvs4DU
        actVjiwvkMJy0GI5h80j8Mf8MDJ+8ZqpdZUyoo6wORMMVF4mEgwtp94c6825T7mNC0ta6N
        4hThjnpMCKYKZ8NIGiSJeAX/zZ9s/rc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-Id4xzfQGNO-7JeT9k6sb-w-1; Sat, 07 Oct 2023 03:29:18 -0400
X-MC-Unique: Id4xzfQGNO-7JeT9k6sb-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A24B8380200F;
        Sat,  7 Oct 2023 07:29:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D59FCC15BB8;
        Sat,  7 Oct 2023 07:29:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <356ef449-44bf-539f-76c0-7fe9c6e713bb@google.com>
References: <356ef449-44bf-539f-76c0-7fe9c6e713bb@google.com> <20230925120309.1731676-9-dhowells@redhat.com> <20230925120309.1731676-1-dhowells@redhat.com> <1809398.1696238751@warthog.procyon.org.uk>
To:     Hugh Dickins <hughd@google.com>
Cc:     dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] iov_iter: fix copy_page_from_iter_atomic()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <231154.1696663754.1@warthog.procyon.org.uk>
Date:   Sat, 07 Oct 2023 08:29:14 +0100
Message-ID: <231155.1696663754@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hugh Dickins <hughd@google.com> wrote:

> -		__copy_from_iter(p, n, i);
> +		n = __copy_from_iter(p, n, i);

Yeah, that looks right.  Can you fold it in, Christian?

David

