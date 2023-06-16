Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B5FEB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 09:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjFPJro (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 05:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjFPJrj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 05:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEB6119
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686908814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LbHOKemj3x3i/RRfgL4O8FQ7JtEapB4R9zBWaNJlTbY=;
        b=WDdfGkD9qoirt+eavXogAa1jWMpu0lWjK3gih11JNXh/4i5TYtffdHYvD9ChqR3zAdmlXS
        zUq/c225EeMvoEVU78f6fGqRpvrvQgl6Vz0wqNySzjCIh9yVhwTuaBMDHnUOwdteappGrI
        BBOkBNiOf4T2mvSQMYP7H6SpVk7z0yE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-7irUyZ8YNuW6mBiU_L1P6A-1; Fri, 16 Jun 2023 05:46:51 -0400
X-MC-Unique: 7irUyZ8YNuW6mBiU_L1P6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9F57101A528;
        Fri, 16 Jun 2023 09:46:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 124CDC1604C;
        Fri, 16 Jun 2023 09:46:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230614140341.521331-1-hch@lst.de>
References: <20230614140341.521331-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: dio / splice fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <423966.1686908809.1@warthog.procyon.org.uk>
Date:   Fri, 16 Jun 2023 10:46:49 +0100
Message-ID: <423967.1686908809@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: David Howells <dhowells@redhat.com>

