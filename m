Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A0EEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 00:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjFUALD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 20:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFUALC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 20:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF14810F1
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 17:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687306214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iH25GN8X3LsVgQP0MS+L84U1GQXae5Y6ao4JIVTErZ4=;
        b=Uo8gap/Ru7B6lUNTM8vZa9yE4FriRNbsKX2dUEfxJMWqy1EXzAmMdT+qffMNIdnVwStt4J
        p7KA+xz0SxTMrnZBq45QMJz62xioeon5kqoLsg3TaRdmRzvPfi1+6IqCadQTP8f+LmQNQX
        axHCTxV9L41fxng7BQbPD3G1xL6rm1Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-8Adca8xZP8ivkXME51V3PQ-1; Tue, 20 Jun 2023 20:10:10 -0400
X-MC-Unique: 8Adca8xZP8ivkXME51V3PQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B823809F8F;
        Wed, 21 Jun 2023 00:10:09 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5C7D492C13;
        Wed, 21 Jun 2023 00:10:04 +0000 (UTC)
Date:   Wed, 21 Jun 2023 08:09:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 20, 2023 at 04:40:49PM +0300, Sagi Grimberg wrote:
> 
> > > > Hello,
> > > > 
> > > > The 1st three patch fixes io hang when controller removal interrupts error
> > > > recovery, then queue is left as frozen.
> > > > 
> > > > The 4th patch fixes io hang when controller is left as unquiesce.
> > > 
> > > Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
> > > connect patches?
> > 
> > I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
> > extra maintain burden wrt. error handling, but looks Keith worries about the
> > delay freezing may cause too many requests queued during error handling, and
> > that might cause user report.
> 
> For nvme-tcp/rdma your patch also addresses IO not failing over because
> they block on queue enter. So I definitely want this for fabrics.

The patch in the following link should fix these issues too:

https://lore.kernel.org/linux-block/ZJGmW7lEaipT6saa@ovpn-8-23.pek2.redhat.com/T/#u

I guess you still want the paired freeze patch because it makes freeze &
unfreeze more reliable in error handling. If yes, I can make one fabric
only change for you.


Thanks,
Ming

