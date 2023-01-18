Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA9DC38147
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 23:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjARXSo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjARXSh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 18:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0855298C3
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 15:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674083868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hg2jXXAtk6m9gvEb3I0IOZBD7jFgu2O5sybYB7vcpUY=;
        b=clfg0dOjJmaIwcz6mDQDgnVeLPp6+uDnt87RWxaSpFsKCmz0AzpkgSShRQSeC1Z3wOxkfc
        mTKbcJICdH77gEAPRlPmkd7wzDa80H4M/waNdFblpeNCa00v03kWUtF/9Nu6lcyXfTHxu8
        zbwF3nHLbdHawDKWv37oOVh58n0nUo4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-URabi9yEOai8HsPbnJJJSg-1; Wed, 18 Jan 2023 18:17:45 -0500
X-MC-Unique: URabi9yEOai8HsPbnJJJSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BC5380D0E3;
        Wed, 18 Jan 2023 23:17:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12C3CC15BAD;
        Wed, 18 Jan 2023 23:17:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8h9Q9fyUGBFsiMj@ZenIV>
References: <Y8h9Q9fyUGBFsiMj@ZenIV> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391051810.2311931.8545361041888737395.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/34] iov_iter: Change the direction macros into an enum
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2704043.1674083861.1@warthog.procyon.org.uk>
Date:   Wed, 18 Jan 2023 23:17:41 +0000
Message-ID: <2704044.1674083861@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> > Change the ITER_SOURCE and ITER_DEST direction macros into an enum and
> > provide three new helper functions:
> > 
> >  iov_iter_dir() - returns the iterator direction
> >  iov_iter_is_dest() - returns true if it's an ITER_DEST iterator
> >  iov_iter_is_source() - returns true if it's an ITER_SOURCE iterator
> 
> What for?  We have two valid values -
> 	1) it is a data source
> 	2) it is not a data source
> Why do we need to store that as an enum?

Compile time type checking.

David

