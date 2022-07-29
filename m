Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9989BC00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 15:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiG2PC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiG2PC0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 11:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9B5D95A8
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659106940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XwEOPU0Ky5mfrvHwCaJp8K+/RLowYn3g0BFMbVBbsgM=;
        b=cCXUrrV0WxQTZvLzRX9IVkDg1eO79fP4vv7LL3kxgN8e7yD08r1eEJiEUySbHiqOVpW43V
        1EQlxy/o7UZY778jnFMs7gviGZbEGz3SUC5NgisyiAlViQGPz4gwCa11dnsREZuwGQguYx
        Jb3kTZwP4OjtyBiJgyd0Svm1fgncTeY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-iL6BawrMMz6OUjifMrBMKQ-1; Fri, 29 Jul 2022 11:02:15 -0400
X-MC-Unique: iL6BawrMMz6OUjifMrBMKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80C3738217FA;
        Fri, 29 Jul 2022 15:02:12 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04C7418EB7;
        Fri, 29 Jul 2022 15:02:08 +0000 (UTC)
Date:   Fri, 29 Jul 2022 23:02:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V3 5/5] ublk_drv: cleanup ublksrv_ctrl_dev_info
Message-ID: <YuP2a8EzUEAi4S5m@T590>
References: <20220729072954.1070514-1-ming.lei@redhat.com>
 <20220729072954.1070514-6-ming.lei@redhat.com>
 <20220729142431.GE32321@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729142431.GE32321@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 29, 2022 at 04:24:31PM +0200, Christoph Hellwig wrote:
> On Fri, Jul 29, 2022 at 03:29:54PM +0800, Ming Lei wrote:
> > Remove all block device related info from ublksrv_ctrl_dev_info,
> > meantime reduce its size into 64 bytes because:
> > 
> > 1) ublksrv_ctrl_dev_info becomes cleaner without including any
> > block related info
> > 
> > 2) generic set/get parameter command can be used to set block
> > related setting easily and cleanly
> > 
> > 3) generic set/get parameter command can be used for extending
> > ublk without needing more info in ublksrv_ctrl_dev_info
> 
> This should condense the structure instead of spreading random
> reserveѕ.
> 
> One more reason why we should not just merge half-baked UAPIs before
> a few good rounds of review :(

This patch does depend on set/get parameter(s) command.



Thanks,
Ming

