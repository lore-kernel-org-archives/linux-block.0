Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D3EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 13:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjFTN0G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjFTNZq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 09:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE1419AD
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687267433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vnjEXreH0/b3cB4UY+FUlsrwX6QWE/ExjGOEW3daVI=;
        b=Dyd3n99H+AQsCPoKkQGM8NkJ3WLz1L3cYGkiAojLEyK713va3wnujayTBq0tkpUv1uDUwa
        LF14o1mC9P8YXXuan4Ktz6/3g4e3GzMfkxGo71OD4WFXLMmtz8se+ov/Hw3wk2d5CnfJm0
        7IDgJpNV0ZHHieI6awisXahEv6jDml4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-AjoKta6FN1SRDXonwpNjKQ-1; Tue, 20 Jun 2023 09:23:49 -0400
X-MC-Unique: AjoKta6FN1SRDXonwpNjKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EED528EC100;
        Tue, 20 Jun 2023 13:23:45 +0000 (UTC)
Received: from ovpn-8-23.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 126D7C1ED97;
        Tue, 20 Jun 2023 13:23:40 +0000 (UTC)
Date:   Tue, 20 Jun 2023 21:23:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 20, 2023 at 01:04:33PM +0300, Sagi Grimberg wrote:
> 
> > Hello,
> > 
> > The 1st three patch fixes io hang when controller removal interrupts error
> > recovery, then queue is left as frozen.
> > 
> > The 4th patch fixes io hang when controller is left as unquiesce.
> 
> Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
> connect patches?

I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
extra maintain burden wrt. error handling, but looks Keith worries about the
delay freezing may cause too many requests queued during error handling, and
that might cause user report.


Thanks, 
Ming

