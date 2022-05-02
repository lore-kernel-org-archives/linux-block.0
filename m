Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED2CC433EF
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 16:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiEBQHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 12:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386255AbiEBQHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 12:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB1ECBCBA
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651507436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88yBMkg5PBuktnMXhIjfj0jtx1aNoZPEw+H6ptipEpg=;
        b=h6B21wi9cQG+t4R0b5Ge02qP94jXqQL9pq/Y+Lp1MUs6B/f3qr9eSJ6aVh1c4k1o66iq6U
        gY7hwcfBn9LMMLhcQU1mwIBgG+hqMyY3ck+BF2COg5iCpVaZvZIF2NlwtmVaFUbw4br5VA
        /9nPYHGnnhE0TUVriytuDCr4CtGrnIo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-PjHWFfqePjGDaXX7HIT67A-1; Mon, 02 May 2022 12:03:51 -0400
X-MC-Unique: PjHWFfqePjGDaXX7HIT67A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D7791014A61;
        Mon,  2 May 2022 16:03:51 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19DB6111E3EC;
        Mon,  2 May 2022 16:03:43 +0000 (UTC)
Date:   Tue, 3 May 2022 00:03:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] Revert "block: release rq qos structures for queue
 without disk"
Message-ID: <YnAA2sECNH50KDDT@T590>
References: <20220426024936.3321341-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426024936.3321341-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 26, 2022 at 10:49:36AM +0800, Ming Lei wrote:
> This reverts commit daaca3522a8e67c46e39ef09c1d542e866f85f3b.
> 
> Commit daaca3522a8e ("block: release rq qos structures for queue without
> disk") is only needed for v5.15~v5.17, and isn't needed for v5.18, so
> revert it.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Hello Guys,

Ping...


Thanks,
Ming

