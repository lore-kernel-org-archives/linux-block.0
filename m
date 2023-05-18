Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA09BC77B7A
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 03:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjERDAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 23:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjERDAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 23:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C991BC
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684378762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMAu6twEmtswYA8qITtMS+FLR6ODJ0Jw07dSOREZSbc=;
        b=iBk6va/4gF0v3cAiD48d4KB1e9sCvL7PThzbLBaH/3hFzVOg7g3n/CNhlTc6e6xCSXvQtU
        i0uYDyL1YBBeT6OXBH7eHy6pe4Tys1gk8HVueErl0J+h+rMtJ532EWhzekBTHgwyIfA6o2
        vnL3ICFH3uMor3jWOrXHpZpk4rn1aZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-KmfCUeypMa-yn3li6xcKMg-1; Wed, 17 May 2023 22:59:19 -0400
X-MC-Unique: KmfCUeypMa-yn3li6xcKMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28AE385A5A3;
        Thu, 18 May 2023 02:59:19 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63A701427AE4;
        Thu, 18 May 2023 02:59:14 +0000 (UTC)
Date:   Thu, 18 May 2023 10:59:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH] ublk: fix AB-BA lockdep warning
Message-ID: <ZGWUfv+g6EOw/pI2@ovpn-8-16.pek2.redhat.com>
References: <20230517133408.210944-1-ming.lei@redhat.com>
 <a57cn4zqgxm5hds2ekgg2y5jbfd4bgwoujimit7enm6eh5wo56@hftyn26mv3aq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a57cn4zqgxm5hds2ekgg2y5jbfd4bgwoujimit7enm6eh5wo56@hftyn26mv3aq>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 18, 2023 at 02:01:17AM +0000, Shinichiro Kawasaki wrote:
> On May 17, 2023 / 21:34, Ming Lei wrote:
> > When handling UBLK_IO_FETCH_REQ, ctx->uring_lock is grabbed first, then
> > ub->mutex is acquired.
> > 
> > When handling UBLK_CMD_STOP_DEV or UBLK_CMD_DEL_DEV, ub->mutex is
> > grabbed first, then calling io_uring_cmd_done() for canceling uring
> > command, in which ctx->uring_lock may be required.
> > 
> > Real deadlock only happens when all the above commands are issued from
> > same uring context, and in reality different uring contexts are often used
> > for handing control command and IO command.
> > 
> > Fix the issue by using io_uring_cmd_complete_in_task() to cancel command
> > in ublk_cancel_dev(ublk_cancel_queue).
> > 
> > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Closes: https://lore.kernel.org/linux-block/becol2g7sawl4rsjq2dztsbc7mqypfqko6wzsyoyazqydoasml@rcxarzwidrhk
> > Cc: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Using Ziyang's new blktests test cases, I confirmed this patch avoids the
> failure I reported. Thanks.
> 
> Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Shinichiro, Thanks for the test!

-- 
Ming

