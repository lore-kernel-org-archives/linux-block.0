Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC089C77B76
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 21:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDLVqm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLVql (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 17:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7F59C1
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 14:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681335949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ilGBHufiMuaxBpgsvUmfNQz6PArJGM0NKDutiuuFlQ=;
        b=KGzgggi0J12RboH44/FttBW8TdtLqtnX5xius8+r1dTRKpSssyri/OivRvUkXkHezC3bXx
        kwdKpWLV8yCiCiqQxLeqYfGLokD7klnf2brrFpMEhQ6hdXI7LxsmsNgpm5GIQnwiXlETfO
        tNzYtbBmXsCCBKCox05iQYCZG9fAJN0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-Xgs_wkh3NcKNsJv-O4nu6Q-1; Wed, 12 Apr 2023 17:45:44 -0400
X-MC-Unique: Xgs_wkh3NcKNsJv-O4nu6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 784D43C10EC1;
        Wed, 12 Apr 2023 21:45:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6BC61121320;
        Wed, 12 Apr 2023 21:45:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230403142543.1913749-3-hch@lst.de>
References: <20230403142543.1913749-3-hch@lst.de> <20230403142543.1913749-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] iov_iter: remove iov_iter_get_pages_alloc
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <394965.1681335943.1@warthog.procyon.org.uk>
Date:   Wed, 12 Apr 2023 22:45:43 +0100
Message-ID: <394966.1681335943@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> -EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
> +EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc2);

This is not within the description of the patch and should probably be a
separate patch.

David

