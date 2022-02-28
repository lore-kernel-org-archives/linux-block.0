Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B0EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 06:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiB1GMk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 01:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiB1GMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 01:12:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E64F66ACC
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 22:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646028720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=koDNyhpZRRWUbZFhH9KWUoWf+UDX5NXH16ZSUqLPEwY=;
        b=KygYL8GXXMd9+htAZDQw0Ye1IVMuKEi+xcQAUW/kppRaQoKqzAc++g8yMGwOpo9hTxXmBg
        VjSswtEUvC7ByJf/hThqHvRBnmiPxQRVBKqX086L07KgMPZH1i066U26xPi/xP1jtPeEVS
        Oz2EP75izlM1CZYn7b8Che1k/l3LoFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-ks5XyE6KNN-Cmhjz6i-Eiw-1; Mon, 28 Feb 2022 01:11:58 -0500
X-MC-Unique: ks5XyE6KNN-Cmhjz6i-Eiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D747800422;
        Mon, 28 Feb 2022 06:11:56 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C84D5DBBD;
        Mon, 28 Feb 2022 06:11:35 +0000 (UTC)
Date:   Mon, 28 Feb 2022 14:11:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
Message-ID: <Yhxnkg0AEaj36t+a@T590>
References: <20220210115637.1074927-1-yukuai3@huawei.com>
 <YhuyBgZSS6m/Mwu6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhuyBgZSS6m/Mwu6@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Sun, Feb 27, 2022 at 09:16:54AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 07:56:37PM +0800, Yu Kuai wrote:
> > Throttled bios can't be issued after del_gendisk() is done, thus
> > it's better to cancel them immediately rather than waiting for
> > throttle is done.
> > 
> > For example, if user thread is throttled with low bps while it's
> > issuing large io, and the device is deleted. The user thread will
> > wait for a long time for io to return.
> 
> FYI, this crashed left rigt and center when running xfstests with
> traces pointing to throtl_pending_timer_fn.

Can you share the exact xfstests test(fs, test)? Or panic log?

I can't reproduce it when running './check -g auto' on XFS, meantime
tracking throtl_pending_timer_fn().


Thanks,
Ming

