Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA84C77B7C
	for <linux-block@archiver.kernel.org>; Tue,  2 May 2023 01:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjEBBQz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 21:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjEBBQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 21:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AD135B8
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682990158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2vYY4aISnTr4IOzweVvK23joWn0EY/HNOKyYxxJLg4=;
        b=QeJjlBqorwmNrEwiD697iVn3KS5w+dNtKvoaxdl9MIKHqg+KfQohJEt4sxIhsXWqG0G9nC
        6dme7IqdOTGhW3nhCs1iCdq83IFw0wzYiACOqYUVL3vSVxHLgJXlKxnA+V7EUDUL+2dvel
        0rll3OCLVyimg8QsmTFL3xIEV/sl84o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-TbZogi_BM4aS2m7mLXYknA-1; Mon, 01 May 2023 21:15:57 -0400
X-MC-Unique: TbZogi_BM4aS2m7mLXYknA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CD29101A550;
        Tue,  2 May 2023 01:15:57 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4143540C6E67;
        Tue,  2 May 2023 01:15:50 +0000 (UTC)
Date:   Tue, 2 May 2023 09:15:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: add timeout handler
Message-ID: <ZFBkQtQ9lm9PU/eq@ovpn-8-16.pek2.redhat.com>
References: <20230502010150.878696-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502010150.878696-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 02, 2023 at 09:01:50AM +0800, Ming Lei wrote:
> Add timeout handler, so that we can provide forward progress guarantee for
> unprivileged ublk, which can't be trusted.
> 
> One thing is that sync() calls sync_bdevs(wait) for all block devices after
> running sync_bdevs(no_wait), and if one device can't move on, the sync() won't
> return any more.
> 
> Add timeout for unprivileged ublk to avoid such affect for other users which call
> sync() syscall.
> 

We need to clear UBLK_F_USER_RECOVERY_REISSUE for unprivileged ublk,
please ignore this patch, and will send V2.


Thanks,
Ming

