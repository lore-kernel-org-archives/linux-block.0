Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F53EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 09:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbjFPJp7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 05:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343871AbjFPJpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 05:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C0C2962
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686908657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5HHb+RijuBYUUAeX+OW1B0govjHPtAHjE07ibhohWc=;
        b=DA2i6+Ypq5+4xrQn/AMUe8vSJUpCMZfOH348hd+fP0Ao5c9ubYTxJT6apjBzxPG58gbxh7
        cFcm/fm83qOQH/QUuj6irE20QOB/L9H82ABNi0JZe+HeI7wOosL+XApYoW4vhr/Q2wzHkO
        x4gRgn3KDu1NEdQXyXfRWyBGjiXyDy0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-NJUxqzZTMt-QwwQlrF79tQ-1; Fri, 16 Jun 2023 05:44:12 -0400
X-MC-Unique: NJUxqzZTMt-QwwQlrF79tQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 646BA101A529;
        Fri, 16 Jun 2023 09:44:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05B2E141510A;
        Fri, 16 Jun 2023 09:44:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230614140341.521331-3-hch@lst.de>
References: <20230614140341.521331-3-hch@lst.de> <20230614140341.521331-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] splice: simplify a conditional in copy_splice_read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <423891.1686908650.1@warthog.procyon.org.uk>
Date:   Fri, 16 Jun 2023 10:44:10 +0100
Message-ID: <423892.1686908650@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> +	if (ret == -EFAULT)

I wonder if that should be prefaced with "else".  On the other hand, the
optimiser ought to spot that it's mutually exclusive with the prior "if".

David

