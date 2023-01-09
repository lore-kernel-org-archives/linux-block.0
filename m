Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF044C54EBE
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 09:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjAIJcR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 04:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjAIJcQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 04:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403E640C
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 01:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673256680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJS8ger7BTpdH0Zhir+ATtsgZEkWNY0AkL185k+a0FI=;
        b=XZ/Roe3vWkCOb9W8QDVfBbaDbHqcB0xk0pl63aDARPrMfW0gGY0/do3P2D2tTNi6kIXwS4
        Nsi6x0037ieAC0y0aotg59xF3s7g5fvnz9ZzDkoL6o8Qk4A2RyVRfvdO5VHYciRtZPf+Hh
        rhubJTUIwGjEPUfCrST7nI+PZJpX1Lk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-RiSvjASXMw-KMNZD3ZDwmA-1; Mon, 09 Jan 2023 04:31:15 -0500
X-MC-Unique: RiSvjASXMw-KMNZD3ZDwmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B338101A52E;
        Mon,  9 Jan 2023 09:31:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0753BC16026;
        Mon,  9 Jan 2023 09:31:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230108171241.GA20314@lst.de>
References: <20230108171241.GA20314@lst.de> <20230105190741.2405013-1-kbusch@meta.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Keith Busch <kbusch@meta.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, davem@davemloft.net,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 00/12] iov_iter: replace import_single_range with ubuf
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1880280.1673256668.1@warthog.procyon.org.uk>
Date:   Mon, 09 Jan 2023 09:31:08 +0000
Message-ID: <1880281.1673256668@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

lore.kernel.org doesn't seem to have the patches.

https://lore.kernel.org/lkml/20230105190741.2405013-1-kbusch@meta.com/

David

