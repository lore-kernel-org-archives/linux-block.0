Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68292C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 10:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiGVKDu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGVKDt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 06:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25FAA54CBA
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658484227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XikMw7huSxN9xYF9wCnHL+DNUUU5UCfpipCLmE1uN00=;
        b=SCH6/WIZtNslE92eycDjxs81ebPudIC59W/NU3+NBwJDNMntaDeBlChAHZ8SxXnAMNo0G0
        Z6n2gy6RM+AsktNHyDVi7W+MnwN4zHc7Cm4znOyTPPTw1B+dGmAyu4lR3cV273gqy/msD9
        qrtQtXQClKrW+2qKJ0a0GE+wWGx6c/8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-Iq8ZpeUGNlOliFZ8nGJh0Q-1; Fri, 22 Jul 2022 06:03:41 -0400
X-MC-Unique: Iq8ZpeUGNlOliFZ8nGJh0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68BC2811E76;
        Fri, 22 Jul 2022 10:03:41 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1CFB2026D64;
        Fri, 22 Jul 2022 10:03:37 +0000 (UTC)
Date:   Fri, 22 Jul 2022 18:03:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V3 2/2] ublk_drv: make sure that correct flags(features)
 returned to userspace
Message-ID: <Ytp18+v8gwQk2SpQ@T590>
References: <20220722084516.624457-1-ming.lei@redhat.com>
 <20220722084516.624457-3-ming.lei@redhat.com>
 <20220722095319.GA13942@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722095319.GA13942@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 22, 2022 at 11:53:19AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 22, 2022 at 04:45:16PM +0800, Ming Lei wrote:
> >  	/* We are not ready to support zero copy */
> > +	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
> 
> Nit: I'd move this below the clearing of UBLK_F_ALL.  Not because it
> makes much of a differece, but because it flows more logical.

OK.

> 
> > +/* All UBLK_F_* have to be included into UBLK_F_ALL */
> > +#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_URING_CMD_COMP_IN_TASK)
> 
> And this should not be in the uapi header but only kernel internal.

Yeah, but that may cause UBLK_F_ALL not updated easily, :-(


Thanks,
Ming

