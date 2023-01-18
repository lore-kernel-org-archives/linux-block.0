Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A0C38159
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 23:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjARXZp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjARXZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 18:25:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEDB15563
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2023 15:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674084298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AW3tkCBDUNfgbMADK1c0JyGSAze/ydEol1BmkC/mn3o=;
        b=W/AxWfuWRWHt52b12g1ILvkUitHvaBUNqZ+PS7+RmWMALRbHzmD6SNlN4NCjC4jb2BMV4Y
        3jUF+s4dp5HtXuwxOykrhVWKi/fSEWzN8vC7vB+1avE3b9SCk3UFFYvyxo6bJnrWvAPPXP
        fNs5fAXVYR08sb3bZCZEt2btNRmb4b8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-DkfEEPfdMxiNAOry4-loeQ-1; Wed, 18 Jan 2023 18:24:53 -0500
X-MC-Unique: DkfEEPfdMxiNAOry4-loeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6395A811E6E;
        Wed, 18 Jan 2023 23:24:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2522840C6EC4;
        Wed, 18 Jan 2023 23:24:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8h+naEJmlxIjyh1@ZenIV>
References: <Y8h+naEJmlxIjyh1@ZenIV> <Y8h9Q9fyUGBFsiMj@ZenIV> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391051810.2311931.8545361041888737395.stgit@warthog.procyon.org.uk> <2704044.1674083861@warthog.procyon.org.uk>
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
Content-ID: <2704402.1674084290.1@warthog.procyon.org.uk>
Date:   Wed, 18 Jan 2023 23:24:50 +0000
Message-ID: <2704405.1674084290@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> > Compile time type checking.
> 
> Huh?  int-to-enum conversion is quiet; it would catch explicit
> huge constants, but that's it...

*shrug*.

But can we at least get rid of the:

	iov_iter_foo(&iter, ITER_SOURCE, ...);

	WARN_ON(direction & ~(READ | WRITE));

mismatch?  Either use ITER_SOURCE/DEST or use READ/WRITE but not mix them.

David

