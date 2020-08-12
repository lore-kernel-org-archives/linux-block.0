Return-Path: <SRS0=wHaM=BW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB3AC433E1
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 12:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE5622B4B
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 12:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8TH++Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHLMr2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727885AbgHLMr2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 08:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597236447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJ+bto3hsBFNbeIoX6uybLtb1Yx2r+7qubJDKxuEY7w=;
        b=Q8TH++Ru7lMUZswIGSHdySwOhVhCYkGmgJtsXPqwBXZdE6RjY3zHbRyGLUYX+pYZGf8CWl
        8P0PtfwA740Xz1k/Sh56ZuG5EaJDM8NbVOzFfN3b8rsuDGfQR3+tsBccxwTEpQr7RJ0PCV
        qnJKva6k9ABzQ/JbeZFz2B3h1PRcj1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-wYCtx2zNM0q_EUiaEFCHhA-1; Wed, 12 Aug 2020 08:47:25 -0400
X-MC-Unique: wYCtx2zNM0q_EUiaEFCHhA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E23AB107ACCA;
        Wed, 12 Aug 2020 12:47:23 +0000 (UTC)
Received: from T590 (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9193600DA;
        Wed, 12 Aug 2020 12:47:16 +0000 (UTC)
Date:   Wed, 12 Aug 2020 20:47:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH] block: allow for_each_bvec to support zero len bvec
Message-ID: <20200812124712.GA2331687@T590>
References: <20200810031915.2209658-1-ming.lei@redhat.com>
 <db57f8ca-b3c3-76ec-1e49-d8f8161ba78d@i-love.sakura.ne.jp>
 <20200810162331.GA2215158@T590>
 <20200812090039.GA2317340@T590>
 <242fc33d-686b-928d-415e-8b519c56a62c@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <242fc33d-686b-928d-415e-8b519c56a62c@i-love.sakura.ne.jp>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 07:03:59PM +0900, Tetsuo Handa wrote:
> On 2020/08/12 18:00, Ming Lei wrote:
> > BTW, for_each_bvec won't be called in the above splice test code.
> 
> Please uncomment the // lines when testing for_each_bvec() case.

What is the '//' lines?

> This is a test case for testing all empty pages.

But the case for testing all empty pages is not related with this patch,
is it?


Thanks,
Ming

