Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC75C001DC
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 20:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjGSUPw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 16:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSUPw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 16:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487411D
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689797699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i6ZhaRI5kYBWvhEEAehFGNb99U2brkCjIUko9EG3KFI=;
        b=JXixMtZMTc7ZoliLpUSIOhtFv5jX0TiJLs2zrHBxN85TBuXzm2pwhN+s0kSfLqUuG0IDDG
        BZqkCd+uMXvIC6msNn8qw3fGXDabupO6NOaEUFodQL7iwj5eQGbr7kCO87K5UOYsP2OiJ6
        SjKosd/PYw+Hu80vb84WA3zzT7B6RdA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-J0zbjiU1NleADOGTvSN-WA-1; Wed, 19 Jul 2023 16:14:58 -0400
X-MC-Unique: J0zbjiU1NleADOGTvSN-WA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAAD4101146C;
        Wed, 19 Jul 2023 20:14:57 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE3DAC2C862;
        Wed, 19 Jul 2023 20:14:57 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 981123096A42; Wed, 19 Jul 2023 20:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 8CFF13F7CF;
        Wed, 19 Jul 2023 22:14:57 +0200 (CEST)
Date:   Wed, 19 Jul 2023 22:14:57 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v2 3/4] brd: enable discard
In-Reply-To: <2ade2716-d875-5e4c-82ce-c4c7f00f1bbc@kernel.dk>
Message-ID: <cbc2e578-51d3-3e75-b61-734117d7fce6@redhat.com>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2209201358120.26535@file01.intranet.prod.int.rdu2.redhat.com> <ace0451f-b979-be13-cf47-a8cb3656c72e@huaweicloud.com> <4b6788d2-c6e1-948-22d-dbb7cbba657d@redhat.com>
 <2ade2716-d875-5e4c-82ce-c4c7f00f1bbc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Mon, 10 Jul 2023, Jens Axboe wrote:

> When a series is posted and reviewers comment on required changes, I
> always wait for a respin of that series with those addressed. That
> didn't happen, so this didn't get applied.
> 
> -- 
> Jens Axboe

Hi

I updated the brd discard patches so that they apply to the kernel 
6.5-rc1. I'm submitting them for review.

Mikulas

